//
//  JRCodeEncryptOrDecrypt.m
//  HomeBox
//
//  Created by homebox on 2018/5/16.
//  Copyright © 2018年 wangxin. All rights reserved.
//

#import "JRCodeEncryptOrDecrypt.h"

@interface JRCodeEncryptOrDecrypt()

@property(nonatomic, assign)SecKeyRef publicKey;

@end

@implementation JRCodeEncryptOrDecrypt

+ (instancetype)shareCodeEncryptOrDecrypt
{
    static JRCodeEncryptOrDecrypt * coding;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coding = [[self alloc] init];
    });
    return coding;
}

- (NSString*)encryptOrDecryptWithData:(NSData *)data With3DES:(CCOperation)encryptOrDecrypt key:(NSString*)key
{
    const void * vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt){ // 解密
        NSData * decryptData = [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters]; // 从base64EncodeData中获取解密后data
        plainTextBufferSize = [decryptData length];
        vplainText = [decryptData bytes];
    }else{
        //加密
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    const void *vkey = (const void *)[key UTF8String];
    // NSString *initVec = @"init Vec";
    //const void *vinitVec = (const void *) [initVec UTF8String];
    //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
    
    NSString *result;
    if (encryptOrDecrypt == kCCDecrypt){
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    }else{
        NSData * myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        NSData * encryptData = [myData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];//取0时将生成的Base64字符串按照64个字符长度进行等分换行
        result = [[NSString alloc] initWithData:encryptData encoding:(NSUTF8StringEncoding)];
    }
    return result;
}

- (SecKeyRef)getFilePublicKey
{
    NSString * publicKeyPath = [[NSBundle mainBundle] pathForResource:@"wespace" ofType:@"cer"];
    if (publicKeyPath == nil) {
        NSLog(@"未找到文件");
        return nil;
    }
    NSData * publicKeyFileContent = [NSData dataWithContentsOfFile:publicKeyPath];
    if (publicKeyFileContent == nil) {
        NSLog(@"未能正确读取内容");
        return nil;
    }
    SecCertificateRef certificate = SecCertificateCreateWithData(kCFAllocatorDefault, ( __bridge CFDataRef)publicKeyFileContent);
    if (certificate == nil) {
        NSLog(@"未能获取证书");
        CFRelease(certificate);
        return nil;
    }
    
    SecPolicyRef policy = SecPolicyCreateBasicX509();
    SecTrustRef trust;
    OSStatus returnCode = SecTrustCreateWithCertificates(certificate, policy, &trust);
    if (returnCode != noErr) { // noErr 即 0
        CFRelease(certificate);
        CFRelease(policy);
        CFRelease(trust);
        return nil;
    }
    SecTrustResultType trustResultType;
    returnCode = SecTrustEvaluate(trust, &trustResultType);
    if (returnCode != 0) {
        CFRelease(certificate);
        CFRelease(policy);
        CFRelease(trust);
        return nil;
    }
    SecKeyRef publicKey = SecTrustCopyPublicKey(trust);
    if (publicKey == nil) {
        NSLog(@"不存在公钥");
        CFRelease(certificate);
        CFRelease(policy);
        CFRelease(trust);
        return nil;
    }
    self.publicKey = publicKey;
    CFRelease(certificate);
    CFRelease(policy);
    CFRelease(trust);
    return self.publicKey;
}

- (NSString *)encryptString:(NSString *)str
{
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return nil;
    }
    if (![[JRCodeEncryptOrDecrypt shareCodeEncryptOrDecrypt] getFilePublicKey]) {
        return nil;
    }
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    size_t block_size = SecKeyGetBlockSize(self.publicKey) * sizeof(uint8_t);
    void *outbuf = malloc(block_size);
    size_t src_block_size = block_size - 11;
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyEncrypt(self.publicKey,
                               kSecPaddingPKCS1,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {

            ret = nil;
            break;
        }else{
            [ret appendBytes:outbuf length:outlen];
        }
    }
    
    free(outbuf);
    CFRelease(self.publicKey);
    NSData * encryptData = [ret base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];//取0时将生成的Base64字符串按照64个字符长度进行等分换行
    NSString * encrStr = [[NSString alloc] initWithData:encryptData encoding:NSUTF8StringEncoding];
    return encrStr ;
}

@end

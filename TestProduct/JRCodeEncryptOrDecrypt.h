//
//  JRCodeEncryptOrDecrypt.h
//  HomeBox
//
//  Created by homebox on 2018/5/16.
//  Copyright © 2018年 wangxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface JRCodeEncryptOrDecrypt : NSObject

+ (instancetype)shareCodeEncryptOrDecrypt;

/**
 * 3DES加密/解密
 * @pram encryptOrDecrypt 加密还是解密
 * @pram key 加密或者解密的密钥
 */
- (NSString*)encryptOrDecryptWithData:(NSData *) data With3DES:(CCOperation)encryptOrDecrypt key:(NSString*)key;

/**
 * 获取文件公钥
 */
- (SecKeyRef)getFilePublicKey;

/**
 公钥加密
 @param str 需要加密的字符串
 @return 加密后的字符串(base64编码)
 */
- (NSString *)encryptString:(NSString *)str;

@end

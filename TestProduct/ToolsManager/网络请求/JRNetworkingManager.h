//
//  JRNetworkingManager.h
//  TestProduct
//
//  Created by ILS on 2018/7/27.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRNetworkingManager : NSObject


typedef NS_ENUM(NSUInteger, JRCachePolicy){
    /**只从网络获取数据，且数据不会缓存在本地*/
    JRCachePolicyIgnoreCache,
    /**只从缓存读数据，如果缓存没有数据，返回一个空*/
    JRCachePolicyCacheOnly,
    /**先从网络获取数据，同时会在本地缓存数据*/
    JRCachePolicyNetworkOnly,
    /**先从缓存读取数据，如果没有再从网络获取*/
    JRCachePolicyCacheElseNetwork,
    /**先从网络获取数据，如果没有在从缓存获取，此处的没有可以理解为访问网络失败，再从缓存读取*/
    JRCachePolicyNetworkElseCache,
    /**先从缓存读取数据，然后在从网络获取并且缓存，在这种情况下，Block将产生两次调用*/
    JRCachePolicyCacheThenNetwork
};

/**请求方式*/
typedef NS_ENUM(NSUInteger, JRRequestMethod){
    /**GET请求方式*/
    JRRequestMethodGET = 0,
    /**POST请求方式*/
    JRRequestMethodPOST,
    /**HEAD请求方式*/
    JRRequestMethodHEAD,
    /**PUT请求方式*/
    JRRequestMethodPUT,
    /**PATCH请求方式*/
    JRRequestMethodPATCH,
    /**DELETE请求方式*/
    JRRequestMethodDELETE
};

typedef NS_ENUM(NSUInteger, JRNetworkStatusType){
    /**未知网络*/
    JRNetworkStatusUnknown,
    /**无网路*/
    JRNetworkStatusNotReachable,
    /**手机网络*/
    JRNetworkStatusReachableWWAN,
    /**WiFi网络*/
    JRNetworkStatusReachableWiFi
};

typedef NS_ENUM(NSUInteger, JRRequestSerializer){
    /**设置请求数据为JSON格式*/
    JRRequestSerializerJSON,
    /**设置请求数据为二进制格式*/
    JRRequestSerializerHTTP
};

typedef NS_ENUM(NSUInteger, JRResponseSerializer) {
    /**设置响应数据为JSON格式*/
    JRResponsetSerializerJSON,
    /**设置响应数据为二进制格式*/
    JRResponseSerializerHTTP
};

/**请求的Block*/
typedef void(^JRHttpRequest)(id responseObject, NSError *error);

/**下载的Block*/
typedef void(^JRHttpDownload)(NSString *path, NSError *error);

/*上传或者下载的进度*/
typedef void(^JRHttpProgress)(NSProgress *progress);

/**网络状态Block*/
typedef void(^JRNetworkStatus)(JRNetworkStatusType status);

/**过滤缓存key*/
+ (void)setFiltrationCacheKey:(NSArray *)filtrationCacheKey;

/**设置接口根路径, 设置后所有的网络访问都使用相对路径 尽量以"/"结束*/
+ (void)setBaseURL:(NSString *)baseURL;

/** 设置接口请求头 */
+ (void)setHeadr:(NSDictionary *)heder;

/**设置接口基本参数(如:用户ID, Token)*/
+ (void)setBaseParameters:(NSDictionary *)parameters;

/**取消所有Http请求*/
+ (void)cancelAllRequest;

/**取消指定URL的Http请求*/
+ (void)cancelRequestWithURL:(NSString *)url;

/**设置请求超时时间(默认30s) */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/**是否打开网络加载菊花(默认打开)*/
+ (void)openNetworkActivityIndicator:(BOOL)open;

/**
 GET请求
 
 @param url 请求地址
 @param parameters 请求参数
 @param cachePolicy 缓存策略
 @param callback 请求回调
 */
+ (void)GETWithURL:(NSString *)url
        parameters:(NSDictionary *)parameters
       cachePolicy:(JRCachePolicy)cachePolicy
          callback:(JRHttpRequest)callback;


/**
 POST请求
 
 @param url 请求地址
 @param parameters 请求参数
 @param cachePolicy 缓存策略
 @param callback 请求回调
 */
+ (void)POSTWithURL:(NSString *)url
         parameters:(NSDictionary *)parameters
        cachePolicy:(JRCachePolicy)cachePolicy
           callback:(JRHttpRequest)callback;

/**
 HEAD请求
 
 @param url 请求地址
 @param parameters 请求参数
 @param cachePolicy 缓存策略
 @param callback 请求回调
 */
+ (void)HEADWithURL:(NSString *)url
         parameters:(NSDictionary *)parameters
        cachePolicy:(JRCachePolicy)cachePolicy
           callback:(JRHttpRequest)callback;


/**
 PUT请求
 
 @param url 请求地址
 @param parameters 请求参数
 @param cachePolicy 缓存策略
 @param callback 请求回调
 */
+ (void)PUTWithURL:(NSString *)url
        parameters:(NSDictionary *)parameters
       cachePolicy:(JRCachePolicy)cachePolicy
          callback:(JRHttpRequest)callback;



/**
 PATCH请求
 
 @param url 请求地址
 @param parameters 请求参数
 @param cachePolicy 缓存策略
 @param callback 请求回调
 */
+ (void)PATCHWithURL:(NSString *)url
          parameters:(NSDictionary *)parameters
         cachePolicy:(JRCachePolicy)cachePolicy
            callback:(JRHttpRequest)callback;


/**
 DELETE请求
 
 @param url 请求地址
 @param parameters 请求参数
 @param cachePolicy 缓存策略
 @param callback 请求回调
 */
+ (void)DELETEWithURL:(NSString *)url
           parameters:(NSDictionary *)parameters
          cachePolicy:(JRCachePolicy)cachePolicy
             callback:(JRHttpRequest)callback;


/**
 自定义请求方式
 
 @param method 请求方式(GET, POST, HEAD, PUT, PATCH, DELETE)
 @param url 请求地址
 @param parameters 请求参数
 @param cachePolicy 缓存策略
 @param callback 请求回调
 */
+ (void)HTTPWithMethod:(JRRequestMethod)method
                   url:(NSString *)url
            parameters:(NSDictionary *)parameters
           cachePolicy:(JRCachePolicy)cachePolicy
              callback:(JRHttpRequest)callback;


/**
 上传文件
 
 @param url 请求地址
 @param parameters 请求参数
 @param name 文件对应服务器上的字段
 @param filePath 文件路径
 @param progress 上传进度
 @param callback 请求回调
 */
+ (void)uploadFileWithURL:(NSString *)url
               parameters:(NSDictionary *)parameters
                     name:(NSString *)name
                 filePath:(NSString *)filePath
                 progress:(JRHttpProgress)progress
                 callback:(JRHttpRequest)callback;


/**
 上传图片文件
 
 @param url 请求地址
 @param parameters 请求参数
 @param images 图片数组
 @param name 文件对应服务器上的字段
 @param fileName 文件名
 @param mimeType 图片文件类型：png/jpeg(默认类型)
 @param progress 上传进度
 @param callback 请求回调
 */
+ (void)uploadImageURL:(NSString *)url
            parameters:(NSDictionary *)parameters
                images:(NSArray<UIImage *> *)images
                  name:(NSString *)name
              fileName:(NSString *)fileName
              mimeType:(NSString *)mimeType
              progress:(JRHttpProgress)progress
              callback:(JRHttpRequest)callback;


/**
 下载文件
 
 @param url 请求地址
 @param fileDir 文件存储的目录(默认存储目录为Download)
 @param progress 文件下载的进度信息
 @param callback 请求回调
 */
+ (void)downloadWithURL:(NSString *)url
                fileDir:(NSString *)fileDir
               progress:(JRHttpProgress)progress
               callback:(JRHttpDownload)callback;


#pragma mark -- 网络缓存

/**
 *  获取YYCache对象
 */
+ (YYCache *)getYYCache;

/**
 *  异步缓存网络数据,根据请求的 URL与parameters
 *  做Key存储数据, 这样就能缓存多级页面的数据
 *
 *  @param httpData   服务器返回的数据
 *  @param url        请求的URL地址
 *  @param parameters 请求的参数
 */
+ (void)setHttpCache:(id)httpData url:(NSString *)url parameters:(NSDictionary *)parameters;

/**
 *  根据请求的 URL与parameters 异步取出缓存数据
 *
 *  @param url        请求的URL
 *  @param parameters 请求的参数
 *  @param block      异步回调缓存的数据
 *
 */
+ (void)httpCacheForURL:(NSString *)url parameters:(NSDictionary *)parameters withBlock:(void(^)(id responseObject))block;


/**
 *  磁盘最大缓存开销大小 bytes(字节)
 */
+ (void)setCostLimit:(NSInteger)costLimit;

/**
 *  获取网络缓存的总大小 bytes(字节)
 */
+ (NSInteger)getAllHttpCacheSize;

/**
 *  获取网络缓存的总大小 bytes(字节)
 *  推荐使用该方法 不会阻塞主线程，通过block返回
 */
+ (void)getAllHttpCacheSizeBlock:(void(^)(NSInteger totalCount))block;

/**
 *  删除所有网络缓存
 */
+ (void)removeAllHttpCache;

/**
 *  删除所有网络缓存
 *  推荐使用该方法 不会阻塞主线程，同时返回Progress
 */
+ (void)removeAllHttpCacheBlock:(void(^)(int removedCount, int totalCount))progress
                       endBlock:(void(^)(BOOL error))end;


@end

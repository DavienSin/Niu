//
//  NiuRequest.h
//  Niu
//
//  Created by Davien Sin on 2022/11/16.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NiuRequest : NSObject

/**
 从服务端获取Scope列表
    
 @param accessKey accessKey
 @param secretKey asecretKey
 */
-(void)getSpoceListFromServerWithKey:(NSString *)accessKey secretKey:(NSString *)secretKey;

/**
 上传文件到指定Spoce
    
 @param file  file
 @param scope 空间名
 @param uploadProgress 上传进度
 @param success 成功回调
 @param failure 失败回调
  */
-(void)uploadFiletToSpoceWithoutName:(NSData *)file
                               scope:(NSString *)scope
                            progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                             success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;;

/**
 上传文件到指定Spoce
    
 @param file  file
 @param scope 空间名
 @param name 文件名称
 @param uploadProgress 上传进度
 @param success 成功回调
 @param failure 失败回调
  */
-(void)uploadFiletToScopeWithName:(NSData *)file
                            scope:(NSString *)scope
                             name:(NSString *)name
                         progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                          success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                          failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;;


@end

NS_ASSUME_NONNULL_END

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
                          failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

/**
 分片上传文件到指定Spoce
    
 @param token  uploadToken
 @param data 块内容
 @param size 片大小
 @param uploadProgress 上传进度
 @param success 成功回调
 @param failure 失败回调
  */
-(void)createUploadBlockWithSize:(NSString *)token
                       blockData:(NSData *)data
                       blockSize:(NSInteger)size
                        progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                         success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                         failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

/**
 继续分片上传文件到指定Spoce
    
 @param token  uploadToken
 @param data 块内容
 @param ctx 上传成功后的块级上传控制信息，每次返回的 ctx 都只对应紧随其后的下一个上传数据片
 @param offset 下一个上传片在上传块中的偏移
 @param uploadProgress 上传进度
 @param success 成功回调
 @param failure 失败回调
  */
-(void)uploadBlockWithCtx:(NSString *)token
                blockData:(NSData *)data
                      ctx:(NSString *)ctx
          nextChunkOffset:(NSInteger)offset
                 progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                  success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                  failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
@end


//-(void)createUploadBlock

NS_ASSUME_NONNULL_END

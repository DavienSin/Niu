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
 分片上传文件到指定SpoceV1
 
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
 继续分片上传文件到指定SpoceV1
 
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

/**
 分片上传文件到指定api-V2
 
 @param token  uploadToken
 @param bucketName 空间名称
 @param encodedObjectNamesize 资源名
 @param uploadProgress 上传进度
 @param success 成功回调
 @param failure 失败回调
 */
-(void)initiateMultipartUpload:(NSString *)token
                    BucketName:(NSString *)bucketName
             EncodedObjectName:(NSString *)encodedObjectNamesize
                      progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

/**
 分片上传文件到指定api-V2
 
 @param token  uploadToken
 @param data  fileData
 @param bucketName 空间名称
 @param encodedObjectNamesize 资源名
 @param uploadId 上传ID，后续上传的数据必须统一
 @param partNumber partNumber 区块编号，如果设置重复，会数据覆盖,取值1-10000
 @param uploadProgressBlock 进度条回调
 @param completionHandler 上传回调，包含成功失败返回信息
 */
-(void)uploadPart:(NSString *)token
         fileData:(NSData *)data
       BucketName:(NSString *)bucketName
EncodedObjectName:(NSString *)encodedObjectNamesize
         UploadId:(NSString *)uploadId
       PartNumber:(NSInteger)partNumber
         progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock
completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;


/**
 完成文件上传 api-V2
 
 @param token  uploadToken
 @param bucketName 空间名称
 @param encodedObjectNamesize 资源名
 @param parts 已经上传 Part 列表 （ 包括 PartNumber （ int ）和调用 uploadPart API 服务端返回的 Etag （ string ））
 @param fname 上传的原始文件名
 @param mimeType 文件类
 @param uploadProgress 上传进度
 @param success 成功回调
 @param failure 失败回调
 */
-(void)completeMultipartUpload:(NSString *)token
                    BucketName:(NSString *)bucketName
             EncodedObjectName:(NSString *)encodedObjectNamesize
                      UploadId:(NSString *)uploadId
                         parts:(NSArray *)parts
                         fname:(NSString *)fname
                      mimeType:(NSString *)mimeType
                      progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

/**
 完成文件上传 api-V2
    
 @param token  uploadToken
 @param bucketName 空间名称
 @param encodedObjectNamesize 资源名
 @param uploadId 在服务端申请的 Multipart Upload 任务 id
 @param maxParts 响应中的最大 Part 数目。默认值 ：1,000，最大值 ：1,000
 @param partNumberMarker 指定列举的起始位置，只有 PartNumber 值大于该参数的 Part 会被列出。默认值 ：无
 @param uploadProgress 上传进度
 @param success 成功回调
 @param failure 失败回调
  */
-(void)getPartList:(NSString *)token
                    BucketName:(NSString *)bucketName
             EncodedObjectName:(NSString *)encodedObjectNamesize
                      UploadId:(NSString *)uploadId
                      maxparts:(NSArray *)maxParts
              partNumberMarker:(NSString *)partNumberMarker
                      progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
@end





//-(void)createUploadBlock

NS_ASSUME_NONNULL_END

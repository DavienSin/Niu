//
//  NiuRequest.m
//  Niu
//
//  Created by Davien Sin on 2022/11/16.
//

#import "NiuRequest.h"
#include <AFNetworking/AFNetworking.h>
#import "XYQNToken.h"

NSString * const AK = @"8Z-kuG8I94-2wxVDUgHYM6bMeZA1QvZK1uba44E1";
NSString * const SK = @"unhxmNvwA3Gwolf2HXPQolUNVaZdVKCyJpBnTrsR";
NSString * const Host = @"https://upload-z2.qiniup.com";


@interface NiuRequest()

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end


@implementation NiuRequest

-(AFHTTPSessionManager *)manager{
    if(!_manager){
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _manager;
}

- (void)uploadFiletToSpoceWithoutName:(NSData *)file scope:(NSString *)scope progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    [self uploadFiletToScopeWithName:file scope:scope name:[NSString stringWithFormat:@"file+%08X", arc4random()] progress:uploadProgress success:success failure:failure];
}

-(void)uploadFiletToScopeWithName:(NSData *)file scope:(NSString *)scope name:(NSString *)name progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    //uploadToken
    NSString *uploadToken = [XYQNToken createTokenWithScope:scope accessKey:AK secretKey:SK];
    _manager = self.manager;
    [_manager.requestSerializer setValue:@"multipart/form-data;" forHTTPHeaderField:@"Content-Type"];
    [_manager POST:Host parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:[uploadToken dataUsingEncoding:NSUTF8StringEncoding] name:@"token"];
        [formData appendPartWithFileData:file name:@"file" fileName:name mimeType:@"image/jpg"];
    } progress:uploadProgress success:success failure:failure];
   
}

- (void)getSpoceListFromServerWithKey:(NSString *)accessKey secretKey:(NSString *)secretKey{
    NSString *token = [XYQNToken createManagerTokenWithUrl:@"GET" requestUrl:@"/buckets?tagCondition=" accessKey:AK secretKey:SK];
    _manager = self.manager;
    [_manager.requestSerializer setValue:@"_gat=1; _ga=GA1.2.1210310293.1667721276; sensorsdata2015jssdkcross=%7B%22distinct_id%22%3A%221382795121%22%2C%22first_id%22%3A%221844bef2521a2f-0994f89f7b4fc88-4e193001-1296000-1844bef2523a37%22%2C%22props%22%3A%7B%22%24latest_traffic_source_type%22%3A%22%E7%9B%B4%E6%8E%A5%E6%B5%81%E9%87%8F%22%2C%22%24latest_search_keyword%22%3A%22%E6%9C%AA%E5%8F%96%E5%88%B0%E5%80%BC_%E7%9B%B4%E6%8E%A5%E6%89%93%E5%BC%80%22%2C%22%24latest_referrer%22%3A%22%22%7D%2C%22%24device_id%22%3A%221844bef2521a2f-0994f89f7b4fc88-4e193001-1296000-1844bef2523a37%22%2C%22identities%22%3A%22eyIkaWRlbnRpdHlfY29va2llX2lkIjoiMTg0NGJmMDc3NWVjMTktMDM3YWI3MDcxN2YzMTNjLTRlMTkzMDAxLTEyOTYwMDAtMTg0NGJmMDc3NWYxMWM4IiwiJGlkZW50aXR5X2xvZ2luX2lkIjoiMTM4Mjc5NTEyMSJ9%22%2C%22history_login_id%22%3A%7B%22name%22%3A%22%24identity_login_id%22%2C%22value%22%3A%221382795121%22%7D%7D; AGL_USER_ID=28956aa4-da49-4b94-82e5-37bce91eb135; PORTAL_SESSION=QjFPNzg0SUcxUzFYUDVUTFdCTlhDS1NDT1BXUFpaNUIsMTY2ODY1MjYyNzg4MzU0Nzk4Miw4MTNmMDUxM2JmZjZlZjBmNzQwZWY4MGU0YjFjZTdmZGI2Y2E5ZTM5; PORTAL_SESSION=QjFPNzg0SUcxUzFYUDVUTFdCTlhDS1NDT1BXUFpaNUIsMTY2ODY1MjYyNzg4MzU0Nzk4Miw4MTNmMDUxM2JmZjZlZjBmNzQwZWY4MGU0YjFjZTdmZGI2Y2E5ZTM5; PORTAL_UID=1382795121; SSID=VFYxWDlYVFNYT0MwMUZMSFI4QVNBS1hBR05ZMUtENEpCUDVKViwxNjY4NjUyNjA3MjY0NjQ0ODkzLDVhZWM1MDA3NjZmNDc5ODI5MThmODAwNTk1N2U5YzBkYzBiYmU2ODQ5ZWY2ZTc4NjI5ZjRiZTY1MDA0NGZiNzk5YzMxNmU2MWZiNTZmZDFlYjBhNGE4ODkwYmE4YWIzMzJkMGIzMTE3NDFkYjg0N2U5MzI2Njk2NGE2ODQ5NTMz; _gid=GA1.2.1085207740.1668615395; _ga_JP28X22DD7=GS1.1.1668278026.6.1.1668278106.60.0.0; Hm_lvt_204fcf6777f8efa834fe7c45a2336bf1=1667912770,1668078630,1668246516,1668271198; PORTAL_VERSION=v4" forHTTPHeaderField:@"cookie"];
   // [_manager.requestSerializer setValue:[NSString stringWithFormat:@"Qiniu %@",token] forHTTPHeaderField:@"Authorization"];
    
    [_manager GET:@"https://portal.qiniu.com/kodo/bucket" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)createUploadBlockWithSize:(NSString *)token blockData:(NSData *)data blockSize:(NSInteger)size progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
 ///buckets/<BucketName>/objects/<EncodedObjectName>/uploads
    _manager = self.manager;
    [_manager.requestSerializer setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    // 为何af传data会多100Byte？
  //  [_manager.requestSerializer setValue:@"4194309" forHTTPHeaderField:@"Content-Length"];
    [_manager.requestSerializer setValue:[NSString stringWithFormat:@"UpToken %@",token] forHTTPHeaderField:@"Authorization"];
    [_manager POST:@"https://upload-z2.qiniup.com/mkblk/4194304" parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:data name:@""];
    } progress:uploadProgress success:success failure:failure];
}

-(void)uploadBlockWithCtx:(NSString *)token blockData:(NSData *)data ctx:(NSString *)ctx nextChunkOffset:(NSInteger)offset progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    
    _manager = self.manager;
    [_manager.requestSerializer setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    [_manager.requestSerializer setValue:[NSString stringWithFormat:@"UpToken %@",token] forHTTPHeaderField:@"Authorization"];
    NSString *url = [NSString stringWithFormat:@"https://upload-z2.qiniup.com/bput/%@/%lu",ctx,offset];
    [_manager POST:url parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:data name:@""];
    } progress:uploadProgress success:success failure:failure];
}

-(void)initiateMultipartUpload:(NSString *)token BucketName:(NSData *)bucketName EncodedObjectName:(NSString *)encodedObjectNamesize progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    NSString *url;
    if([encodedObjectNamesize isEqualToString:@""]){
        url = [NSString stringWithFormat:@"https://upload-z2.qiniup.com/buckets/%@/objects/~/uploads",bucketName];
    }else{
        url = [NSString stringWithFormat:@"https://upload-z2.qiniup.com/buckets/%@/objects/%@/uploads",bucketName,encodedObjectNamesize];
    }
    _manager = self.manager;
    [_manager.requestSerializer setValue:[NSString stringWithFormat:@"UpToken %@",token] forHTTPHeaderField:@"Authorization"];
    [_manager POST:url parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:uploadProgress success:success failure:failure];
}


-(void)uploadPart:(NSString *)token fileData:(NSData *)data BucketName:(NSString *)bucketName EncodedObjectName:(NSString *)encodedObjectNamesize UploadId:(NSString *)uploadId PartNumber:(NSInteger)partNumber progress:(void (^)(NSProgress * _Nonnull))uploadProgressBlock completionHandler:(void (^)(NSURLResponse * _Nonnull, id _Nonnull, NSError * _Nonnull))completionHandler{
    
    NSString *url;
    if([encodedObjectNamesize isEqualToString:@""]){
        url = [NSString stringWithFormat:@"https://upload-z2.qiniup.com/buckets/%@/objects/~/uploads/%@/%lu",bucketName,uploadId,partNumber];
    }else{
        url = [NSString stringWithFormat:@"https://upload-z2.qiniup.com/buckets/%@/objects/%@/uploads/%@/%lu",bucketName,encodedObjectNamesize,uploadId,partNumber];
    }

    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    sManager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSError *err;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"PUT" URLString:url parameters:nil error:&err];
    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"UpToken %@",token] forHTTPHeaderField:@"Authorization"];
    
    if(err){
        NSLog(@"%@",err);
    }else{
     NSURLSessionUploadTask *uploadTask = [sManager uploadTaskWithRequest:request fromData:data progress:uploadProgressBlock completionHandler:completionHandler];
        [uploadTask resume];
    }
}

-(void)uploadPart:(NSString *)token fileData:(NSData *)data BucketName:(NSString *)bucketName EncodedObjectName:(NSString *)encodedObjectNamesize UploadId:(NSString *)uploadId PartNumber:(NSInteger)partNumber completionHandler:(void (^)(NSURLResponse * _Nonnull, id _Nonnull, NSError * _Nonnull))completionHandler{
    
    
    
    
    
}

-(void)putSuccess:(id)sender{
    NSLog(@"%@", sender);
}

-(void)putFail:(id)sender{
    NSLog(@"%@",sender);
}

-(void)completeMultipartUpload:(NSString *)token BucketName:(NSString *)bucketName EncodedObjectName:(NSString *)encodedObjectNamesize UploadId:(NSString *)uploadId parts:(NSArray *)parts fname:(NSString *)fname mimeType:(NSString *)mimeType progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    NSString *url;
    if([encodedObjectNamesize isEqualToString:@""]){
        url = [NSString stringWithFormat:@"https://upload-z2.qiniup.com/buckets/%@/objects/~/uploads/%@",bucketName,uploadId];
    }else{
        url = [NSString stringWithFormat:@"https://upload-z2.qiniup.com/buckets/%@/objects/%@/uploads/%@",bucketName,encodedObjectNamesize,uploadId];
    }
    _manager = self.manager;
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [_manager.requestSerializer setValue:[NSString stringWithFormat:@"UpToken %@",token] forHTTPHeaderField:@"Authorization"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parts options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",json);
    [_manager POST:url parameters:@{@"parts":parts,@"fname":fname,@"mimeTyep":mimeType} headers:nil progress:uploadProgress success:success failure:failure];
}

-(void)getPartList:(NSString *)token BucketName:(NSString *)bucketName EncodedObjectName:(NSString *)encodedObjectNamesize UploadId:(NSString *)uploadId maxparts:(NSArray *)maxParts partNumberMarker:(NSString *)partNumberMarker progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    _manager = self.manager;
    
    NSString *url;
    if([encodedObjectNamesize isEqualToString:@""]){
        url = [NSString stringWithFormat:@"https://upload-z2.qiniup.com/buckets/%@/objects/~/uploads/%@ ",bucketName,uploadId];
    }else{
        //未写
      //  url = [NSString stringWithFormat:@"https://upload-z2.qiniup.com/buckets/%@/objects/%@/uploads/%@",bucketName,encodedObjectNamesize,uploadId];
    }
   // NSLog(@"%@",url);
    
    [_manager.requestSerializer setValue:[NSString stringWithFormat:@"UpToken %@",token] forHTTPHeaderField:@"Authorization"];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [_manager GET:url parameters:nil headers:nil progress:uploadProgress success:success failure:failure];
}

@end

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
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _manager;
}


- (void)getSpoceListFromServerWithKey:(NSString *)accessKey secretKey:(NSString *)secretKey{
    NSString *token = [XYQNToken createManagerTokenWithUrl:@"GET" requestUrl:@"/buckets?tagCondition=" accessKey:AK secretKey:SK];
    _manager = self.manager;
    [_manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [_manager.requestSerializer setValue:[NSString stringWithFormat:@"Qiniu %@",token] forHTTPHeaderField:@"Authorization"];
    
    [_manager GET:@"https://uc.qbox.me" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end

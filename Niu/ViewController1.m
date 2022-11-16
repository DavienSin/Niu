//
//  ViewController.m
//  Niu
//
//  Created by Davien Sin on 2022/11/6.
//

#import "ViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "XYQNToken.h"
#import "QN_GTM_Base64.h"
#include <Qiniu/QiniuSDK.h>

NSString * const AK = @"8Z-kuG8I94-2wxVDUgHYM6bMeZA1QvZK1uba44E1";
NSString * const SK = @"unhxmNvwA3Gwolf2HXPQolUNVaZdVKCyJpBnTrsR";
NSString * const bucketName = @"datest3";
NSString * const fileName = @"name1.jpg";
NSString * const scopeUrl = @"rkx2qw4mg.hn-bkt.clouddn.com";
NSString * const Host = @"https://upload-z2.qiniup.com";

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *token = [XYQNToken createTokenWithScope:bucketName accessKey:AK secretKey:SK];
    
  //  QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    //加载图片资源
    NSData *imageData = [self loadImage];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
   
    NSString *boundary = [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
 
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    policy.allowInvalidCertificates = YES;
//    policy.validatesDomainName = NO;
//    manager.securityPolicy = policy;
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //构建请求体
    NSDictionary *params = @{@"token":token};
    NSMutableData *postData = [[NSMutableData alloc] init];
    for (NSString *key in params) {
        NSString *pair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n",boundary,key];
        [postData appendData:[pair dataUsingEncoding:NSUTF8StringEncoding]];
        id value = [params objectForKey:key];
                if ([value isKindOfClass:[NSString class]]) {
                    [postData appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
                }else if ([value isKindOfClass:[NSData class]]){
                    [postData appendData:value];
                }
                [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"file\";filename=\"%@\"\nContent-Type: image/jpeg\r\nContent-Transfer-Encoding: binary\r\n\r\n ",boundary,@"1.jpg"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:imageData];
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  
    NSString *bodyLength = [NSString stringWithFormat:@"%lu",(unsigned long)postData.length];
    
    // 这里设置head后台可以识别
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    
   // NSLog(@"%@",[manager.requestSerializer valueForHTTPHeaderField:@"Content-Type"]);
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //这里设置head后台无法识别
    [manager POST:Host parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       // [formData appendPartWithFormData:postData name:@"1.jpg"];
     //   [formData appendPartWithFormData:[token dataUsingEncoding:NSUTF8StringEncoding] name:@"token"];
    //    [formData appendPartWithFileData:imageData name:@"file" fileName:@"33.jpg" mimeType:@"image/jpeg;"];
    //    [formData appendPartWithHeaders:nil body:postData];
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
//    [upManager putData:imageData key:@"" token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//        NSLog(@"-%@", info);
//            NSLog(@"--%@", resp);
//        NSLog(@"---%@",key);
//    } option:nil];
}

-(NSData *)loadImage{
   NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"12.jpg"];
   NSData *imageData = [NSData dataWithContentsOfFile:path];
    return imageData;;
}
@end

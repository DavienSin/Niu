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

@end

NS_ASSUME_NONNULL_END

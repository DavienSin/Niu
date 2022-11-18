//
//  NSData+block.h
//  Niu
//
//  Created by Davien Sin on 2022/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData(Block)


+ (NSArray *)cutDataIntoBlockWithSize:(NSData *)data blockSize:(nullable const void *)size;


@end

NS_ASSUME_NONNULL_END

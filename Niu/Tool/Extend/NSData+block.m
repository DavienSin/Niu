//
//  NSData+block.m
//  Niu
//
//  Created by Davien Sin on 2022/11/19.
//

#import "NSData+block.h"
@interface NSData(Block)

@end

@implementation NSData(Block)

+ (NSArray *)cutDataIntoBlockWithSize:(NSData *)data blockSize:(NSInteger)size{
    NSUInteger dataLength = data.length;
    NSInteger location = 0;
    NSMutableArray *blockData = [[NSMutableArray alloc] init];
    do {
        if (dataLength > size) {
            NSRange range =NSMakeRange(location*size, size - 105);
            location++;
            [blockData addObject:[data subdataWithRange:range]];
            dataLength = dataLength - size - 105;
        }else{
            NSRange range = NSMakeRange(location * size, dataLength);
            [blockData addObject:[data subdataWithRange:range]];
            dataLength = 0;
            }
        } while (dataLength>0);
    
    return blockData;
}




@end

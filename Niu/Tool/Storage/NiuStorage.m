//
//  Storage.m
//  Niu
//
//  Created by Davien Sin on 2022/11/16.
//

#import "NiuStorage.h"

@implementation NiuStorage

static NiuStorage *_storage;

+(instancetype)defaultStorage{
    return [[self alloc] init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    //方案一:加互斥锁,解决多线程访问安全问题
 //    @synchronized(self){//同步的
 //        if (!_instance) {
 //            _instance = [super allocWithZone:zone];
 //        }
 //    }
     //方案二.GCD dispatch_onec,本身是线程安全的,保证整个程序中只会执行一次
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _storage = [NiuStorage allocWithZone:zone];
    });
    return _storage;
}

-(id)copyWithZone:(NSZone *)zone{
    return _storage;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return _storage;
}




@end

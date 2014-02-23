//
//  BNRImageStore.m
//  Homepwner
//
//  Created by evg on 23.02.14.
//  Copyright (c) 2014 jennik. All rights reserved.
//

#import "BNRImageStore.h"

@implementation BNRImageStore
{
    NSMutableDictionary *images;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

+ (BNRImageStore *)sharedStore
{
    static BNRImageStore *store = nil;
    if (!store)
    {
        store = [[super allocWithZone:NULL] init];
    }
    return store;
}

- (id)init
{
    if (self = [super init])
    {
        images = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [images setObject:image forKey:key];
}

- (UIImage *)imageForKey:(NSString *)key
{
    return [images objectForKey:key];
}

- (void)deleteImageForKey:(NSString *)key
{
    [images removeObjectForKey:key];
}

@end

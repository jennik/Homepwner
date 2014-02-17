//
//  BNRItemStore.m
//  Homepwner
//
//  Created by evg on 18.02.14.
//  Copyright (c) 2014 jennik. All rights reserved.
//

#import "BNRItemStore.h"

@implementation BNRItemStore
{
    NSMutableArray *allItems;
}

+ (BNRItemStore *)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore)
    {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    if (self = [super init])
    {
        self->allItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems
{
    return allItems;
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self->allItems addObject:item];
    return item;
}

@end

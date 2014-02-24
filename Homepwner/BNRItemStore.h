//
//  BNRItemStore.h
//  Homepwner
//
//  Created by evg on 18.02.14.
//  Copyright (c) 2014 jennik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

@interface BNRItemStore : NSObject

+ (BNRItemStore *)sharedStore;

- (NSArray *)allItems;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)p;
- (void)moveItemAtIndex:(NSInteger)from to:(NSInteger)to;

@end

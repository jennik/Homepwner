//
//  BNRItem.h
//  Random possessions
//
//  Created by evg on 08.02.14.
//  Copyright (c) 2014 jennik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

@property (nonatomic) int valueInDollars;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) NSDate *dateCreated;
@property (nonatomic) BNRItem *containedItem;
@property (nonatomic, weak) BNRItem *container;
@property (nonatomic) NSString *imageKey;

+ (id) randomItem;
- (id) initWithName:(NSString *)name serialNumber:(NSString *)serialNumber andValueInDollars:(int)valueInDollars;

@end

//
//  BNRItem.m
//  Random possessions
//
//  Created by evg on 08.02.14.
//  Copyright (c) 2014 jennik. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

@synthesize valueInDollars, itemName, serialNumber, dateCreated, container, containedItem;

+ (id) randomItem
{
    NSArray *adjectivesList = [NSArray arrayWithObjects:@"Fluffy", @"Rusty", @"Shiny", nil];
    NSArray *nounsList = [NSArray arrayWithObjects:@"Bear", @"Spork", @"Mac", nil];
    
    NSInteger adjectiveIndex = rand() % [adjectivesList count];
    NSInteger nounIndex = rand() % [nounsList count];
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10];
    return [[self alloc] initWithName:[NSString stringWithFormat:@"%@ %@", [adjectivesList objectAtIndex:adjectiveIndex], [nounsList objectAtIndex:nounIndex]] serialNumber:randomSerialNumber andValueInDollars:rand() % 100];
}

- (id) init
{
    return [self initWithName:@"Default" serialNumber:@"Default" andValueInDollars:100];
}

- (id) initWithName:(NSString *)initName serialNumber:(NSString *)initSerialNumber andValueInDollars:(int)initValueInDollars
{
    if (self = [super init])
    {
        self.itemName = initName;
        self.serialNumber = initSerialNumber;
        self.valueInDollars = initValueInDollars;
        self->dateCreated = [NSDate date];
    }
    return self;
}

- (void) setContainedItem:(BNRItem *)newContainedItem
{
    self->containedItem = newContainedItem;
    
    newContainedItem.container = self;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"%@ (%@): created on %@, costs $%d", self.itemName, self.serialNumber, self.dateCreated, self.valueInDollars];
}

- (void) dealloc
{
//    NSLog(@"Destroyed: %@", self);
}

@end

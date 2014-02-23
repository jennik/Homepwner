//
//  BNRImageStore.h
//  Homepwner
//
//  Created by evg on 23.02.14.
//  Copyright (c) 2014 jennik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+ (BNRImageStore *)sharedStore;
- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end

//
//  CameraCenterOverlayView.m
//  Homepwner
//
//  Created by evg on 23.02.14.
//  Copyright (c) 2014 jennik. All rights reserved.
//

#import "CameraCenterOverlayView.h"

@implementation CameraCenterOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0.0f, 1.0f, 0.0f, 1.0f);
    CGContextMoveToPoint(ctx, self.bounds.origin.x + self.bounds.size.width / 2, self.bounds.origin.y);
    CGContextAddLineToPoint(ctx, self.bounds.origin.x + self.bounds.size.width / 2, self.bounds.origin.y + self.bounds.size.height);
    CGContextMoveToPoint(ctx, self.bounds.origin.x , self.bounds.origin.y + self.bounds.size.height / 2);
    CGContextAddLineToPoint(ctx, self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y + self.bounds.size.height / 2);
    CGContextStrokePath(ctx);
}

@end

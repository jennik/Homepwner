//
//  DateChangeViewController.h
//  Homepwner
//
//  Created by evg on 22.02.14.
//  Copyright (c) 2014 jennik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRItem.h"

@interface DateChangeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) BNRItem *item;

- (IBAction)dateChanged:(id)sender;

@end

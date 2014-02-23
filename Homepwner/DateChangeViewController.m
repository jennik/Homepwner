//
//  DateChangeViewController.m
//  Homepwner
//
//  Created by evg on 22.02.14.
//  Copyright (c) 2014 jennik. All rights reserved.
//

#import "DateChangeViewController.h"

@interface DateChangeViewController ()

@end

@implementation DateChangeViewController

@synthesize item;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    self.datePicker.date = self.item.dateCreated;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dateChanged:(id)sender
{
    self.item.dateCreated = self.datePicker.date;
    
}
@end

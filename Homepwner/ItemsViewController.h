//
//  ItemsViewController.h
//  Homepwner
//
//  Created by evg on 18.02.14.
//  Copyright (c) 2014 jennik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemsViewController : UITableViewController <UITableViewDataSource>

@property  (nonatomic, strong) IBOutlet UIView *headerView;

- (IBAction)addNewItem:(id)sender;
- (IBAction)toggleEditingMode:(id)sender;

@end

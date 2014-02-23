//
//  ItemsViewController.m
//  Homepwner
//
//  Created by evg on 18.02.14.
//  Copyright (c) 2014 jennik. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "DetailViewController.h"

@implementation ItemsViewController

- (id)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped])
    {
        for (int i = 0; i < 5; i++)
        {
            [[BNRItemStore sharedStore] createItem];
        }
        self.navigationItem.title = @"Homepwner";
        
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BNRItem"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BNRItem"];
    
    if (indexPath.row != [[[BNRItemStore sharedStore] allItems] count])
    {
        BNRItem *item = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];
        cell.textLabel.text = [item description];
    }
    else
    {
        cell.textLabel.text = @"No more items";
    }
    
    return cell;
}

- (void)addNewItem:(id)sender
{
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    NSUInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationTop];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *p = [items objectAtIndex:[indexPath row]];
        [[BNRItemStore sharedStore] removeItem:p];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
        [[BNRItemStore sharedStore] moveItemAtIndex:[sourceIndexPath row] to:destinationIndexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == [[[BNRItemStore sharedStore] allItems] count]) ? NO : YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    return (proposedDestinationIndexPath.row == [[[BNRItemStore sharedStore] allItems] count]) ? sourceIndexPath : proposedDestinationIndexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [[[BNRItemStore sharedStore] allItems] count])
    {
        return;
    }
    
    DetailViewController *detailController  = [[DetailViewController alloc] init];
    detailController.item = [[[BNRItemStore sharedStore] allItems] objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

@end

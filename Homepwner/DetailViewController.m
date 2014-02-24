//
//  DetailViewController.m
//  Homepwner
//
//  Created by evg on 21.02.14.
//  Copyright (c) 2014 jennik. All rights reserved.
//

#import "DetailViewController.h"
#import "DateChangeViewController.h"
#import "BNRImageStore.h"
#import "CameraCenterOverlayView.h"
#import "BNRItemStore.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize nameField, serialNumberField, valueField, dateLabel, item, delButton, dismissBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"use initForNewItem:" userInfo:nil];
    
    return nil;
}

- (id)initForNewItem:(BOOL)isNew
{
    if ((self = [super initWithNibName:@"DetailViewController" bundle:nil]) && isNew)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
    self.nameField.text = self.item.itemName;
    self.serialNumberField.text = self.item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
    
    if((self.imageView.image = [[BNRImageStore sharedStore] imageForKey:self.item.imageKey]))
    {
        self.delButton.hidden = NO;
    }
    else
    {
        self.delButton.hidden = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    self.item.itemName = self.nameField.text;
    self.item.serialNumber = self.serialNumberField.text;
    self.item.valueInDollars = [self.valueField.text intValue];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)changeDate
{
    DateChangeViewController *chDate = [[DateChangeViewController alloc] init];
    chDate.item = self.item;
    
    [self.navigationController pushViewController:chDate animated:YES];
}

- (IBAction)takePicture:(id)sender
{
    if ([self.imagePickerPopover isPopoverVisible])
    {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        CameraCenterOverlayView *overlayView = [[CameraCenterOverlayView alloc] initWithFrame:CGRectMake(imagePicker.view.bounds.size.width / 2 - 25, imagePicker.view.bounds.size.height / 2 - 25, 50, 50)];
        overlayView.backgroundColor = [UIColor clearColor];
        imagePicker.cameraOverlayView = overlayView;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        self.imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        self.imagePickerPopover.delegate = self;
        [self.imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    else
    {
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)delPicture:(id)sender
{
    if ([[BNRImageStore sharedStore] imageForKey:self.item.imageKey])
    {
        [[BNRImageStore sharedStore] deleteImageForKey:self.item.imageKey];
    }
    self.imageView.image = nil;
    self.item.imageKey = nil;
    self.delButton.hidden = YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[BNRImageStore sharedStore] imageForKey:self.item.imageKey])
    {
        [[BNRImageStore sharedStore] deleteImageForKey:self.item.imageKey];
    }
    CFUUIDRef imageUUID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef imageUUIDString = CFUUIDCreateString(kCFAllocatorDefault, imageUUID);
    CFRelease(imageUUID);
    
    self.item.imageKey = (__bridge_transfer NSString *)imageUUIDString;
    
    [[BNRImageStore sharedStore] setImage:info[UIImagePickerControllerEditedImage] forKey:self.item.imageKey];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        self.imageView.image = info[UIImagePickerControllerEditedImage];
        self.delButton.hidden = NO;
        
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
    }
    
    
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.imagePickerPopover = nil;
}

- (void)save:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (void)cancel:(id)sender
{
    [[BNRItemStore sharedStore] removeItem:self.item];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

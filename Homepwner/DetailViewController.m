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

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize nameField, serialNumberField, valueField, dateLabel, item, delButton;

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
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(imagePicker.view.bounds.size.width / 2 - 25, imagePicker.view.bounds.size.height / 2 - 25, 50, 50)];
    imagePicker.cameraOverlayView = overlayView;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
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
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end

//
//  IQAddEditTodoListViewController.m
//  IQParseSDK Demo
//
//  Created by Iftekhar on 07/09/14.
//  Copyright (c) 2014 Iftekhar. All rights reserved.
//

#import "IQAddEditTodoListViewController.h"
#import "IQDropDownTextField.h"
#import "UIImage+Resize.h"

@interface IQAddEditTodoListViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL isPicChanged;
    
    IBOutlet UIProgressView *progressViewImageUpload;
    IBOutlet IQ_PFImageView *imageViewTodo;
    IBOutlet UITextField *textFieldTitle;
    IBOutlet IQDropDownTextField *dropDownCategory;
    IBOutlet IQDropDownTextField *dropDownDate;
}

@end

@implementation IQAddEditTodoListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isPicChanged = NO;

    dropDownCategory.itemList = @[@"Home",@"Work",@"Entertainment"];
    dropDownDate.dropDownMode = IQDropDownModeDatePicker;
    
    if (self.object)
    {
        textFieldTitle.text             = [self.object objectForKey:@"title"];
        dropDownCategory.selectedItem   = [self.object objectForKey:@"category"];
        dropDownDate.date               = [self.object objectForKey:@"date"];
        imageViewTodo.file              = [self.object objectForKey:@"image"];
        [imageViewTodo loadInBackground];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (IBAction)chooseImageAction:(UIButton *)sender
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    imageViewTodo.image = image;
    isPicChanged = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveAction:(UIBarButtonItem *)sender
{
    [self.view endEditing:YES];
    
    IQ_PFObject *object;

    if (self.object)
    {
        object = self.object;
    }
    else
    {
        object = [IQ_PFObject objectWithClassName:@"ToDoItem"];
    }
    if (textFieldTitle.text)
    {
        [object setObject:textFieldTitle.text forKey:@"title"];
    }
    
    if (dropDownCategory.text)
    {
        [object setObject:dropDownCategory.text forKey:@"category"];
    }
    
    if (dropDownDate.date)
    {
        [object setObject:dropDownDate.date forKey:@"date"];
    }

    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicatorView startAnimating];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:activityIndicatorView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *oldRightItem = self.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItem = nil;
    
    if (imageViewTodo.image && isPicChanged == YES)
    {
        UIImage *image = [imageViewTodo.image resizedImageToFitInSize:CGSizeMake(200, 200) scaleIfSmaller:YES];

        IQ_PFFile *file = [IQ_PFFile fileWithData:UIImageJPEGRepresentation(image, 1.0) contentType:kParseFileContentTypeImage];

        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

            progressViewImageUpload.hidden = YES;
            progressViewImageUpload.progress = 0.0;
            
            if (succeeded == 1)
            {
                [object setObject:file forKey:@"image"];
                
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (succeeded)
                    {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else
                    {
                        self.navigationItem.leftBarButtonItem = nil;
                        self.navigationItem.rightBarButtonItem = oldRightItem;
                    }
                }];
            }
            else
            {
                self.navigationItem.leftBarButtonItem = nil;
                self.navigationItem.rightBarButtonItem = oldRightItem;
            }

        } progressBlock:^(int percentDone) {
            progressViewImageUpload.hidden = NO;
            [progressViewImageUpload setProgress:(percentDone/100.0) animated:YES];
        }];
    }
    else
    {
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (succeeded)
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                self.navigationItem.leftBarButtonItem = nil;
                self.navigationItem.rightBarButtonItem = oldRightItem;
            }
        }];
    }
}

@end

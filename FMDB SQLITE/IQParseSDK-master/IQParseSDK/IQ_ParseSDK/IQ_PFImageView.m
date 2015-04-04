//
//  IQ_PFImageView.m
//  IQParseSDK Demo
//
//  Created by Iftekhar on 07/09/14.
//  Copyright (c) 2014 Iftekhar. All rights reserved.
//

#import "IQ_PFImageView.h"
#import "IQPFHTTPService.h"

@interface IQ_PFImageView ()

@property(nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation IQ_PFImageView

-(void)loadInBackground
{
    [self loadInBackground:NULL];
}

-(void)loadInBackground:(void (^)(UIImage *image, NSError *error))completion
{
    [self.file cancel];
    
    [self.file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {

        [self.activityView stopAnimating];

        UIImage *image = [[UIImage alloc] initWithData:data];
        if (image)
        {
            self.image = image;
        }
        
        if (completion)
        {
            completion(image, error);
        }

    } progressBlock:^(int percentDone) {

        [self.activityView startAnimating];
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.activityView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

-(void)setImage:(UIImage *)image
{
    [super setImage:image];

    if (self.image)
    {
        [self.activityView stopAnimating];
    }
}

-(UIActivityIndicatorView *)activityView
{
    if (_activityView == nil)
    {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activityView];
    }
    
    return _activityView;
}

@end

//
//  IQ_PFImageView.h
//  IQParseSDK Demo
//
//  Created by Iftekhar on 07/09/14.
//  Copyright (c) 2014 Iftekhar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQ_PFFile.h"

@interface IQ_PFImageView : UIImageView

@property (nonatomic, strong) IQ_PFFile *file;

- (void)loadInBackground;
- (void)loadInBackground:(void (^)(UIImage *image, NSError *error))completion;

@end

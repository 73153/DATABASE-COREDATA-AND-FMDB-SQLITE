//
//  IQShadowView.m
//  IQParseSDK Demo
//
//  Created by Iftekhar on 09/09/14.
//  Copyright (c) 2014 Iftekhar. All rights reserved.
//

#import "IQShadowView.h"

@implementation IQShadowView

-(void)initialize
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 1.0;
    self.clipsToBounds = NO;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initialize];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
}

@end

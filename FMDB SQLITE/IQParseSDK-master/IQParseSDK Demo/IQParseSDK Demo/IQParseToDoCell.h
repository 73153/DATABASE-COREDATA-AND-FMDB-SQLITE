//
//  IQParseToDoCell.h
//  IQParseSDK Demo
//
//  Created by Iftekhar on 07/09/14.
//  Copyright (c) 2014 Iftekhar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQ_PFImageView.h"

@interface IQParseToDoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet IQ_PFImageView *imageViewTodo;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelCategory;
@property (strong, nonatomic) IBOutlet UILabel *labelDate;


@end

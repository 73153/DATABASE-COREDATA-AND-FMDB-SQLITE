//
//  EditingTableViewController.h
//  CellMappingExample
//
//  Created by Bruno Wernimont on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKListTableModel;

@interface EditingTableViewController : UITableViewController

@property (nonatomic, retain) TKListTableModel *tableModel;

@end

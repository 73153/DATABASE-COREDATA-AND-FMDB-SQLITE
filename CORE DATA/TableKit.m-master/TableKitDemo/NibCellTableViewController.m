//
//  NibCellTableViewController.m
//  CellMappingExample
//
//  Created by Bruno Wernimont on 7/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NibCellTableViewController.h"

#import "TableKit.h"

#import "Item.h"
#import "MovieViewCell.h"
#import "BookViewCell.h"

@implementation NibCellTableViewController

@synthesize tableModel = _tableModel;


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Nib cell";
    
    self.tableModel = [TKListTableModel tableModelForTableView:self.tableView];
    self.tableView.dataSource = self.tableModel;
    self.tableView.delegate = self.tableModel;
        
    [TKCellMapping mappingForObjectClass:[Item class] block:^(TKCellMapping *cellMapping) {
        [cellMapping mapKeyPath:@"title" toAttribute:@"titleLabel.text"];
        [cellMapping mapKeyPath:@"subtitle" toAttribute:@"subTitleLabel.text"];
        cellMapping.nib = [BookViewCell nib];
        [cellMapping mapObjectToCellClass:[BookViewCell class]];
        [self.tableModel registerMapping:cellMapping];
    }];
    
    NSArray *items = [NSArray arrayWithObjects:
                      [Item itemWithTitle:@"Book1" subtitle:@"Book subtitle" type:nil],
                      nil];
    
    [self.tableModel loadTableItems:items];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.tableModel = nil;
}


@end

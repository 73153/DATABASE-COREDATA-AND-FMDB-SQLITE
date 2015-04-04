//
//  IQTodoListViewController.m
//  IQParseSDK Demo
//
//  Created by Iftekhar on 07/09/14.
//  Copyright (c) 2014 Iftekhar. All rights reserved.
//

#import "IQTodoListViewController.h"
#import "IQAddEditTodoListViewController.h"

#import "IQParseToDoCell.h"

@interface IQTodoListViewController ()
{
    NSArray *todoItems;
    
    UIRefreshControl *refreshControl;
}

@end

@implementation IQTodoListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(getObjects) forControlEvents:UIControlEventValueChanged];

    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)getObjects
{
    IQ_PFQuery *query = [IQ_PFQuery queryWithClassName:@"ToDoItem"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self.refreshControl endRefreshing];
        
        NSArray *todoItemsObjectIds = [todoItems valueForKey:@"objectId"];
        
        NSMutableArray *_mutableTodDoItems = [[NSMutableArray alloc] initWithArray:todoItems];
        
        for (IQ_PFObject *object in objects)
        {
            if ([todoItemsObjectIds containsObject:object.objectId] == NO)
            {
                [_mutableTodDoItems addObject:object];
            }
        }

        todoItems = _mutableTodDoItems;

        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        IQAddEditTodoListViewController *controller = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.object = [todoItems objectAtIndex:indexPath.row];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return todoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IQParseToDoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IQParseToDoCell class]) forIndexPath:indexPath];
    
    IQ_PFObject *object = [todoItems objectAtIndex:indexPath.row];
    
    IQ_PFFile *file = [object objectForKey:@"image"];
    NSDate *date = [object objectForKey:@"date"];
    
    
    cell.imageViewTodo.file = file;
    [cell.imageViewTodo loadInBackground];
    
    cell.labelTitle.text    = [object objectForKey:@"title"];
    cell.labelCategory.text = [object objectForKey:@"category"];
    
    cell.labelDate.text     = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
    
    return cell;
}

#pragma mark - Table view delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        IQ_PFObject *object = [todoItems objectAtIndex:indexPath.row];
        
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicatorView startAnimating];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:activityIndicatorView];
        UIBarButtonItem *oldLeftItem = self.navigationItem.leftBarButtonItem;
        self.navigationItem.leftBarButtonItem = leftItem;
        
        [self.view setUserInteractionEnabled:NO];
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            self.navigationItem.leftBarButtonItem = oldLeftItem;
            [self.view setUserInteractionEnabled:YES];
            
            if (succeeded)
            {
                NSMutableArray *_mutableTodDoItems = [[NSMutableArray alloc] initWithArray:todoItems];
                [_mutableTodDoItems removeObject:object];
                todoItems = _mutableTodDoItems;
                
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }];
    }
}


@end

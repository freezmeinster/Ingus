//
//  IngTodoListTableControllerTableViewController.m
//  Ingus
//
//  Created by brambut on 5/20/14.
//  Copyright (c) 2014 Oleafs Integrasi Mandiri. All rights reserved.
//

#import "IngTodoListTableControllerTableViewController.h"
#import "IngTodoItem.h"
#import "IngAddTodoListViewController.h"
#import "IngConnect.h"

@interface IngTodoListTableControllerTableViewController ()

@property NSMutableArray *toDoItems;

@end

@implementation IngTodoListTableControllerTableViewController

- (IBAction)unwindTodo:(UIStoryboardSegue *)segue;
{
    IngAddTodoListViewController *source = [segue sourceViewController];
    IngTodoItem *item = source.toDoItem;
    if (item != nil){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [self.toDoItems addObject:item];
            IngConnect *conn = [[IngConnect alloc] init];
            [conn insertToCloud:item.itemName];
            [self.tableView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        });
        
    }
}

- (IBAction)syncTodo:(id)sender {
    [self loadInitData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadInitData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadInitData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        self.toDoItems = [[NSMutableArray alloc] init];
        IngConnect *conn = [[IngConnect alloc] init];
        NSArray *result = [conn fetchAll];
        for (id item in result){
            IngTodoItem *todos = [[IngTodoItem alloc] init];
            todos.dataId = item[@"id"];
            todos.itemName = item[@"name"];
            todos.completed = [item[@"completed"] boolValue];
            [self.toDoItems addObject:todos];
        }
        [self.tableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.toDoItems count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    IngTodoItem *toDoItems = [ self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItems.itemName;
    
    if (toDoItems.completed){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to supportle rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    IngTodoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    IngConnect *conn = [[IngConnect alloc] init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        if (tappedItem.completed){
            [conn setStatus:tappedItem.dataId stat:@"false"];
        }else{
            [conn setStatus:tappedItem.dataId stat:@"true"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    tappedItem.completed = !tappedItem.completed;
    NSLog(@"%@", tappedItem.completed ? @"YES" : @"NO");
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end

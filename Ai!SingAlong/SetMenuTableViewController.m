//
//  SetMenuTableViewController.m
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 8/10/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

#import "SetMenuTableViewController.h"
#import "SetCell.h"
#import "SetOptionViewController.h"

@interface SetMenuTableViewController ()

@end

@implementation SetMenuTableViewController
{
    NSArray * setlists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadParseData];
    
    
    
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return setlists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setCell" forIndexPath:indexPath];
    
    cell.setName.text = setlists[indexPath.row][@"name"];
    cell.setDate.text = setlists[indexPath.row][@"date"];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"setCell" forIndexPath:indexPath];
    
    cell.identifier = setlists[indexPath.row][@"identifier"];
    cell.password = setlists[indexPath.row][@"password"];
    
    NSString * setToLoad = setlists[indexPath.row][@"name"];
    
    PFQuery * singleSetQuery = [PFQuery queryWithClassName:setToLoad];
    
    SetOptionViewController * setOptionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"setOptionVC"];
    
    setOptionVC.password = cell.password;
    setOptionVC.identifier = cell.identifier;
    
    [self.navigationController pushViewController:setOptionVC animated:YES];
    
}

- (IBAction)newSet:(id)sender {
}


- (void)loadParseData {
    
    PFQuery * setlistQuery = [PFQuery queryWithClassName:@"setlist"];
    [setlistQuery findObjectsInBackgroundWithBlock:^(NSArray * setlistInfo, NSError * error) {
        
//        NSLog(@"Setlist info: %@", setlistInfo);
        
        setlists = setlistInfo;
        
        [[self tableView] reloadData];
        
        NSLog(@"Setlists! %@", setlists);
        
    }];
    
//    NSString * setName = setlistQuery[@"name"];
//    NSString * setDate = setlistQuery[@"date"];
    
    
    
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

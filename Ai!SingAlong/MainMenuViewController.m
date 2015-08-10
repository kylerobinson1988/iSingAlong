//
//  MainMenuViewController.m
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 8/10/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createEditSet:(id)sender {
    
    UITableViewController * loadSetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loadSetVC"];
    
    [self.navigationController pushViewController:loadSetVC animated:YES];
    
}

- (IBAction)runSet:(id)sender {

    
    
}

- (IBAction)watchSet:(id)sender {
    
    
    
}



@end

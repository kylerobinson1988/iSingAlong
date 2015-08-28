//
//  NewSetViewController.m
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 8/24/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

#import "NewSetViewController.h"
#import "SetlistMenuViewController.h"

@interface NewSetViewController ()

@end

@implementation NewSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createButtonPressed:(id)sender {
    
    if (![_setlistName.text  isEqual: @""]) {
        
        UIAlertController * errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please name your setlist." preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:errorAlert animated:YES completion:nil];
        
    } else {
        
        if ([_password.text isEqualToString:_passwordConfirm.text]) {
            
            //This is where I'll make the new setlist object for Parse.
            
            NSString * setName = [NSString stringWithFormat:@"%@", _setlistName.text];
            int setNumber = arc4random_uniform(100000);
            
            NSString * finalName = [NSString stringWithFormat:@"%@_%u", setName, setNumber];
            
            PFObject * setlistUpdate = [PFObject objectWithClassName:@"setlist"];
            setlistUpdate[@"identifier"] = finalName;
            [setlistUpdate saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded) {
                    NSLog(@"setlist class updated.");
                    
                    PFObject * newSet = [PFObject objectWithClassName:finalName];
                    newSet[@"name"] = setName;
                    [newSet saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
                        
                        if (succeeded) {
                            NSLog(@"New set class created.");
                            
                            SetlistMenuViewController * setlistMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"setlistMenuVC"];
                            
                            setlistMenuVC.setToLoad = finalName;
                            
                            [self.navigationController pushViewController:setlistMenuVC animated:YES];
                            
                            
                        } else {
                            NSLog(@"Something just went haywire..");
                        }
                        
                    }];
                    
                    
                } else {
                    NSLog(@"Something just went haywire..");
                
                }
            }];
            
            
            
            
        } else {
            
            UIAlertController * passwordError = [UIAlertController alertControllerWithTitle:@"Error" message:@"Passwords don't match." preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:passwordError animated:YES completion:nil];
            
        }
        
        
    }
    
}

- (IBAction)backButtonPressed:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

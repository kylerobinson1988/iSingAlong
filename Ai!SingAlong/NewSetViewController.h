//
//  NewSetViewController.h
//  Ai!SingAlong
//
//  Created by Kyle Brooks Robinson on 8/24/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Bolts/Bolts.h>

@interface NewSetViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *setlistName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirm;

@end

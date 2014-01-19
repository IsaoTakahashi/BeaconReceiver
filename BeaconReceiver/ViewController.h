//
//  ViewController.h
//  BeaconReceiver
//
//  Created by 高橋 勲 on 2014/01/19.
//  Copyright (c) 2014年 高橋 勲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeaconAPI.h"
#import "BeaconClient.h"
#import "MBProgressHUD.h"


@interface ViewController : UIViewController<UITextFieldDelegate,BeaconAPIDelegate,BeaconClientDeletage>

@property (nonatomic) BeaconAPI *beaconAPI;
@property (nonatomic) BeaconClient *beaconClient;
@property (nonatomic) NSString *currentStatus;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *backLabel;
@property (weak, nonatomic) IBOutlet UISwitch *activateSwitch;

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *beaconStatusLabel;


- (IBAction)activate:(id)sender;
- (IBAction)setName:(id)sender;
@end

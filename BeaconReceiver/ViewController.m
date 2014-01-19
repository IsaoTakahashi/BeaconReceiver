//
//  ViewController.m
//  BeaconReceiver
//
//  Created by 高橋 勲 on 2014/01/19.
//  Copyright (c) 2014年 高橋 勲. All rights reserved.
//

#import "ViewController.h"
#import "UserSettingUtil.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // initialize variable
    self.beaconAPI = [BeaconAPI new];
    self.beaconAPI.delegate = self;
    
    // set layout
    self.backLabel.layer.cornerRadius = 5;
    self.backLabel.layer.borderWidth = 2;
    self.backLabel.layer.borderColor = [[UIColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:1.0] CGColor];
    
    self.nameField.delegate = self;
    self.nameField.text = [UserSettingUtil getUserNameWithService:@"BeaconReceiver"];
    self.activateSwitch.on = NO;
    
    [self updateReceiverinfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateReceiverinfo
{
    if([self validateName]) {
        self.nameField.backgroundColor = [UIColor cyanColor];
        self.activateSwitch.enabled = YES;
    } else {
        self.nameField.backgroundColor = [UIColor redColor];
        self.activateSwitch.on = NO;
        self.activateSwitch.enabled = NO;
    }
}

- (Boolean) validateName
{
    if (self.nameField.text == nil ||
        self.nameField.text.length < 6) {
        return false;
    }
    
    return true;
}


- (IBAction)activate:(id)sender {
    if (self.activateSwitch.on) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.beaconAPI makeConnectionToAPI];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Activation" message:@"Stopped connectiong." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        [self disconnected];
    }
}

- (IBAction)setName:(id)sender {
    
    [self.nameField resignFirstResponder];
    
    if ([self validateName]) {
        [UserSettingUtil setUserName:self.nameField.text service:@"BeaconReceiver"];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"name" message:@"invalid name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    [self updateReceiverinfo];
}

- (void) disconnected
{
    self.activateSwitch.on = NO;
    
    self.placeLabel.text = @"Nowhere";
    self.beaconStatusLabel.text = @"None";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self setName:nil];
    return YES;
}

- (void) connectionResult:(Boolean)status {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    if (status) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Activation" message:@"Beacon Receiver has activated." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Activation" message:@"Connection was failed." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        [self disconnected];
    }
}

@end

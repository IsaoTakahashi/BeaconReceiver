//
//  BeaconAPI.m
//  BeaconReceiver
//
//  Created by 高橋 勲 on 2014/01/19.
//  Copyright (c) 2014年 高橋 勲. All rights reserved.
//

#import "BeaconAPI.h"

@implementation BeaconAPI

- (Boolean) makeConnectionToAPI
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://beacon-api-rails.herokuapp.com/api/ping" parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"response: %@", responseObject);
             [self.delegate connectionResult:YES];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             [self.delegate connectionResult:NO];
         }
     ];

    return YES;
}

@end

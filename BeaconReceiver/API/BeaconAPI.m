//
//  BeaconAPI.m
//  BeaconReceiver
//
//  Created by 高橋 勲 on 2014/01/19.
//  Copyright (c) 2014年 高橋 勲. All rights reserved.
//

#import "BeaconAPI.h"

static const NSString *API_DOMAIN = @"http://beacon-api-rails.herokuapp.com/";

@implementation BeaconAPI

- (Boolean) makeConnectionToAPI
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:[API_DOMAIN stringByAppendingString:@"api/ping"] parameters:nil
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

- (void) getRoomNameWithBeaconID:(NSString*)beaconId
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSDictionary* param = @{@"beacon_id" : beaconId};
    
    [manager GET:[API_DOMAIN stringByAppendingFormat:@"api/room/%@.json",beaconId] parameters:param
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"response: %@",responseObject);
             //NSData *responseData = [(NSDictionary*)responseObject objectForKey:@"response"];
             NSString *room = @"undefined";
             NSDictionary *json = (NSDictionary*)responseObject;//[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
             if([responseObject objectForKey:@"rooms"]) {
                 NSArray *roomsJson = [json objectForKey:@"rooms"];
                 NSDictionary *roomJson = roomsJson[0];
                 if ([roomJson objectForKey:@"room_id"]) {
                     room = [roomJson objectForKey:@"room_id"];
                 }
             }
             //FIXME: parse json
             [self.delegate getRoomName:room];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             [self.delegate getRoomName:@"not found."];
         }
     ];

}

- (void) sendRangeStatus:(NSString*)name beaconId:(NSString*)beaconId curStatus:(NSString*)curStatus
{
    AFHTTPRequestOperationManager *afManager = [AFHTTPRequestOperationManager manager];
    NSDictionary* param = @{@"name" : name, @"beacon_id" : beaconId, @"cur_status" : curStatus};
    [afManager POST:@"http://beacon-api-rails.herokuapp.com/api/beacon_client" parameters:param
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"response: %@", responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }
     ];
}

@end

//
//  BeaconAPI.h
//  BeaconReceiver
//
//  Created by 高橋 勲 on 2014/01/19.
//  Copyright (c) 2014年 高橋 勲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@protocol BeaconAPIDelegate <NSObject>

- (void) connectionResult:(Boolean)status;
- (void) getRoomName:(NSString*)roomName;

@end

@interface BeaconAPI : NSObject

@property(nonatomic)id<BeaconAPIDelegate> delegate;

// api/ping
- (Boolean) makeConnectionToAPI;

// api/room
- (void) getRoomNameWithBeaconID:(NSString*)beaconId;

// api/beacon_client
- (void) sendRangeStatus:(NSString*)name beaconId:(NSString*)beaconId curStatus:(NSString*)curStatus;


@end

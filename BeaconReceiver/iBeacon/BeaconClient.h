//
//  beaconClient.h
//  BeaconReceiver
//
//  Created by 高橋 勲 on 2014/01/19.
//  Copyright (c) 2014年 高橋 勲. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol BeaconClientDeletage <NSObject>

- (void) fixedRangeStatus:(NSString*)status;
- (void) enteredToRegion;
- (void) exitedFromRegion;

@end

@interface BeaconClient : NSObject <CLLocationManagerDelegate>

@property (nonatomic) id<BeaconClientDeletage> delegate;

@property (strong, nonatomic) NSString *uuid;
@property (strong, nonatomic) NSUUID *proximityUUID;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLBeaconRegion *region;

+ (BeaconClient*) getInstance;
- (void) start;
- (void) stop;

@end

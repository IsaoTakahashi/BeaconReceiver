//
//  beaconClient.m
//  BeaconReceiver
//
//  Created by 高橋 勲 on 2014/01/19.
//  Copyright (c) 2014年 高橋 勲. All rights reserved.
//

#import "BeaconClient.h"

static BeaconClient *singlton;

@interface BeaconClient()
- (BeaconClient*) initWithUUIDString:(NSString*)uuidString;
@end

@implementation BeaconClient

NSString *UUID = @"CF206B5E-D509-40AA-97E9-D3D3B02B97CF";

+ (BeaconClient*) getInstance
{
    if (singlton == nil) {
        singlton = [[BeaconClient alloc] initWithUUIDString:UUID];
    }
    return singlton;
}

- (id) initWithUUIDString:(NSString*)uuidString {
    if (self = [self init]) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        
        // generate NSUUID
        self.uuid = uuidString;
        self.proximityUUID = [[NSUUID alloc] initWithUUIDString:self.uuid];
        
        // generate CLBeaconRegion
        self.region = [[CLBeaconRegion alloc]
                       initWithProximityUUID:self.proximityUUID
                       identifier:@"com.isao.ten"];
        self.region.notifyOnEntry = YES;
        self.region.notifyOnExit = YES;
        self.region.notifyEntryStateOnDisplay = NO;
    }
    
    return self;
}

- (void) start
{
    // start monitoring region
    [self.locationManager startMonitoringForRegion:self.region];
    // start ranging distance
    [self.locationManager startRangingBeaconsInRegion:self.region];
}

- (void) stop
{
    // start monitoring region
    [self.locationManager stopMonitoringForRegion:self.region];
    // start ranging distance
    [self.locationManager stopRangingBeaconsInRegion:self.region];
}

// called when entered into Beacon
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self sendNotification:@"didEnterRegion"];
}

// called when exited from Beacon
- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self sendNotification:@"didExitRegion"];
}

// called when the status between client and Beacon is determined
- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state
              forRegion:(CLRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    switch (state) {
        case CLRegionStateInside:
            NSLog(@"CLRegionStateInside");
            break;
        case CLRegionStateOutside:
            NSLog(@"CLRegionStateOutside");
            break;
        case CLRegionStateUnknown:
            NSLog(@"CLRegionStateUnknown");
            break;
        default:
            break;
    }
}


- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    CLProximity proximity = CLProximityUnknown;
    NSString *proximityString = @"Unknown";
    CLLocationAccuracy locationAccuracy = 0.0;
    
    // 最初のオブジェクト = 最も近いBeacon
    CLBeacon *beacon = beacons.firstObject;
    
    proximity = beacon.proximity;
    locationAccuracy = beacon.accuracy;
    
    CGFloat alpha = 1.0;
    switch (proximity) {
        case CLProximityUnknown:
            proximityString = @"Unknown";
            alpha = 0.3;
            break;
        case CLProximityImmediate:
            proximityString = @"Immediate";
            alpha = 1.0;
            break;
        case CLProximityNear:
            proximityString = @"Near";
            alpha = 0.8;
            break;
        case CLProximityFar:
            proximityString = @"Far";
            alpha = 0.5;
            break;
        default:
            break;
    }
    
    //send status to server
    [self.delegate fixedRangeStatus:proximityString];
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"kCLAuthorizationStatusNotDetermined");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"kCLAuthorizationStatusRestricted");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"kCLAuthorizationStatusDenied");
            break;
        case kCLAuthorizationStatusAuthorized:
            NSLog(@"kCLAuthorizationStatusAuthorized");
            break;
        default:
            break;
    }
}

- (void)sendNotification:(NSString*)message
{
    // 通知を作成する
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = [[NSDate date] init];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.alertBody = message;
    notification.alertAction = @"Open";
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    // 通知を登録する
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end

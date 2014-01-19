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

@end

@interface BeaconAPI : NSObject

@property(nonatomic)id<BeaconAPIDelegate> delegate;


- (Boolean) makeConnectionToAPI;

@end

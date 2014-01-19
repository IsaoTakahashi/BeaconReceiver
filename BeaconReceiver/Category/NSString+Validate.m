//
//  NSString+Validate.m
//  UtilTest
//
//  Created by 高橋 勲 on 2012/10/20.
//  Copyright (c) 2012年 高橋 勲. All rights reserved.
//

#import "NSString+Validate.h"

@implementation NSString (Validate)

- (Boolean) isEmpty {
    if (self != nil) {
        if (self.length > 0) {
            return false;
        }
    }
    
    return true;
}


+ (NSString*) stringWithDate:(NSDate*)date format:(NSString*)format {
    NSDateFormatter *f = [NSDateFormatter new];
    [f setDateFormat:format];
    
    return [f stringFromDate:date];
}

@end

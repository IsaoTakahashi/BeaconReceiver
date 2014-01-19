//
//  NSString+URLEncoding.m
//  ScheduleConcierge
//
//  Created by 高橋 勲 on 2013/05/25.
//  Copyright (c) 2013年 高橋 勲. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

-(NSString*)escapedString {
    return (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                         kCFAllocatorDefault,
                                                                         (CFStringRef)self,
                                                                         NULL,
                                                                         (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                         kCFStringEncodingUTF8));
}

@end

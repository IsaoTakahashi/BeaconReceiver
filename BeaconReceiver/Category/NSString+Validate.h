//
//  NSString+Validate.h
//  UtilTest
//
//  Created by 高橋 勲 on 2012/10/20.
//  Copyright (c) 2012年 高橋 勲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)
- (Boolean) isEmpty;
+ (NSString*) stringWithDate:(NSDate*)date format:(NSString*)format; //TODO: will move to another category later
@end

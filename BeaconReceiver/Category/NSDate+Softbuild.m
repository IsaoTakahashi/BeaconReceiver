//
//  NSDate+Softbuild.m
//  ScheduleConcierge
//
//  Created by 高橋 勲 on 2013/05/25.
//  Copyright (c) 2013年 高橋 勲. All rights reserved.
//

#import "NSDate+Softbuild.h"

@implementation NSDate (Softbuild)

- (NSInteger) weekday {
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* comps = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    return comps.weekday;
}

- (NSString*) stringShortweekday {
    static NSString* const array[] = {nil, @"日", @"月", @"火", @"水", @"木", @"金", @"土"};
    NSInteger index = [self weekday];
    if (index > 7) index = 0;
    return array[index];
}

- (NSString*) stringShortweekdayEn {
    static NSString* const array[] = {nil, @"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat"};
    NSInteger index = [self weekday];
    if (index > 7) index = 0;
    return array[index];
}

- (NSDate*) tommorow {
    return [self addDay:1];
}
- (NSDate*) yesterday {
    return [self subDay:1];
}

- (NSDate*) addDay:(int)day {
    return [NSDate dateWithTimeInterval:day*24*60*60 sinceDate:self];
}
- (NSDate*) subDay:(int)day {
    return [self addDay:-day];
}

- (NSDate*) addHour:(int)hour {
    return [NSDate dateWithTimeInterval:hour*60*60 sinceDate:self];
}
- (NSDate*) subHour:(int)hour {
    return [self addHour:-hour];
}

- (NSDate*) addMinute:(int)min {
    return [NSDate dateWithTimeInterval:min*60 sinceDate:self];
}
- (NSDate*) subMinute:(int)min {
    return [self addMinute:-1];
}

- (NSInteger) getHour {
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* comp = [calendar components:NSHourCalendarUnit fromDate:self];
    
    return comp.hour;
}
- (NSInteger) getMinute {
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* comp = [calendar components:NSMinuteCalendarUnit fromDate:self];
    
    return comp.minute;
}

- (NSInteger) getSecond {
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* comp = [calendar components:NSSecondCalendarUnit fromDate:self];
    
    return comp.second;
}

- (NSDate*)boundaryForCalendarUnit:(NSCalendarUnit)calendarUnit
{
    NSDate *boundary;
    [[NSCalendar currentCalendar] rangeOfUnit:calendarUnit startDate:&boundary interval:NULL forDate:self];
    return boundary;
}


- (NSTimeInterval) timeToDate:(NSDate*)date scale:(NSCalendarUnit)scale {
    
    if (scale == NSMonthCalendarUnit) {
        return [self diffMonthToDate:date];
    }
    
    
    NSTimeInterval diffInterval = date.timeIntervalSince1970 - self.timeIntervalSince1970;
    switch (scale) {
        case NSYearCalendarUnit:
            diffInterval /= 365;
        case NSDayCalendarUnit:
            diffInterval /= 24;
        case NSHourCalendarUnit:
            diffInterval /= 60;
        case NSMinuteCalendarUnit:
            diffInterval /= 60;
        case NSSecondCalendarUnit:
            break;
        default:
            diffInterval = 0;
            break;
    }
    
    return diffInterval;
}

- (NSInteger) diffMonthToDate:(NSDate*)date {
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* selfComp = [calendar components:NSMonthCalendarUnit fromDate:self];
    NSDateComponents* targetComp = [calendar components:NSMonthCalendarUnit fromDate:date];
    
    return targetComp.month - selfComp.month;
}

- (NSDate*) truncWithScale:(NSCalendarUnit)scale {
    return [self boundaryForCalendarUnit:scale];
}

+ (NSDate*) dateWithString:(NSString*)dateString format:(NSString*)format {
    NSDate *date = nil;
    
    NSDateFormatter *inputDateFormatter = [NSDateFormatter new];
	[inputDateFormatter setDateFormat:format];
	date = [inputDateFormatter dateFromString:dateString];
    
    
    return date;
}

@end

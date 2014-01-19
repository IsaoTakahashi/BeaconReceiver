//
//  NSDate+Softbuild.h
//  ScheduleConcierge
//
//  Created by 高橋 勲 on 2013/05/25.
//  Copyright (c) 2013年 高橋 勲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Softbuild)
// 曜日のインデックス値を取得する
- (NSInteger) weekday;
// 短い曜日(例:火曜日ならば火など)を取得する
- (NSString*) stringShortweekday;
- (NSString*) stringShortweekdayEn;

// カレンダー計算
- (NSDate*) tommorow;
- (NSDate*) yesterday;
- (NSDate*) addDay:(int)day;
- (NSDate*) subDay:(int)day;
- (NSDate*) addHour:(int)hour;
- (NSDate*) subHour:(int)hour;
- (NSDate*) addMinute:(int)min;
- (NSDate*) subMinute:(int)min;

- (NSInteger) getHour;
- (NSInteger) getMinute;
- (NSInteger) getSecond;

- (NSTimeInterval) timeToDate:(NSDate*)date scale:(NSCalendarUnit)scale;

- (NSDate*) truncWithScale:(NSCalendarUnit)scale;

+ (NSDate*) dateWithString:(NSString*)dateString format:(NSString*)format;

@end

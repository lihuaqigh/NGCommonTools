//
//  DeviceInfoManager.h
//  NGCommonTools
//
//  Created by lhq on 2018/5/10.
//  Copyright © 2018年 lhq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceInfoManager : NSObject

// 机器名称
+ (NSString *)machineName;

// 设备名称
+ (NSString *)deviceName;

// 设备尺寸
+ (CGFloat)deviceWidth;
+ (CGFloat)deviceHeight;

// UUID
+ (NSString *)deviceUUID;

// IDFA
+ (NSString *)deviceIDFA;

// 系统版本
+ (NSString *)systemVersion;

// 设备IP
+ (NSString *)deviceIP;

// 设备电量
+ (CGFloat)deviceBatteryLevel;

// 设备内存
+ (CGFloat)deviceFreeMemory;
+ (CGFloat)deviceMaxMemory;

// 系统语言
+ (NSString *)systemLanguage;

// 系统版本适配
+ (BOOL)systemMoreThan9;
+ (BOOL)systemMoreThan10;
+ (BOOL)systemMoreThanX:(CGFloat)x;

// 屏幕尺寸适配
+ (BOOL)iphoneSmall; // 窄屏手机5s及以下机型（宽度<=320）
+ (BOOL)iphonePlus;  // 宽屏手机6p及以上机型（高度> 667)
+ (BOOL)iphoneX;

@end

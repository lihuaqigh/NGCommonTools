//
//  DeviceInfoManager.m
//  NGCommonTools
//
//  Created by lhq on 2018/5/10.
//  Copyright © 2018年 lhq. All rights reserved.
//

#import "DeviceInfoManager.h"
#import "sys/utsname.h"
#import <AdSupport/AdSupport.h>
#import <sys/param.h>
#import <sys/mount.h>
#import "IPTool.h"

static NSString * const kDeviceUUIDKey = @"deviceUUID";
static NSString * const kDeviceIDFAKey = @"deviceIDFA";

@implementation DeviceInfoManager

// 设备名称
+ (NSString *)machineName {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString *)deviceName {
    NSString *deviceName = @"";
    NSString *machineName = [DeviceInfoManager machineName];
    if (!machineName) return deviceName;
    
    NSDictionary *dic = @{
                          @"iPod1,1" : @"iPod touch 1",
                          @"iPod2,1" : @"iPod touch 2",
                          @"iPod3,1" : @"iPod touch 3",
                          @"iPod4,1" : @"iPod touch 4",
                          @"iPod5,1" : @"iPod touch 5",
                          @"iPod7,1" : @"iPod touch 6",
                          
                          @"iPhone4,1" : @"iPhone 4S",
                          @"iPhone5,1" : @"iPhone 5",
                          @"iPhone5,2" : @"iPhone 5",
                          @"iPhone5,3" : @"iPhone 5c",
                          @"iPhone5,4" : @"iPhone 5c",
                          @"iPhone6,1" : @"iPhone 5s",
                          @"iPhone6,2" : @"iPhone 5s",
                          @"iPhone7,1" : @"iPhone 6 Plus",
                          @"iPhone7,2" : @"iPhone 6",
                          @"iPhone8,1" : @"iPhone 6s",
                          @"iPhone8,2" : @"iPhone 6s Plus",
                          @"iPhone8,4" : @"iPhone SE",
                          @"iPhone9,1" : @"iPhone 7",
                          @"iPhone9,2" : @"iPhone 7 Plus",
                          @"iPhone9,3" : @"iPhone 7",
                          @"iPhone9,4" : @"iPhone 7 Plus",
                          @"iPhone10,1" : @"iPhone 8",
                          @"iPhone10,4" : @"iPhone 8",
                          @"iPhone10,2" : @"iPhone 8 Plus",
                          @"iPhone10,5" : @"iPhone 8 Plus",
                          @"iPhone10,3" : @"iPhone X",
                          @"iPhone10,6" : @"iPhone X",
                          
                          @"i386" : @"Simulator x86",
                          @"x86_64" : @"Simulator x64",
                          };
    deviceName = dic[machineName];
    if (!deviceName) deviceName = machineName;
    return deviceName;
}

// 设备尺寸
+ (CGFloat)deviceWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)deviceHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

// UUID & IDFA
+ (NSString *)deviceUUID {
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceUUIDKey];
    if (uuid == (id)kCFNull) {
        uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:kDeviceUUIDKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    NSLog(@"设备唯一标志uuid-->%@", uuid);
    return uuid;
}

+ (NSString *)deviceIDFA {
    // TODO_NG_获取方式，考虑获取不到的情况
    NSString *idfa = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceIDFAKey];
    if (idfa == (id)kCFNull) {
        NSString *adid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        [[NSUserDefaults standardUserDefaults] setObject:adid forKey:kDeviceIDFAKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        idfa = adid;
    }
    NSLog(@"广告位标识符idfa-->%@", idfa);
    return idfa;
}

// 系统版本
+ (NSString *)systemVersion {
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    NSLog(@"当前系统版本号-->%@", systemVersion);
    return systemVersion;
}

// 设备IP
+ (NSString *)deviceIP {
    return [IPTool getIPAddress:YES];
}

// 设备电量
+ (CGFloat)deviceBatteryLevel {
    CGFloat batteryLevel = [[UIDevice currentDevice] batteryLevel];
    NSLog(@"电池电量-->%f", batteryLevel);
    return batteryLevel;
}

// 设备内存
+ (CGFloat)deviceFreeMemory {
    //可用大小
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return (double)freespace/1024/1024/1024;
}

+ (CGFloat)deviceMaxMemory {
    //总大小
    struct statfs buf1;
    long long maxspace = 0;
    if (statfs("/", &buf1) >= 0) {
        maxspace = (long long)buf1.f_bsize * buf1.f_blocks;
    }
    if (statfs("/private/var", &buf1) >= 0) {
        maxspace += (long long)buf1.f_bsize * buf1.f_blocks;
    }
    return (double)maxspace/1024/1024/1024;
}

// 系统语言
+ (NSString *)systemLanguage {
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages firstObject];
    NSLog(@"系统语言--%@", currentLanguage);
    return currentLanguage;
}

// 系统版本适配
+ (BOOL)systemMoreThan9 {
    return [DeviceInfoManager systemMoreThanX:9.0];
}

+ (BOOL)systemMoreThan10 {
    return [DeviceInfoManager systemMoreThanX:10.0];
}

+ (BOOL)systemMoreThanX:(CGFloat)x {
    NSString *version = [UIDevice currentDevice].systemVersion;
    return version.doubleValue >= x ? YES : NO;
}

// 屏幕尺寸适配
+ (BOOL)iphoneSmall {
    return ([DeviceInfoManager deviceWidth] <= 320) ? YES : NO;
}

+ (BOOL)iphonePlus {
    return ([DeviceInfoManager deviceHeight] > 667) ? YES : NO;
}

+ (BOOL)iphoneX {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
}

@end

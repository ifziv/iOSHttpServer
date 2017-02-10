//
//  SSIDAndPhoneIP.h
//  iOSHttpServer
//
//  Created by ziv on 2017/2/9.
//  Copyright © 2017年 ziv. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SystemConfiguration/CaptiveNetwork.h>

#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>

@interface SSIDAndPhoneIP : NSObject

+ (NSString *)fetchNetSSIDInfo;

+ (NSString *)getDeviceIPIpAddresses;

@end

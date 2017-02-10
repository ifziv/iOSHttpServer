//
//  RootViewController.h
//  iOSHttpServer
//
//  Created by ziv on 2017/2/9.
//  Copyright © 2017年 ziv. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

#import "CustomHTTPConnection.h"
#import "SSIDAndPhoneIP.h"

// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface RootViewController : UIViewController
{
    HTTPServer *httpServer;
}

@end

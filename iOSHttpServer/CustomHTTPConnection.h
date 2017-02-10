//
//  CustomHTTPConnection.h
//  iOSHttpServer
//
//  Created by ziv on 2017/2/9.
//  Copyright © 2017年 ziv. All rights reserved.
//

/*
 * 重写父类的方法。
 */

#import <UIKit/UIKit.h>

#import "HTTPConnection.h"

#define UPLOAD_FILE_PROGRESS @"uploadfileprogress"

@interface CustomHTTPConnection : HTTPConnection
{
    int             dataStartIndex;
    BOOL            postHeaderOK;
    NSMutableArray  *multipartData;
}

@end

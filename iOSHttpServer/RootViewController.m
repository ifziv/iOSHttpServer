//
//  RootViewController.m
//  iOSHttpServer
//
//  Created by ziv on 2017/2/9.
//  Copyright © 2017年 ziv. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"WiFi传文件";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self initHttpServer];
    
    NSString *ssidName = [SSIDAndPhoneIP fetchNetSSIDInfo];
    NSString *ipAddr = [SSIDAndPhoneIP getDeviceIPIpAddresses];
    NSLog(@"%@ == %@", ssidName, ipAddr);
    
    UILabel *ssidLabel = [[UILabel alloc] init];
    ssidLabel.frame = CGRectMake(20, 120, [UIScreen mainScreen].bounds.size.width - 40, 35);
    ssidLabel.backgroundColor = [UIColor clearColor];
    ssidLabel.textAlignment = NSTextAlignmentCenter;
    ssidLabel.textColor = [UIColor grayColor];
    [self.view addSubview:ssidLabel];
    
    if ([ssidName isEqualToString:@""] || ssidName != NULL) {
        ssidLabel.text = [NSString stringWithFormat:@"SSID:%@", ssidName];
    }
    
    UILabel *fontLabel = [[UILabel alloc] init];
    fontLabel.frame = CGRectMake(20, 220, [UIScreen mainScreen].bounds.size.width - 40, 35);
    fontLabel.backgroundColor = [UIColor clearColor];
    fontLabel.textAlignment = NSTextAlignmentCenter;
    fontLabel.textColor = [UIColor grayColor];
    fontLabel.text = [NSString stringWithFormat:@"在电脑浏览器中输入"];
    [self.view addSubview:fontLabel];
    
    UILabel *netLabel = [[UILabel alloc] init];
    netLabel.frame = CGRectMake(20, 245, [UIScreen mainScreen].bounds.size.width - 40, 35);
    netLabel.backgroundColor = [UIColor clearColor];
    netLabel.textAlignment = NSTextAlignmentCenter;
    netLabel.textColor = [UIColor blackColor];
    netLabel.text = [NSString stringWithFormat:@"http://%@:8080", ipAddr];
    [self.view addSubview:netLabel];
    
    UILabel *warnLabel = [[UILabel alloc] init];
    warnLabel.frame = CGRectMake(20, 320, [UIScreen mainScreen].bounds.size.width - 40, 75);
    warnLabel.backgroundColor = [UIColor clearColor];
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.textColor = [UIColor grayColor];
    warnLabel.numberOfLines = 0;
    warnLabel.text = [NSString stringWithFormat:@"提示：\nWiFi传文件功能已经开启\n传输过程中请勿关闭此页或者锁屏"];
    [self.view addSubview:warnLabel];


}

- (void)initHttpServer
{
    /**
     * 1. Configure our logging framework.
     *    To keep things simple and fast, we're just going to log to the Xcode console.
     *
     * 2. Create server using our custom CustomHTTPServer class.
     * 
     * 3. Tell the server to broadcast its presence via Bonjour.
     *    This allows browsers such as Safari to automatically discover our service.
     * 
     * 4. Normally there's no need to run our server on any specific port.
     *    Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
     *    However, for easy testing you may want force a certain port so you can just hit the refresh button.
     *
     * 5. We're going to extend the base HTTPConnection class with our CustomHTTPConnection class.
     *    This allows us to do all kinds of customizations.
     *
     * 6. Serve files from our embedded Web folder.
     *
     * 7. Start.
     **/
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    httpServer = [[HTTPServer alloc] init];
    
    [httpServer setType:@"_http._tcp."];
    
    [httpServer setPort:8080];
    
    [httpServer setConnectionClass:[CustomHTTPConnection class]];
    
    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    DDLogInfo(@"Setting document root: %@", webPath);
    
    [httpServer setDocumentRoot:webPath];
    
    [self startServer];
}

- (void)startServer
{
    // Start the server (and check for problems)
    NSError *error;
    if([httpServer start:&error])
    {
        DDLogInfo(@"Started HTTP Server on port %hu", [httpServer listeningPort]);
    }
    else
    {
        DDLogError(@"Error starting HTTP Server: %@", error);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

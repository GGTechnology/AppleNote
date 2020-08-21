//
//  ViewController.m
//  iOS如何获取IDFA
//
//  Created by kadis on 2019/11/13.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import <AdSupport/AdSupport.h>

@interface ViewController ()

@end

@implementation ViewController
{
    NSString *adid;
    NSString *OS;
    NSString *source;
    NSString *timestamp;
    NSString *event_type;
    NSString *signature;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // muid 获取设备 adid
    adid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog(@"🍏 = \n%@", adid);
    adid = @"28FC11CB-98BC-4BF9-8CA5-7C65A3463CE6";
    
    // os 系统平台
    OS = @"ios";
    
    // source 「假设数据是第一次打开」
    source = @"first";
   
    // conv_time    时间戳
    NSLog(@"🍎 = \n%f",  [[NSDate date] timeIntervalSince1970]);
    NSTimeInterval time =[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    timestamp = [NSString stringWithFormat:@"%.0f", time];
    NSLog(@"🍊 = \n%@",  timestamp);
    
    // event_type 「区分达到的转化目标：假设是“激活”」
    event_type = @"1";
    
    // signature
    signature = @"test";
    
    NSString *aurl = [NSString stringWithFormat:@"http://ad.toutiao.com/track/activate/?callback=CALLBACK_PARAM&muid=%@&os=%@&source=%@&conv_time=%@&event_type=%@", adid, OS, source, timestamp, event_type];
    NSLog(@"%@", aurl);
    
//    [self getDataWith:@"https://gitee.com/ggkeji/AppleNote/raw/master/Source/note/apple0.json"];

    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(getDataWith) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)getDataWith {
    timestamp = @"2019-11-14 15:08:25";
    
    NSString *aurl = [NSString stringWithFormat:@"http://ad.toutiao.com/track/activate/?callback=__CALLBACK_PARAM__&muid=%@&os=%@&source=%@&conv_time=%@&event_type=%@", adid, OS, source, timestamp, event_type];
    NSLog(@"🍏 = %@", aurl);
    
    NSString *cc = @"https://at.umtrack.com/meCGvq?cid=478&clickid=__CALLBACK_PARAM__&idfa=__IDFA__&mac=__MAC__&ts=__TS__&ip=__IP__&os=__OS__&ua=__UA__&s2s=1&oaid=__OAID__";
    
    
    NSURL * url = [NSURL URLWithString:aurl];
    //网络请求对象
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession * session = [NSURLSession sharedSession];
    //请求任务
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //主线程
        dispatch_async(dispatch_get_main_queue(), ^{
        //解析json数据
            if (!error) {
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"result = %@",result);
            } else {
                NSLog(@"error : %@",error);
            }
        });
    }];
    
    //手动开启任务
    [dataTask resume];
}

@end

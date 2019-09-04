//
//  ViewController.m
//  UI_Window
//
//  Created by kadis on 2019/8/12.
//  Copyright © 2019 kadis. All rights reserved.
//

#import "ViewController.h"
#import "HomePagePopView.h"
#import "LGDAlert.h"
#import "AttendanceAlertView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)xib:(id)sender {
    [HomePagePopView show:@"a" subTitle:@"b" image:[UIImage imageNamed:@"aa"] content:@"c" click:^{
        
    } close:^{
        
    }];
}
- (IBAction)success:(id)sender {
    [[AttendanceAlertView shareInstance] showAlertWithSuccellCount:@"50"];
}
- (IBAction)fail:(id)sender {
    [[AttendanceAlertView shareInstance] showAlertWithFailHeadTitle:@"补签失败" textTitle:@"可重新发起好友助力，获得补签机会" leftHandle:^(id anyID) {
        NSLog(@"取消");
    } rightHandle:^(id anyID) {
        NSLog(@"邀请好友");
    }];
}
- (IBAction)friend:(id)sender {
    [[AttendanceAlertView shareInstance] showAlertWithHeadTitle:@"邀好友助力 得补签机会" supplementDate:@"补签日期: 7月22日" textTitle:@"邀请3位新用户助力补签，补签成功成功后可获得奖励" supplementTime:@"12 34 59" headIcon:nil peopleNum:@"2位" leftHandle:^(id anyID) {
        
    } rightHandle:^(id anyID) {
        NSLog(@"邀请好友");
    }];
}
- (IBAction)coin:(id)sender {
    [[AttendanceAlertView shareInstance] showAlertWithMeiCoinHeadTitle:@"美币兑换" textTitle:@"亲，是否试用美币兑换该商品～" leftHandle:^(id anyID) {
        
    } rightHandle:^(id anyID) {
        NSLog(@"确定兑换");
    }];
}
- (IBAction)vipExchange:(id)sender {
    NSLog(@"VIP可兑换余额");
    [[AttendanceAlertView shareInstance] showAlertWithVIPContentText:@"亲～您暂时还不是VIP会员不能直接用美币兑换余额，如要兑换，请开通VIP会员" buttonTitle:@"开通VIP会员" Handle:^(id anyID) {
        NSLog(@"开通会员");
    }];
}
- (IBAction)grayArea {
    [[AttendanceAlertView shareInstance] showGrayArea];
}

@end

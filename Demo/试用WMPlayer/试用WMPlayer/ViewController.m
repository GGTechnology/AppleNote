//
//  ViewController.m
//  试用WMPlayer
//
//  Created by kadis on 2019/8/15.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import <WMPlayer.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self netVideo];
    [self localVideo];
}

// 播放网络视频
- (void)netVideo {
    WMPlayerModel *playerModel = [WMPlayerModel new];
//    playerModel.title = self.videoModel.title;
    playerModel.title = @"self.videoModel.title";
    playerModel.videoURL = [NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
    WMPlayer * wmPlayer = [[WMPlayer alloc]initPlayerModel:playerModel];
    [self.view addSubview:wmPlayer];
    [wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.view);
        make.height.mas_equalTo(wmPlayer.mas_width).multipliedBy(9.0/16);
    }];
    [wmPlayer play];
}

- (void)localVideo {
    WMPlayerModel *playerModel = [WMPlayerModel new];
//    playerModel.title = self.videoModel.title;
    playerModel.title = @"self.videoModel.title";
    NSURL *URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"4k" ofType:@"m4v"]];
    playerModel.videoURL = [NSURL URLWithString:[URL absoluteString]];
    WMPlayer * wmPlayer = [WMPlayer playerWithModel:playerModel];
    [self.view addSubview:wmPlayer];
    [wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.height.mas_equalTo(wmPlayer.mas_width).multipliedBy(9.0/16);
    }];
    [wmPlayer play];
}

@end

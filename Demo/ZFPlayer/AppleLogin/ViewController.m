//
//  ViewController.m
//  AppleLogin
//
//  Created by kadis on 2020/7/9.
//  Copyright © 2020 lvguangda. All rights reserved.
//

#import "ViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>

#import "ZFPlayer.h"
#import "ZFAVPlayerManager.h"
#import "ZFIJKPlayerManager.h"
#import "KSMediaPlayerManager.h"
#import "ZFPlayerControlView.h"
//#import "ZFNotAutoPlayViewController.h"
#import "UIView+ZFFrame.h"
#import "UIImageView+ZFCache.h"

#import "AppDelegate.h"

#ifndef __IPHONE_5_0
#warning "This project uses features only available in iOS SDK 5.0 and later."
#endif

#ifdef __OBJC__
    @import UIKit;
    @import Foundation;

// iphoneX iphoneXs iphoneXS MAX 宏定义
#define ISIPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ((NSInteger)(([[UIScreen mainScreen] currentMode].size.height/[[UIScreen mainScreen] currentMode].size.width)*100) == 216) : NO)

/// 导航栏高度
#define KNavBarHeight ISIPHONE_X ? 88 : 64

#define kAPPDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])

/// 播放器view的tag，列表中UI控件唯一tag值
#define kPlayerViewTag 100


#endif

static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";

@interface ViewController ()<ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *changeBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) NSArray <NSURL *>*assetURLs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    btn.backgroundColor = [UIColor greenColor];
//    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//
//    ASAuthorizationAppleIDButton *btn2 = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignIn authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhiteOutline];
//    [btn2 addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
//    btn2.frame = CGRectMake(50, 100, 130, 30);
//    [self.view addSubview:btn2];
//
//    NSString * str = [NSString stringWithFormat:@"%ld",[[[UIDevice currentDevice] systemVersion] integerValue]];
//    NSLog(@"\n iOS 版本 = %@", str);
    
    
    [self configuraPlayer];
    
}

- (void)action {
    if (@available(iOS 13.0, *)) {
        [self signInWithApple];
    } else {
        // Fallback on earlier versions
    }
}

- (void)signInWithApple API_AVAILABLE(ios(13.0))
{
    ASAuthorizationAppleIDProvider *provider = [[ASAuthorizationAppleIDProvider alloc] init];
    ASAuthorizationAppleIDRequest *request = [provider createRequest];
    request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
    
    ASAuthorizationController *vc = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
    vc.delegate = self;
    vc.presentationContextProvider = self;
    [vc performRequests];
}

//设置上下文
// ASAuthorizationControllerPresentationContextProviding 就一个方法，主要是告诉 ASAuthorizationController 展示在哪个 window 上。
#pragma mark - ASAuthorizationControllerPresentationContextProviding

- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)) {
    return self.view.window;
}

#pragma mark - ASAuthorizationControllerDelegate
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]])       {
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        
        NSString *state = credential.state;
        NSString *userID = credential.user;
        NSPersonNameComponents *fullName = credential.fullName;
        NSString *email = credential.email;
        NSString *authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding]; // refresh token
        NSString *identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding]; // access token
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        
        NSLog(@"🍎 state: %@", state);
        NSLog(@"🍊 userID: %@", userID);
        NSLog(@"🍏 fullName: %@", fullName);
        NSLog(@"🍋 email: %@", email);
        NSLog(@"🍇 authorizationCode: %@", authorizationCode);
        NSLog(@"🥭 identityToken: %@", identityToken);
        NSLog(@"🍉 realUserStatus: %@", @(realUserStatus));
        NSLog(@"🍐 user: %@", credential.user);
        
        NSLog(@"1⃣️ %@", fullName.familyName);
        NSLog(@"1⃣️ %@", fullName.familyName);
        NSLog(@"1⃣️ %@", fullName.familyName);
        NSLog(@"1⃣️ %@", fullName.familyName);
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0))
{
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
    }
    NSLog(@"%@", errorMsg);
}

- (void)configuraPlayer {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(pushNewVC)];
    [self.view addSubview:self.containerView];
    
    [self.containerView addSubview:self.playBtn];
    [self.view addSubview:self.changeBtn];
    [self.view addSubview:self.nextBtn];
    
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
    self.player.resumePlayRecord = YES;
    
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        kAPPDelegate.allowOrentitaionRotation = isFullScreen;
        [self setNeedsStatusBarAppearanceUpdate];
        if (!isFullScreen) {
            /// 解决导航栏上移问题
            self.navigationController.navigationBar.zf_height = KNavBarHeight;
        }
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        if (!self.player.isLastAssetURL) {
            [self.player playTheNext];
            NSString *title = [NSString stringWithFormat:@"视频标题%zd",self.player.currentPlayIndex];
            [self.controlView showTitle:title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
        } else {
            [self.player stop];
        }
    };
    
    self.player.assetURLs = self.assetURLs;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w*9/16;
    self.containerView.frame = CGRectMake(x, y, w, h);
    
    w = 44;
    h = w;
    x = (CGRectGetWidth(self.containerView.frame)-w)/2;
    y = (CGRectGetHeight(self.containerView.frame)-h)/2;
    self.playBtn.frame = CGRectMake(x, y, w, h);
    
    w = 100;
    h = 30;
    x = (CGRectGetWidth(self.view.frame)-w)/2;
    y = CGRectGetMaxY(self.containerView.frame)+50;
    self.changeBtn.frame = CGRectMake(x, y, w, h);
    
    w = 100;
    h = 30;
    x = (CGRectGetWidth(self.view.frame)-w)/2;
    y = CGRectGetMaxY(self.changeBtn.frame)+50;
    self.nextBtn.frame = CGRectMake(x, y, w, h);
}

- (void)changeVideo:(UIButton *)sender {
    NSString *URLString = @"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4";
    self.player.assetURL = [NSURL URLWithString:URLString];
    [self.controlView showTitle:@"Apple" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
}

- (void)playClick:(UIButton *)sender {
    [self.player playTheIndex:0];
    [self.controlView showTitle:@"视频标题" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
}

- (void)nextClick:(UIButton *)sender {
    if (!self.player.isLastAssetURL) {
        [self.player playTheNext];
        NSString *title = [NSString stringWithFormat:@"视频标题%zd",self.player.currentPlayIndex];
        [self.controlView showTitle:title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
    } else {
        NSLog(@"最后一个视频了");
    }
}

- (void)pushNewVC {
    NSLog(@"pushNewVC");
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
        _controlView.prepareShowControlView = YES;
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        [_containerView setImageWithURLString:kVideoCover placeholder:[self imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)]];
    }
    return _containerView;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UIButton *)changeBtn {
    if (!_changeBtn) {
        _changeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_changeBtn setTitle:@"Change video" forState:UIControlStateNormal];
        [_changeBtn addTarget:self action:@selector(changeVideo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (NSArray<NSURL *> *)assetURLs {
    if (!_assetURLs) {
        _assetURLs = @[[NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"],
                       [NSURL URLWithString:@"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4"],
                       [NSURL URLWithString:@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/peter/mac-peter-tpl-cc-us-2018_1280x720h.mp4"],
                       [NSURL URLWithString:@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/grimes/mac-grimes-tpl-cc-us-2018_1280x720h.mp4"],
                       [NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/6/H/9/EDJTRBEH9/SD/EDJTRBEH9-mobile.mp4"],
                       [NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/6/9/R/EDJTRAD9R/SD/EDJTRAD9R-mobile.mp4"],
                       [NSURL URLWithString:@"http://www.flashls.org/playlists/test_001/stream_1000k_48k_640x360.m3u8"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-video/7_517c8948b166655ad5cfb563cc7fbd8e.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/68_20df3a646ab5357464cd819ea987763a.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/118_570ed13707b2ccee1057099185b115bf.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/15_ad895ac5fb21e5e7655556abee3775f8.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/12_cc75b3fb04b8a23546d62e3f56619e85.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/5_6d3243c354755b781f6cc80f60756ee5.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-movideo/11233547_ac127ce9e993877dce0eebceaa04d6c2_593d93a619b0.mp4"]];
    }
    return _assetURLs;
}

@end

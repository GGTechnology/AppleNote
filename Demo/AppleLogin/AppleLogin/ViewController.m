//
//  ViewController.m
//  AppleLogin
//
//  Created by kadis on 2020/7/9.
//  Copyright © 2020 lvguangda. All rights reserved.
//

#import "ViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>

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
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) NSArray <NSURL *>*assetURLs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    ASAuthorizationAppleIDButton *btn2 = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignIn authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhiteOutline];
    [btn2 addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(50, 100, 130, 30);
    [self.view addSubview:btn2];

    NSString * str = [NSString stringWithFormat:@"%ld",[[[UIDevice currentDevice] systemVersion] integerValue]];
    NSLog(@"\n iOS 版本 = %@", str);

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


@end

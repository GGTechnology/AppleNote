//
//  AttendanceAlertView.m
//  UI_Window
//
//  Created by kadis on 2019/8/13.
//  Copyright © 2019 kadis. All rights reserved.
//

#import "AttendanceAlertView.h"

#define title_Font 16.0f
#define text_Font  13.0f
#define kDevice_Height [UIScreen mainScreen].bounds.size.height
#define kDevice_Width  [UIScreen mainScreen].bounds.size.width
#define NavigationBar_Height (([[UIApplication sharedApplication] statusBarFrame].size.height) + 44)
#define attendanceAlertViewWidth(x)  [UIScreen mainScreen].bounds.size.width * x / 414
#define attendanceAlertViewHeigth(y) [UIScreen mainScreen].bounds.size.height * y / 736
#define sHeight self.view.bounds.size.height
#define sWidth  self.view.bounds.size.width
#define XTabBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 34 : 0

#define HEX_COLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AttendanceAlertView () {
    dispatch_source_t timer; // 定时器
}
@property (nonatomic, copy)   ClickBlock leftButtonClickHandle;  // 取消按钮回调
@property (nonatomic, copy)   ClickBlock rightButtonClickHandle; // 取消按钮回调

@property (nonatomic, strong) UIViewController *nowVC;           // 当前VC
@property (nonatomic, strong) UIView *mainView;                  // 背景试图

@property (nonatomic, strong) UIView *bottomWhiteView;

@end

@implementation AttendanceAlertView

/// 初始化
+ (instancetype)shareInstance {
    return [[self alloc]init];
}

/// 补签成功弹窗
- (void)showAlertWithSuccellCount:(id)text {
    self.nowVC = [AttendanceAlertView getCurrentVC];
    [self addShadowBackground];
    [self setSuccessView:text];
    
    if ([self.mainView isKindOfClass:[UIView class]]) {
        [self.view addSubview:self.mainView];
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.nowVC presentViewController:self animated:YES completion:nil];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self closeView];
        });
    }
}
- (void)setSuccessView:(id)text {
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(sWidth/2-attendanceAlertViewWidth(98), sHeight/2-attendanceAlertViewWidth(63), attendanceAlertViewWidth(196), attendanceAlertViewWidth(126))];
    whiteView.backgroundColor = [UIColor whiteColor];
    [whiteView.layer setMasksToBounds:YES];
    [whiteView.layer setCornerRadius:attendanceAlertViewWidth(10)];
    [self.mainView addSubview:whiteView];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, attendanceAlertViewWidth(33), attendanceAlertViewWidth(196), attendanceAlertViewWidth(17))];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = [UIFont systemFontOfSize:attendanceAlertViewWidth(17)];
    topLabel.text = @"补签成功，获得";
    [whiteView addSubview:topLabel];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, attendanceAlertViewWidth(68), attendanceAlertViewWidth(196), attendanceAlertViewWidth(22))];
    countLabel.textAlignment = NSTextAlignmentCenter;
    NSInteger stringLength = [NSString stringWithFormat:@"%@ (美币)", text].length;
    NSString *string = [NSString stringWithFormat:@"%@ (美币)", text];
    NSMutableAttributedString *mutableAttriteStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:[string substringWithRange:NSMakeRange(0, stringLength-4)] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:attendanceAlertViewWidth(22)], NSForegroundColorAttributeName : HEX_COLOR(0xFEBE11)}];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:[string substringWithRange:NSMakeRange(stringLength-4, 4)] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:attendanceAlertViewWidth(15)], NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    [mutableAttriteStr appendAttributedString:str1];
    [mutableAttriteStr appendAttributedString:str2];
    countLabel.attributedText = mutableAttriteStr;
    [whiteView addSubview:countLabel];
}

- (void)showAlertWithFailHeadTitle:(NSString*)title
                         textTitle:(NSString *)text
                        leftHandle:(ClickBlock )leftBlock
                       rightHandle:(ClickBlock )rightBlock  {
    self.nowVC = [AttendanceAlertView getCurrentVC];
    [self addShadowBackground];
    [self setFailViewTitle:title textContent:text];
    self.leftButtonClickHandle = leftBlock;
    self.rightButtonClickHandle = rightBlock;
    
    if ([self.mainView isKindOfClass:[UIView class]]) {
        [self.view addSubview:self.mainView];
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.nowVC presentViewController:self animated:YES completion:nil];
    }
}
/// 补签失败弹窗
- (void)setFailViewTitle:(NSString *)title textContent:(NSString *)text {
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(attendanceAlertViewWidth(38), sHeight/2-attendanceAlertViewWidth(115), sWidth-attendanceAlertViewWidth(78), attendanceAlertViewWidth(230))];
    [whiteView.layer setMasksToBounds:YES];
    [whiteView.layer setCornerRadius:attendanceAlertViewWidth(10)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:whiteView];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, attendanceAlertViewWidth(40), sWidth-attendanceAlertViewWidth(78), attendanceAlertViewWidth(17))];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = [UIFont systemFontOfSize:attendanceAlertViewWidth(17)];
    topLabel.text = title;
    [whiteView addSubview:topLabel];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, attendanceAlertViewWidth(84), sWidth-attendanceAlertViewWidth(78), attendanceAlertViewWidth(15))];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.textColor = [UIColor grayColor];
    bottomLabel.font = [UIFont systemFontOfSize:attendanceAlertViewWidth(15)];
    bottomLabel.text = text;
    [whiteView addSubview:bottomLabel];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(attendanceAlertViewWidth(25), attendanceAlertViewWidth(140), attendanceAlertViewWidth(130), attendanceAlertViewWidth(46))];
    leftBtn.backgroundColor = HEX_COLOR(0xDDDDDD);
    [leftBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn.layer setMasksToBounds:YES];
    [leftBtn.layer setCornerRadius:attendanceAlertViewWidth(23)];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:attendanceAlertViewWidth(17)]];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:HEX_COLOR(0x737373) forState:UIControlStateNormal];
    [whiteView addSubview:leftBtn];
    
    CGFloat temp = (sWidth-attendanceAlertViewWidth(78))/2;
    CGFloat temp2 = temp - attendanceAlertViewWidth(155);
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(temp+temp2, attendanceAlertViewWidth(140), attendanceAlertViewWidth(130), attendanceAlertViewWidth(46))];
    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn.layer setMasksToBounds:YES];
    [rightBtn.layer setCornerRadius:attendanceAlertViewWidth(23)];
    [rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:attendanceAlertViewWidth(18)]];
    [rightBtn setTitle:@"重新补签" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.tag = 10;
    [rightBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:rightBtn];
}

/// 邀请好友补签弹窗
- (void)showAlertWithHeadTitle:(NSString *)title
                supplementDate:(NSString *)date
                     textTitle:(NSString *)text
                supplementTime:(NSString *)time
                      headIcon:(NSArray *)urlArray
                     peopleNum:(NSString *)num
                    leftHandle:(ClickBlock )leftBlock
                   rightHandle:(ClickBlock )rightBlock {
    self.nowVC = [AttendanceAlertView getCurrentVC];
    [self addShadowBackground];
    [self setFriendWithHeaderTitle:title supplementDate:date textTitle:text supplementTime:time headIcon:urlArray peopleNum:num];
    self.leftButtonClickHandle = leftBlock;
    self.rightButtonClickHandle = rightBlock;
    
    if ([self.mainView isKindOfClass:[UIView class]]) {
        [self.view addSubview:self.mainView];
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.nowVC presentViewController:self animated:YES completion:nil];
    }
}
- (void)setFriendWithHeaderTitle:(NSString *)title
                  supplementDate:(NSString *)date
                       textTitle:(NSString *)text
                  supplementTime:(NSString *)time
                        headIcon:(NSArray *)urlArray
                       peopleNum:(NSString *)num {
    CGFloat tabBottomHeight = XTabBarHeight;
    _bottomWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, sHeight, sWidth, tabBottomHeight+attendanceAlertViewWidth(395))];
    _bottomWhiteView.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_bottomWhiteView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(attendanceAlertViewWidth(10), attendanceAlertViewWidth(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _bottomWhiteView.bounds;
    maskLayer.path = maskPath.CGPath;
    _bottomWhiteView.layer.mask = maskLayer;
    [self.mainView addSubview:_bottomWhiteView];
    
    UIButton *btns = [[UIButton alloc] initWithFrame:CGRectMake(attendanceAlertViewWidth(19), attendanceAlertViewWidth(19), attendanceAlertViewWidth(26), attendanceAlertViewWidth(24))];
    [btns.layer setMasksToBounds:YES];
    [btns.layer setCornerRadius:attendanceAlertViewWidth(12)];
    btns.backgroundColor = [UIColor redColor];
    [btns addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomWhiteView addSubview:btns];
    
    UILabel *topRedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, attendanceAlertViewWidth(35), sWidth, attendanceAlertViewWidth(20))];
    topRedLabel.textColor = HEX_COLOR(0xFF3751);
    topRedLabel.text = title;
    topRedLabel.font = [UIFont systemFontOfSize:attendanceAlertViewWidth(20)];
    topRedLabel.textAlignment = NSTextAlignmentCenter;
    [_bottomWhiteView addSubview:topRedLabel];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, attendanceAlertViewWidth(85), sWidth, attendanceAlertViewWidth(16))];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = date;
    dateLabel.font = [UIFont systemFontOfSize:attendanceAlertViewWidth(16)];
    [_bottomWhiteView addSubview:dateLabel];
    
    UILabel *textTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, attendanceAlertViewWidth(119), sWidth, attendanceAlertViewWidth(13))];
    textTitle.textAlignment = NSTextAlignmentCenter;
    textTitle.text = text;
    textTitle.textColor = [UIColor grayColor];
    textTitle.font = [UIFont systemFontOfSize:attendanceAlertViewWidth(13)];
    [_bottomWhiteView addSubview:textTitle];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, attendanceAlertViewWidth(151), sWidth, attendanceAlertViewWidth(22))];
    timeLabel.textColor = HEX_COLOR(0xFF3751);
    timeLabel.text = time;
    timeLabel.font = [UIFont systemFontOfSize:attendanceAlertViewWidth(14)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [_bottomWhiteView addSubview:timeLabel];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor greenColor];
        if (i == 0) {
            CGFloat x = sWidth / 2 - attendanceAlertViewWidth(98);
            imageView.frame = CGRectMake(x, attendanceAlertViewWidth(205), attendanceAlertViewWidth(52), attendanceAlertViewWidth(52));
            if (urlArray.count > 1) {
                
            }
        } else if (i == 1) {
            CGFloat x = sWidth / 2 + attendanceAlertViewWidth(46);
            imageView.frame = CGRectMake(x, attendanceAlertViewWidth(205), attendanceAlertViewWidth(52), attendanceAlertViewWidth(52));
        } else {
            CGFloat x = sWidth / 2 - attendanceAlertViewWidth(26);
            imageView.frame = CGRectMake(x, attendanceAlertViewWidth(205), attendanceAlertViewWidth(52), attendanceAlertViewWidth(52));
        }
        [imageView.layer setMasksToBounds:YES];
        [imageView.layer setCornerRadius:attendanceAlertViewWidth(26)];
        [_bottomWhiteView addSubview:imageView];
    }
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, attendanceAlertViewWidth(276), sWidth, attendanceAlertViewWidth(16))];
    numLabel.text = num;
    numLabel.textAlignment = NSTextAlignmentCenter;
    [_bottomWhiteView addSubview:numLabel];
    
    UIButton *friendBtn = [[UIButton alloc] initWithFrame:CGRectMake(attendanceAlertViewWidth(36), attendanceAlertViewWidth(316), sWidth-attendanceAlertViewWidth(72), attendanceAlertViewWidth(50))];
    [friendBtn.layer setCornerRadius:attendanceAlertViewWidth(25)];
    [friendBtn.layer setMasksToBounds:YES];
    friendBtn.backgroundColor = [UIColor redColor];
    [friendBtn setTitle:@"邀请好友助力补签" forState:UIControlStateNormal];
    [friendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [friendBtn.titleLabel setFont:[UIFont systemFontOfSize:attendanceAlertViewWidth(19)]];
    friendBtn.tag = 11;
    [friendBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomWhiteView addSubview:friendBtn];
    
    [UIView animateWithDuration:10 animations:^{
        self.bottomWhiteView.transform = CGAffineTransformTranslate(self.bottomWhiteView.transform, 0, -attendanceAlertViewWidth(395)-tabBottomHeight);
    }];
}

/// 美币兑换弹窗
- (void)showAlertWithMeiCoinHeadTitle:(NSString *)title
                            textTitle:(NSString *)text
                           leftHandle:(ClickBlock )leftBlock
                          rightHandle:(ClickBlock )rightBlock {
    self.nowVC = [AttendanceAlertView getCurrentVC];
    [self addShadowBackground];
    [self setCoinViewTitle:title textContent:text];
    self.leftButtonClickHandle = leftBlock;
    self.rightButtonClickHandle = rightBlock;
    
    if ([self.mainView isKindOfClass:[UIView class]]) {
        [self.view addSubview:self.mainView];
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.nowVC presentViewController:self animated:YES completion:nil];
    }
}
- (void)setCoinViewTitle:(NSString *)title textContent:(NSString *)text {
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(attendanceAlertViewWidth(38), sHeight/2-attendanceAlertViewWidth(115), sWidth-attendanceAlertViewWidth(78), attendanceAlertViewWidth(230))];
    [whiteView.layer setMasksToBounds:YES];
    [whiteView.layer setCornerRadius:attendanceAlertViewWidth(10)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:whiteView];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, attendanceAlertViewWidth(40), sWidth-attendanceAlertViewWidth(78), attendanceAlertViewWidth(17))];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = [UIFont systemFontOfSize:attendanceAlertViewWidth(17)];
    topLabel.text = title;
    [whiteView addSubview:topLabel];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, attendanceAlertViewWidth(84), sWidth-attendanceAlertViewWidth(78), attendanceAlertViewWidth(15))];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.textColor = [UIColor grayColor];
    bottomLabel.font = [UIFont systemFontOfSize:attendanceAlertViewWidth(15)];
    bottomLabel.text = text;
    [whiteView addSubview:bottomLabel];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(attendanceAlertViewWidth(25), attendanceAlertViewWidth(140), attendanceAlertViewWidth(130), attendanceAlertViewWidth(46))];
    leftBtn.backgroundColor = HEX_COLOR(0xDDDDDD);
    [leftBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn.layer setMasksToBounds:YES];
    [leftBtn.layer setCornerRadius:attendanceAlertViewWidth(23)];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:attendanceAlertViewWidth(17)]];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:HEX_COLOR(0x737373) forState:UIControlStateNormal];
    [whiteView addSubview:leftBtn];
    
    CGFloat temp = (sWidth-attendanceAlertViewWidth(78))/2;
    CGFloat temp2 = temp - attendanceAlertViewWidth(155);
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(temp+temp2, attendanceAlertViewWidth(140), attendanceAlertViewWidth(130), attendanceAlertViewWidth(46))];
    rightBtn.backgroundColor = HEX_COLOR(0xDFB16B);
    [rightBtn.layer setMasksToBounds:YES];
    [rightBtn.layer setCornerRadius:attendanceAlertViewWidth(23)];
    [rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:attendanceAlertViewWidth(18)]];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.tag = 10;
    [rightBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:rightBtn];
}

/// 获取当前VC
+ (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

/// 取消按钮点击事件
- (void)cancelAction:(UIButton*)btn {
    if (self.leftButtonClickHandle) {
        self.leftButtonClickHandle(self);
    }
    [self closeView];
}

/// 确定按钮点击事件
- (void)okAction:(UIButton*)btn {
    if (self.rightButtonClickHandle) {
        self.rightButtonClickHandle(self);
    }
    [self closeView];
}

/// 消失的处理
- (void)closeView {
    if (timer) {
        dispatch_source_cancel(timer);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 添加阴影背景
- (void)addShadowBackground {
    UIView *shadowView = [[UIView alloc] initWithFrame:self.view.bounds];
    shadowView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:shadowView];
    shadowView.alpha = 0.4f;
}

/// 背景
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _mainView;
}

@end

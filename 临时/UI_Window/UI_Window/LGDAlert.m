//
//  LGDAlert.m
//  UI_Window
//
//  Created by kadis on 2019/8/12.
//  Copyright © 2019 kadis. All rights reserved.
//

#import "LGDAlert.h"

#define title_Font 16.0f
#define text_Font  13.0f
#define kDevice_Height [UIScreen mainScreen].bounds.size.height
#define kDevice_Width  [UIScreen mainScreen].bounds.size.width
#define NavigationBar_Height (([[UIApplication sharedApplication] statusBarFrame].size.height) + 44)
#define wmz_GetWNum(A)   (A)/2.0*(kDevice_Width/375)
#define wmz_GetHNum(B)   (B)/2.0*(kDevice_Height/667)
#define HEX_COLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LGDAlert ()

@property (nonatomic, copy)   NavClickBlock leftButtonClickHandle;  //取消按钮回调
@property (nonatomic, copy)   NavClickBlock rightButtonClickHandle; //取消按钮回调
@property (nonatomic, assign) AlertType type;                       //弹窗类型
@property (nonatomic, assign) CGFloat mainWidth;                    //背景宽度
@property (nonatomic, strong) UILabel *titleLabel;                  //标题视图
@property (nonatomic, strong) UILabel *mainText;                    //主要文本
@property (nonatomic, strong) UIView *mainView;                     //支付视图
@property (nonatomic, strong) UIButton *cancelBtn;                  //取消按钮
@property (nonatomic, strong) UIButton *okBtn;                      //确定按钮
@property (nonatomic, strong) UIView *leftLine;                     //中间线
@property (nonatomic, strong) UITextView *alertTextView;                          //文本写入框

@property (nonatomic, strong) UIViewController *nowVC;              //当前VC

@end


@implementation LGDAlert

//初始化
+ (instancetype)shareInstance{
    return [[self alloc]init];
}

/*
 * 简单化弹窗带回调
 *
 * @param  AlertType  弹窗类型
 * @param  title      标题内容
 * @param  text       显示内容
 * @param  leftBlock  取消按钮点击回调
 * @param  rightBlock 确定按钮点击回调
 *
 */
//简单化弹窗带回调
- (void)showAlertWithType:(AlertType)type
                headTitle:(NSString*)title
                textTitle:(id) text
               leftHandle:(NavClickBlock)leftBlock
              rightHandle:(NavClickBlock)rightBlock{
    
    [self showAlertWithType:type sueprVC:nil leftTitle:nil rightTitle:nil headTitle:title textTitle:text headTitleColor:nil textTitleColor:nil backColor:nil okBtnColor:nil cancelBtnColor:nil leftHandle:leftBlock rightHandle:rightBlock];
    
}

//最全面弹窗可以设置按钮颜色等
-  (void)showAlertWithType:(AlertType)type
                   sueprVC:(UIViewController*)VC
                 leftTitle:(NSString*)leftText
                rightTitle:(NSString*)rightText
                 headTitle:(NSString*)title
                 textTitle:(id) text
            headTitleColor:(UIColor*)titleColor
            textTitleColor:(UIColor*)textColor
                 backColor:(UIColor*)backColor
                okBtnColor:(UIColor*)okColor
            cancelBtnColor:(UIColor*)cancelColor
                leftHandle:(NavClickBlock)leftBlock
               rightHandle:(NavClickBlock)rightBlock{
    
    
    self.view.backgroundColor = [UIColor clearColor];
    if (!VC) {
        VC = [LGDAlert getCurrentVC];
    }
    self.nowVC = VC;
    
    
    id addView = [self appearViewWithType:type sueprVC:VC leftTitle:leftText rightTitle:rightText headTitle:title textTitle:text headTitleColor:titleColor textTitleColor:textColor backColor:backColor okBtnColor:okColor cancelBtnColor:cancelColor leftHandle:leftBlock rightHandle:rightBlock];
    
    if (!addView) {
        return;
    }
    
    if ([addView isKindOfClass:[UIView class]]) {
        [self.view addSubview:addView];
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [VC presentViewController:self animated:YES completion:nil];
    }else{
        [VC presentViewController:addView animated:YES completion:nil];
    }
}


//获取当前VC
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

//根据type添加不同的视图
-  (id)appearViewWithType:(AlertType)type
                  sueprVC:(UIViewController*)VC
                leftTitle:(NSString*)leftText
               rightTitle:(NSString*)rightText
                headTitle:(NSString*)title
                textTitle:(id) text
           headTitleColor:(UIColor*)titleColor
           textTitleColor:(UIColor*)textColor
                backColor:(UIColor*)backColor
               okBtnColor:(UIColor*)okColor
           cancelBtnColor:(UIColor*)cancelColor
               leftHandle:(NavClickBlock)leftBlock
              rightHandle:(NavClickBlock)rightBlock {
    self.leftButtonClickHandle = leftBlock;
    self.rightButtonClickHandle = rightBlock;
    self.type = type;
    
    switch (type) {
        case AlertTypeNornal:
        {
            return [self AlertTypeNornalViewWithLeftTitle:leftText rightTitle:rightText headTitle:title textTitle:text headTitleColor:titleColor textTitleColor:textColor backColor:backColor okBtnColor:okColor cancelBtnColor:cancelColor];
        }
            break;
        default:
            break;
    }
    
    return [UIView new];
}

// 默认弹窗
- (id)AlertTypeNornalViewWithLeftTitle:(NSString*)leftText
                            rightTitle:(NSString*)rightText
                             headTitle:(NSString*)title
                             textTitle:(id) text
                        headTitleColor:(UIColor*)titleColor
                        textTitleColor:(UIColor*)textColor
                             backColor:(UIColor*)backColor
                            okBtnColor:(UIColor*)okColor
                        cancelBtnColor:(UIColor*)cancelColor{
    [self addShadow];
    [self setMainViewWithColor:backColor withFrame:CGRectMake(0, 0, wmz_GetWNum(480), wmz_GetHNum(267)) withRadius:8.0f];
    [self setTitleLabelWithTitle:title?:@"提示" WithTextColor:titleColor?:[UIColor blackColor] WithNum:5 withFrame:CGRectMake(0, wmz_GetHNum(39), self.mainWidth-wmz_GetWNum(30), wmz_GetHNum(31)) isCenter:YES];
    [self setMaintextWithText:text WithTextColor:textColor WithNum:25 withFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+wmz_GetHNum(39), self.mainWidth-wmz_GetWNum(40), wmz_GetHNum(23)) isCenter:YES withFont:[UIFont systemFontOfSize:text_Font]];
    
    UIView *line = [self getLineViewWithColor:HEX_COLOR(0x999999) withFrame:CGRectMake(0, CGRectGetMaxY(self.mainText.frame)+wmz_GetHNum(56), self.mainWidth, 0.5f) withAlpha:0.5f];
    [self.mainView addSubview:line];
    
    if (self.leftButtonClickHandle) {
        [self setCancelBtnWithTextColor:cancelColor withTitle:leftText withFrame:CGRectMake(0, CGRectGetMaxY(line.frame), self.mainWidth/2-0.25, wmz_GetHNum(88))];
        [self.mainView addSubview:self.leftLine];
    }
    
    [self setOkBtnWithTextColor:okColor withTitle:rightText withFrame:CGRectMake(self.leftButtonClickHandle?CGRectGetMaxX(self.leftLine.frame):0, CGRectGetMaxY(line.frame), self.leftButtonClickHandle?self.mainWidth/2-0.25f:self.mainWidth, wmz_GetHNum(88))];
    
    [self reSetMainViewFrame:CGRectMake(0, 0, wmz_GetWNum(480), CGRectGetMaxY(self.okBtn.frame))];
    
    return self.mainView;
}

//添加阴影
- (void)addShadow {
    UIView *shadowView = [[UIView alloc] initWithFrame:self.view.bounds];
    shadowView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:shadowView];
    shadowView.alpha = 0.4f;
}

//mainView赋值属性
- (void)setMainViewWithColor:(UIColor*)backColor withFrame:(CGRect)frame withRadius:(CGFloat)num{
    self.mainView.layer.cornerRadius = num;
    self.mainView.layer.masksToBounds = YES;
    self.mainView.frame = frame;
    self.mainView.backgroundColor = backColor?:[UIColor whiteColor];
}
//titleLabel 赋值各自属性
- (void)setTitleLabelWithTitle:(NSString*)title WithTextColor:(UIColor*)titleColor WithNum:(NSInteger)num withFrame:(CGRect)frame isCenter:(BOOL)center{
    self.titleLabel.textColor = titleColor?:[UIColor blackColor];
    self.titleLabel.text = title;
    self.titleLabel.font = [UIFont systemFontOfSize:title_Font];
    self.titleLabel.numberOfLines = num;
    self.titleLabel.frame = frame;
    CGSize labelSize = [LGDAlert returnSizeWithLabel:self.titleLabel withRowHeight:frame.size.height];
    self.titleLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, labelSize.height);
    if (center) {
        self.titleLabel.center = CGPointMake(self.mainView.center.x, self.titleLabel.center.y);
    }
    [self.mainView addSubview:self.titleLabel];
}
//mainText赋值
- (void)setMaintextWithText:(NSString*)text WithTextColor:(UIColor*)textColor WithNum:(NSInteger)num withFrame:(CGRect)frame isCenter:(BOOL)center withFont:(UIFont*)font {
    self.mainText.textColor = textColor?:[UIColor blackColor];
    self.mainText.text = text;
    self.mainText.font = font;
    self.mainText.numberOfLines = num;
    self.mainText.frame = frame;
    if (num!=1) {
        CGSize LabelSize = [LGDAlert returnSizeWithLabel:self.mainText withRowHeight:frame.size.height];
        self.mainText.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, LabelSize.height);
    }
    if (center) {
        self.mainText.center = CGPointMake(self.mainView.center.x, self.mainText.center.y);
    }
    if (self.type==AlertTypeWrite) {
        [self.alertTextView addSubview:self.mainText];
        self.mainText.textAlignment = NSTextAlignmentLeft;
    }else{
        [self.mainView addSubview:self.mainText];
    }
}

//背景宽度
- (CGFloat)mainWidth{
    if (!_mainWidth) {
        _mainWidth = self.mainView.frame.size.width;
    }
    return _mainWidth;
}
//标题
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:title_Font];
        _titleLabel.numberOfLines = 5;
        
    }
    return _titleLabel;
}
//主体文本
- (UILabel *)mainText{
    if (!_mainText) {
        _mainText = [UILabel new];
        _mainText.textAlignment = NSTextAlignmentCenter;
    }
    return _mainText;
}
//line
- (UIView*)getLineViewWithColor:(UIColor*)lineColor withFrame:(CGRect)frame withAlpha:(CGFloat)alpha{
    UIView *line = [UIView new];
    line.alpha = alpha;
    line.backgroundColor = lineColor;
    line.frame = frame;
    return line;
}
//背景
- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
    }
    return _mainView;
}
//取消按钮
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _cancelBtn;
}
//中间线
- (UIView *)leftLine{
    if (!_leftLine) {
        _leftLine = [UIView new];
        _leftLine.alpha = 0.5;
        _leftLine.backgroundColor = HEX_COLOR(0x999999);
        _leftLine.frame = CGRectMake(CGRectGetMaxX(self.cancelBtn.frame), CGRectGetMinY(self.cancelBtn.frame), 0.5f, wmz_GetHNum(88));
    }
    return _leftLine;
}
//赋值cancelBtn
- (void)setCancelBtnWithTextColor:(UIColor*)cancelColor  withTitle:(NSString*)leftText withFrame:(CGRect)frame {
    [self.cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitle:leftText?:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:cancelColor?:HEX_COLOR(0x999999) forState:UIControlStateNormal];
    self.cancelBtn.backgroundColor = [UIColor whiteColor];
    self.cancelBtn.frame = frame;
    [self.mainView addSubview:self.cancelBtn];
}
//赋值okbtn
- (void)setOkBtnWithTextColor:(UIColor*)okColor withTitle:(NSString*)rightText withFrame:(CGRect)frame{
    self.okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.okBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.okBtn setTitle:rightText?:@"确定" forState:UIControlStateNormal];
    [self.okBtn setTitleColor:okColor?:HEX_COLOR(0xFD6615) forState:UIControlStateNormal];
    self.okBtn.backgroundColor = [UIColor whiteColor];
    self.okBtn.frame = frame;
    [self.mainView addSubview:self.okBtn];
}
//重新设置mainView的frame
- (void)reSetMainViewFrame:(CGRect)frame{
    self.mainView.frame = frame;
    self.mainView.center = self.view.center;
}

//返回文本的size 根据文本的width
+ (CGSize)returnSizeWithLabel:(UILabel*)label withRowHeight:(CGFloat)row {
    CGSize titleSize = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, label.numberOfLines==0?CGFLOAT_MAX:label.numberOfLines*(row+text_Font/3)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    return titleSize;
}

//取消按钮点击事件
- (void)cancelAction:(UIButton*)btn{
    if (self.leftButtonClickHandle) {
        self.leftButtonClickHandle(self);
    }
    [self closeView];
}

/// 确定按钮点击事件
- (void)okAction:(UIButton*)btn{
    if (self.rightButtonClickHandle) {
        self.rightButtonClickHandle(self);
    }
    [self closeView];
}

/// 消失的处理
- (void)closeView{
    if ([self.alertTextView isFirstResponder]) {
        [self.alertTextView resignFirstResponder];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

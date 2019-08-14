//
//  HomePagePopView.h
//  UI_Window
//
//  Created by kadis on 2019/8/12.
//  Copyright © 2019 kadis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePagePopView : UIView

typedef void(^BlockClose)(void);

typedef void(^BlockClick)(void);

///标题
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
///副标题
@property (weak, nonatomic) IBOutlet UILabel *labelSubTitle;
///图片
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
///文本
@property (weak, nonatomic) IBOutlet UITextView *textView;
///按钮事件
@property (nonatomic, strong) BlockClick blockClick;
///关闭
@property (nonatomic, strong) BlockClose blockClose;

///显示
+ (void)show:(nullable NSString *)title subTitle:(nullable NSString *)subtitle image:(nullable UIImage *)image content:(nullable NSString *)content click:(nullable BlockClick)click close:(nullable BlockClose)close;

///显示
- (instancetype)initWithFrame:(CGRect)frame;


@end

NS_ASSUME_NONNULL_END

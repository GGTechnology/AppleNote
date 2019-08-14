//
//  LGDAlertView.h
//  AlertView
//
//  Created by kadis on 2019/8/14.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ClickBlock)(id anyID);

@interface LGDAlertView : UIViewController

/*
 * 初始化
 */
+ (instancetype)shareInstance;

/*
 * 自动消失弹窗
 *
 */
- (void)showAlertWithText:(id)text;

/*
 *
 * 带简单回调弹窗
 *
 */
- (void)showAlertWithBlock:(id)text
               leftHandle:(ClickBlock )leftBlock
              rightHandle:(ClickBlock) rightBlock;

@end

NS_ASSUME_NONNULL_END

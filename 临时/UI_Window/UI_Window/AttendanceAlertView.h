//
//  AttendanceAlertView.h
//  UI_Window
//
//  Created by kadis on 2019/8/13.
//  Copyright © 2019 kadis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickBlock)(id anyID);

@interface AttendanceAlertView : UIViewController

/*
 * 初始化
 */
+ (instancetype)shareInstance;

/*
 * 补签成功弹窗
 *
 * @param  AlertType 弹窗类型
 * @param  coinCount 美币数量
 *
 */
- (void)showAlertWithSuccellCount:(id)text;

/*
 * 补签失败弹窗
 *
 * @param  AlertType  弹窗类型
 * @param  title      标题内容
 * @param  text       显示内容
 * @param  leftBlock  取消按钮点击回调
 * @param  rightBlock 重新补签按钮点击回调
 *
 */
- (void)showAlertWithFailHeadTitle:(NSString*)title
                textTitle:(id)text
               leftHandle:(ClickBlock )leftBlock
              rightHandle:(ClickBlock )rightBlock;

/*
 * 邀请好友补签弹窗
 *
 * @param  AlertType  弹窗类型
 * @param  title      标题内容
 * @param  date       补签日期
 * @param  text       显示内容
 * @param  time       时间倒计时
 * @param  urlArray   头像数组 URL
 * @param  num        帮助补签人数
 * @param  leftBlock  取消按钮点击回调
 * @param  rightBlock 邀请好友助力补签点击回调
 *
 */
- (void)showAlertWithHeadTitle:(NSString *)title
           supplementDate:(NSString *)date
                textTitle:(NSString *)text
           supplementTime:(NSString *)time
                 headIcon:(NSArray *)urlArray
                peopleNum:(NSString *)num
               leftHandle:(ClickBlock )leftBlock
              rightHandle:(ClickBlock )rightBlock;

@end


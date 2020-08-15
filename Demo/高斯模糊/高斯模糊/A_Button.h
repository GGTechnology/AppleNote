//
//  A_Button.h
//  高斯模糊
//
//  Created by kadis on 2020/7/22.
//  Copyright © 2020 lvguangda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, A_ButtonDirection) {
    ZUIButtonDirectionRow = 0,    // 默认样式：图像左，文字右
    ZUIButtonDirectionRowReverse  // 文字左，图像右
};

@interface A_Button : UIButton
@property (nonatomic) CGFloat spacing;
@property(nonatomic) A_ButtonDirection direction;
@end


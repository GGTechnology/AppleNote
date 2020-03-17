//
//  UIView+Extension.h
//  ZZGHapp
//
//  Created by 赵 志岩 on 17/2/28.
//  Copyright © 2017年 Ingcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat centerX;
@property (nonatomic,assign)CGFloat centerY;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGPoint origin;

-(void)addTapAction:(SEL)action forTarget:(id) aTarget;
@end

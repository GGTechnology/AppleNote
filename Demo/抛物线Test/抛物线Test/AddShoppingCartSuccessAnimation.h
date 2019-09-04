//
//  AddShoppingCartSuccessAnimation.h
//  抛物线Test
//
//  Created by kadis on 2019/8/30.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AddShoppingCartSuccessAnimation : NSObject

+ (void)animationStartPoint:(CGPoint)startPoint
                    toPoint:(CGPoint)toPoint
               controlPoint:(CGPoint)controlPoint
                      image:(UIImage*)image
             inViewControll:(UIViewController*)vc
          shoppinpCartViews:(NSArray*)shoppinpCartViewArray
                 accomplish:(void(^)(BOOL accomplish))accomplish;

@end


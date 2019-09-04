//
//  AddShoppingCartSuccessAnimation.m
//  抛物线Test
//
//  Created by kadis on 2019/8/30.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "AddShoppingCartSuccessAnimation.h"

#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width

//static AddShoppingCartSuccessAnimation *animationObj = nil;

typedef void (^AnimationAccomplish) (BOOL animationAccomplish);

@interface AddShoppingCartSuccessAnimation ()<CAAnimationDelegate> {
    CALayer                 *_addShoppingCartAnimationLayer;//添加购物车动画layer
    
    NSArray                 *_shoppinpCartViewArray;
    AnimationAccomplish     _accomplish;
}
@end

@implementation AddShoppingCartSuccessAnimation

+ (void)animationStartPoint:(CGPoint)startPoint
                    toPoint:(CGPoint)toPoint
               controlPoint:(CGPoint)controlPoint
                      image:(UIImage*)image
             inViewControll:(UIViewController*)vc
          shoppinpCartViews:(NSArray*)shoppinpCartViewArray
                 accomplish:(void(^)(BOOL accomplish))accomplish
{
    AddShoppingCartSuccessAnimation *obj =  [[AddShoppingCartSuccessAnimation alloc] initWithStartPoint:startPoint
                                                                                                toPoint:toPoint
                                                                                           controlPoint:controlPoint
                                                                                                  image:image
                                                                                         inViewControll:vc
                                                                                      shoppinpCartViews:shoppinpCartViewArray
                                                                                             accomplish:^(BOOL animationAccomplish) {
                                                                                                 
                                                                                                 if (accomplish) {
                                                                                                     accomplish(animationAccomplish);
                                                                                                 }
                                                                                             }];
}


- (instancetype)initWithStartPoint:(CGPoint)startPoint
                           toPoint:(CGPoint)toPoint
                      controlPoint:(CGPoint)controlPoint
                             image:(UIImage*)image
                    inViewControll:(UIViewController*)vc
                 shoppinpCartViews:(NSArray*)shoppinpCartViewArray
                        accomplish:(AnimationAccomplish)animationAccomplish
{
    self = [super init];
    if (self) {
        _shoppinpCartViewArray = shoppinpCartViewArray;
        _accomplish = animationAccomplish;
        
        [self startAnimationInViewControll:vc image:image];
        [self groupAnimationStartPoint:startPoint toPoint:toPoint controlPoint:controlPoint];
    }
    return self;
}


-(void)startAnimationInViewControll:(UIViewController*)vc image:(UIImage*)image
{
    if (!_addShoppingCartAnimationLayer) {
        //_btn.enabled = NO;
        _addShoppingCartAnimationLayer = [CALayer layer];
        _addShoppingCartAnimationLayer.contentsGravity = kCAGravityResizeAspectFill;
        _addShoppingCartAnimationLayer.bounds = CGRectMake(0, 0, 30, 30);
        [_addShoppingCartAnimationLayer setCornerRadius:CGRectGetHeight([_addShoppingCartAnimationLayer bounds]) / 2];
        _addShoppingCartAnimationLayer.masksToBounds = YES;
        _addShoppingCartAnimationLayer.position = CGPointMake(IPHONE_WIDTH/2, IPHONE_WIDTH/2);
        [vc.view.layer addSublayer:_addShoppingCartAnimationLayer];
    }
    if (image == nil)
        image = [UIImage imageNamed:@"app_shoppingCart"];
    _addShoppingCartAnimationLayer.contents = (__bridge id)image.CGImage;
}

-(void)groupAnimationStartPoint:(CGPoint)startPoint toPoint:(CGPoint)toPoint controlPoint:(CGPoint)controlPoint
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:toPoint controlPoint:controlPoint];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CGFloat expandTime = 0.18;
    CGFloat narrowTime = 0.8;
    
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = expandTime;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = expandTime;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
    narrowAnimation.duration = narrowTime;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.5f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    //groups.animations = @[animation,expandAnimation,];
    groups.duration = expandTime + narrowTime;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_addShoppingCartAnimationLayer addAnimation:groups forKey:@"group"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [_addShoppingCartAnimationLayer animationForKey:@"group"]) {
        [_addShoppingCartAnimationLayer removeFromSuperlayer];
        _addShoppingCartAnimationLayer = nil;
        
//        if ([_shoppinpCartViewArray isAbsoluteValid])
//        {
            CATransition *animation = [CATransition animation];
            animation.duration = 0.25f;
            CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
            shakeAnimation.duration = 0.25f;
            shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
            shakeAnimation.toValue = [NSNumber numberWithFloat:5];
            shakeAnimation.autoreverses = YES;
            for (UIView *view in _shoppinpCartViewArray)
            {
                if ([view isKindOfClass:[UIView class]]) {
                    [view.layer addAnimation:shakeAnimation forKey:nil];
                }
            }
            
            /*
             CGFloat expandTime = 0.18;
             CGFloat narrowTime = 0.8;
             
             CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
             shakeAnimation.duration = expandTime + narrowTime;;
             shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
             shakeAnimation.toValue = [NSNumber numberWithFloat:5];
             shakeAnimation.autoreverses = YES;
             
             CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
             expandAnimation.duration = expandTime;
             expandAnimation.fromValue = [NSNumber numberWithFloat:1];
             expandAnimation.toValue = [NSNumber numberWithFloat:1.2];
             expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
             
             CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
             narrowAnimation.beginTime = expandTime;
             narrowAnimation.fromValue = [NSNumber numberWithFloat:1.2f];
             narrowAnimation.duration = narrowTime;
             narrowAnimation.toValue = [NSNumber numberWithFloat:1];
             
             narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
             
             CAAnimationGroup *groups = [CAAnimationGroup animation];
             groups.animations = @[shakeAnimation,expandAnimation,narrowAnimation];
             //groups.animations = @[expandAnimation,narrowAnimation];
             groups.duration = expandTime + narrowTime;
             groups.removedOnCompletion=NO;
             groups.fillMode=kCAFillModeForwards;
             groups.delegate = self;
             
             for (UIView *view in _shoppinpCartViewArray)
             {
             if ([view isKindOfClass:[UIView class]]) {
             [view.layer addAnimation:groups forKey:@"group"];
             }
             }
             */
//        }
        
        if (_accomplish) {
            _accomplish(flag);
        }
    }
}


@end

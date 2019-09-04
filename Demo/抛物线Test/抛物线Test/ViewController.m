//
//  ViewController.m
//  抛物线Test
//
//  Created by kadis on 2019/8/30.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import "AddShoppingCartSuccessAnimation.h"

#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
#define WEAKSELF                    typeof(self) __weak weakSelf = self;
#define STRONGSELF                  typeof(weakSelf) __strong strongSelf = weakSelf;

@interface ViewController () {
        NSInteger                   _cartProductNumber;//购物车商品数量
}
@property (weak, nonatomic) IBOutlet UIView *oneV;
@property (weak, nonatomic) IBOutlet UIView *twoV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
  
    
    
}
- (IBAction)aaa:(id)sender {
    CGPoint startPoint;
    CGPoint controlPoint = CGPointMake(IPHONE_WIDTH/3,  - 80);
    
    
    startPoint = [_oneV convertPoint:_oneV.frame.origin toView:self.view];
    startPoint = CGPointMake(startPoint.x + _oneV.frame.size.width/2, startPoint.y);
    
    controlPoint = CGPointMake(IPHONE_WIDTH/2 - 40, 260);
    
    
    CGPoint toPoint = [_oneV convertPoint:_oneV.frame.origin toView:self.view];
    
    toPoint = CGPointMake(toPoint.x + _oneV.frame.size.width/2 + 4, toPoint.y);
    
    WEAKSELF
    [AddShoppingCartSuccessAnimation animationStartPoint:startPoint toPoint:toPoint controlPoint:controlPoint image:nil inViewControll:self shoppinpCartViews:@[_oneV,_twoV] accomplish:^(BOOL accomplish) {
        STRONGSELF
        if (accomplish && strongSelf) {
            //            [strongSelf->_oneV setShoppingCartProductTotalNum:strongSelf->_cartProductNumber];
        }
    }];
}


@end

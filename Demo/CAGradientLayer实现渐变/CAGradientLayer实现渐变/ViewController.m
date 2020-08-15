//
//  ViewController.m
//  CAGradientLayer实现渐变
//
//  Created by kadis on 2020/7/22.
//  Copyright © 2020 lvguangda. All rights reserved.
//

#import "ViewController.h"
#define HEXCOLOR(rgbValue)          [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)HEXCOLOR(0x3057C6).CGColor, (__bridge id)HEXCOLOR(0x133188).CGColor, (__bridge id)HEXCOLOR(0x0C266E).CGColor];
////    gradientLayer.locations = @[@0.3, @0.5, @1.0];
//    gradientLayer.locations = @[@1.0];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(0, 0.5);
//    gradientLayer.frame = self.view.bounds;
//    [self.view.layer addSublayer:gradientLayer];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(0, 1);
    gradient.frame =self.view.bounds;
    //    gradient.colors = [NSArray arrayWithObjects:(id)HEXCOLOR(0x3057C6).CGColor,(id)HEXCOLOR(0x133188).CGColor,nil];
    gradient.colors = @[(__bridge id)HEXCOLOR(0x3057C6).CGColor, (__bridge id)HEXCOLOR(0x133188).CGColor, (__bridge id)HEXCOLOR(0x0C266E).CGColor];
    [self.view.layer insertSublayer:gradient atIndex:0];
}


@end

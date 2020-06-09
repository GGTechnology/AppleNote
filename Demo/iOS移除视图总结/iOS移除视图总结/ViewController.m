//
//  ViewController.m
//  iOS移除视图总结
//
//  Created by kadis on 2020/6/6.
//  Copyright © 2020 lvguangda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imag0;
@property (weak, nonatomic) IBOutlet UIImageView *imag1;
@property (weak, nonatomic) IBOutlet UILabel *tag1;
@property (weak, nonatomic) IBOutlet UILabel *tag2;
@property (weak, nonatomic) IBOutlet UILabel *tag3_0;
@property (weak, nonatomic) IBOutlet UILabel *tag3_1;
@property (weak, nonatomic) IBOutlet UILabel *tag3_2;
@property (weak, nonatomic) IBOutlet UILabel *tag3_3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor brownColor];
    
    _tag1.tag = 1;
    _tag2.tag = 2;
    _tag3_0.tag = 3;
    _tag3_1.tag = 3;
    _tag3_2.tag = 3;
    _tag3_3.tag = 3;
    
    _imag0.tag = 4;
    _imag1.tag = 5;
}

// 移除所有 View
- (IBAction)clearAll:(id)sender {
//  移除所有 View，包括自己
//  [self.view removeFromSuperview];
    
// 移除添加到自己上面的 View
    for(UIView *view in [self.view subviews]) {
        [view removeFromSuperview];
    }
}
// 移除 Tag == 3 的 View
- (IBAction)clearTag3:(id)sender {
    for(UIView *tmpView in [self.view subviews]) {
        if (tmpView.tag == 3) {
            [tmpView removeFromSuperview];
        }
    }
}
// 移除 == [UIImageView Class] View
- (IBAction)clearImageView:(id)sender {
    for (UIView *myImageView in [self.view subviews]) {
        if ([myImageView isKindOfClass:[UIImageView class]]) {
            [myImageView removeFromSuperview];
        }
    }
}


@end

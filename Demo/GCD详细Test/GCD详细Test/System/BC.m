//
//  BC.m
//  GCD详细Test
//
//  Created by kadis on 2019/11/28.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "BC.h"

@interface BC () {
    CGPoint          beginPoint;
    CGFloat          rightMargin;
    CGFloat          leftMargin;
    CGFloat          topMargin;
    CGFloat          bottomMargin;
    CGMutablePathRef pathRef;
}
@property (nonatomic, strong) UIButton *crossBtn;
@end

@implementation BC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _bcTextView = [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _bcTextView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_bcTextView];
    
    [self addMoveBtn];
}

#pragma -- mark 全局移动按钮
- (void)addMoveBtn {
    _crossBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_crossBtn setImage:[UIImage imageNamed:@"change_big"] forState:UIControlStateNormal];
    _crossBtn.backgroundColor = [UIColor orangeColor];
    _crossBtn.frame = CGRectMake(100, 300, 40, 40);
    [_crossBtn.layer setCornerRadius:20];
    [self.view addSubview:_crossBtn];
    [_crossBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [_crossBtn addGestureRecognizer:pan];
    
    rightMargin = [UIScreen mainScreen].bounds.size.width-30;
    leftMargin = 30;
    bottomMargin = [UIScreen mainScreen].bounds.size.height-30-50;
    topMargin = 30+64;
    
    pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, leftMargin, topMargin);
    CGPathAddLineToPoint(pathRef, NULL, rightMargin, topMargin);
    CGPathAddLineToPoint(pathRef, NULL, rightMargin, bottomMargin);
    CGPathAddLineToPoint(pathRef, NULL, leftMargin, bottomMargin);
    CGPathAddLineToPoint(pathRef, NULL, leftMargin, topMargin);
    CGPathCloseSubpath(pathRef);
}
/// 事件
#pragma mark - 事件
- (void)btnAction:(UIButton*)sender{
    NSLog(@"🍎");
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"change_small"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.4 animations:^{
            self.crossBtn.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height);
        }];
    } else {
        [sender setImage:[UIImage imageNamed:@"change_big"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.4 animations:^{
            self.crossBtn.frame = CGRectMake(100, 300, 40, 40);
        }];
    }
}
/// 手势
- (void)handlePan:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        beginPoint = [pan locationInView:self.view];
    }
    else if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint nowPoint = [pan locationInView:self.view];
        float offsetX = nowPoint.x - beginPoint.x;
        float offsetY = nowPoint.y - beginPoint.y;
        CGPoint centerPoint = CGPointMake(beginPoint.x + offsetX, beginPoint.y + offsetY);
        if (CGPathContainsPoint(pathRef, NULL, centerPoint, NO)) {
        _crossBtn.center = centerPoint;
        } else {
            if (centerPoint.y>bottomMargin) {
                if (centerPoint.x<rightMargin&nowPoint.x>leftMargin) {
                    _crossBtn.center = CGPointMake(beginPoint.x + offsetX, bottomMargin);
                }
            }
            else if (centerPoint.y<topMargin) {
                if (centerPoint.x<rightMargin&nowPoint.x>leftMargin) {
                    _crossBtn.center = CGPointMake(beginPoint.x + offsetX, topMargin);
                }
            }
            else if (centerPoint.x>rightMargin) {
                _crossBtn.center = CGPointMake(rightMargin, beginPoint.y + offsetY);
            }
            else if (centerPoint.x<leftMargin) {
                _crossBtn.center = CGPointMake(leftMargin, beginPoint.y + offsetY);
            }
        }
    }
    else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateFailed) {
        
    }
}

@end

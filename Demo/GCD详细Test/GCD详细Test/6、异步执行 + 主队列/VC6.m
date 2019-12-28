//
//  VC6.m
//  GCD详细Test
//
//  Created by kadis on 2019/12/21.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "VC6.h"

@interface VC6 () {
    CGPoint          beginPoint;
    CGFloat          rightMargin;
    CGFloat          leftMargin;
    CGFloat          topMargin;
    CGFloat          bottomMargin;
    CGMutablePathRef pathRef;
}
@property (nonatomic, strong) UIButton *crossBtn; 
@end

@implementation VC6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

#pragma mark - 事件
- (void)btnAction:(UIButton*)sender{
    NSLog(@"🍎");
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"change_small"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1.0 animations:^{
            _crossBtn.frame = CGRectMake(100, 300, 100, 100);
        }];
    } else {
        [sender setImage:[UIImage imageNamed:@"change_big"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1.0 animations:^{
            _crossBtn.frame = CGRectMake(100, 300, 40, 40);
        }];
    }
}

#pragma mark - 手势
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

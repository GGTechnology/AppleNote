//
//  ViewController.m
//  MasonryAnimation
//
//  Created by kadis on 2019/9/5.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

#import "CHPlayerView.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define MS [UIScreen mainScreen].bounds.size.width/2
#define VV self.view

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *red;
@property (nonatomic, strong) UIView *green;

@property (strong, nonatomic) CHPlayerView * playerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_red mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@300);
        make.centerX.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    _green = [[UIView alloc] init];
    _green.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_green];
    [_green mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.centerX.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self greenAnimation];
    });
    
    
    NSString *strUrl = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    CGRect rect = CGRectMake((self.view.frame.size.width-300)/2.0f, 300, 300, 200);
    CHPlayerView * playerView = [[CHPlayerView alloc] initWithFrame:rect playerType:PlayerTypeOfNavigationBar autoPlay:YES];
    [self.view addSubview:playerView];
    self.playerView = playerView;
    playerView.playerUrl = strUrl;
    playerView.videoTitle = @"Taylor Swift";
    WS(weakSelf);

    //可选 ===
    playerView.playerEndBlock = ^(){
         weakSelf.playerView.playerUrl = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
         weakSelf.playerView.videoTitle = @"Taylor Swift style!!";
    };
}
- (void)greenAnimation {
    [UIView animateWithDuration:3.0 animations:^{
        [self->_green mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
            make.centerX.equalTo(@0);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        [self.view.superview layoutIfNeeded];
    }];
}

- (IBAction)left {
    [_red mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@300);
        make.left.equalTo(@50);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [UIView animateWithDuration:1.0 animations:^{
         [self->_red.superview layoutIfNeeded];
    }];
}
- (IBAction)right {
    [_red mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@300);
        make.right.equalTo(@-50);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [UIView animateWithDuration:1.0 animations:^{
        [self->_red.superview layoutIfNeeded];
    }];
}
- (IBAction)up {
    [_red mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@200);
        make.centerX.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [UIView animateWithDuration:1.0 animations:^{
        [self->_red.superview layoutIfNeeded];
    }];
}
- (IBAction)down {
    [_red mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-200);
        make.centerX.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [UIView animateWithDuration:1.0 animations:^{
        [self->_red.superview layoutIfNeeded];
    }];
}
- (IBAction)big {
    [_red mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    [UIView animateWithDuration:1.0 animations:^{
        [self->_red.superview layoutIfNeeded];
    }];
}
- (IBAction)small {
    [_red mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [UIView animateWithDuration:1.0 animations:^{
        [self->_red.superview layoutIfNeeded];
    }];
}
- (IBAction)longDetail {
    [_red mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 200));
    }];
    [UIView animateWithDuration:1.0 animations:^{
        [self->_red.superview layoutIfNeeded];
    }];
}
- (IBAction)duration:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
        [self->_red mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 150));
        }];
        [self->_red.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            [self->_red mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
            [self->_red.superview layoutIfNeeded];
        }];
    }];
}
- (IBAction)reset {
    [_red mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@300);
        make.centerX.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [UIView animateWithDuration:1.0 animations:^{
        [self->_red.superview layoutIfNeeded];
    }];
}

@end

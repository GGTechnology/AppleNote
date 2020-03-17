//
//  rootVC.m
//  GCDTest
//
//  Created by kadis on 2020/3/17.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "rootVC.h"
#define bw self.view.backgroundColor=[UIColor whiteColor];
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define hex(rgbHex) [UIColor colorWithRed:((float)((rgbHex & 0xFF0000) >> 16))/255.0 green:((float)((rgbHex & 0xFF00) >> 8))/255.0 blue:((float)(rgbHex & 0xFF))/255.0 alpha:1.0]

@interface rootVC ()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView     *bgView;
@end

@implementation rootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *codeBtn = [[UIBarButtonItem alloc]initWithTitle:@"代码" style:UIBarButtonItemStylePlain target:self action:@selector(code)];
    [codeBtn setTintColor:[UIColor redColor]];
    UIBarButtonItem *resultBtn = [[UIBarButtonItem alloc]initWithTitle:@"结果" style:UIBarButtonItemStylePlain target:self action:@selector(result)];
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(close)];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: codeBtn, resultBtn, closeBtn, nil]];
}

- (UITextView *)textView {
    if (!_textView) {
        #define statusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(5, statusHeight+49, kWidth-10, kHeight-statusHeight-54)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _textView.layer.borderWidth = 5;
        _textView.editable = NO;
        _textView.selectable = NO;
        _textView.backgroundColor = [UIColor blackColor];
        _textView.textColor = hex(0x09FA95);
        _textView.font = [UIFont systemFontOfSize:15];
        NSString *str = @"   Hello world!   ";
        //    for (NSInteger i = 0; i < 300; i++) {
        //        str = [NSString stringWithFormat:@"Hello world!   %@", str];
        //    }
        _textView.text = str;
    }
    return _textView;
}
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, statusHeight+44, kWidth, kHeight-statusHeight-44)];
        _bgView.backgroundColor = [UIColor darkGrayColor];
    }
    return _bgView;
}

- (void)code {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (self.codeStr) {
        self.textView.text = self.codeStr;
    }
    [rootViewController.view addSubview:self.bgView];
    [rootViewController.view addSubview:self.textView];
}

- (void)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (self.resultStr) {
        self.textView.text = self.resultStr;
    }
    [rootViewController.view addSubview:self.bgView];
    [rootViewController.view addSubview:self.textView];
}

- (void)close {
    [self.bgView removeFromSuperview];
    [self.textView removeFromSuperview];
}

@end

//
//  ccell.m
//  自定义CollectionViewFlowLayout
//
//  Created by kadis on 2019/11/29.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ccell.h"

@implementation sBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnArray = @[@0,@0];
    }
    return self;
}
- (void)setBtnArray:(NSArray *)btnArray {
    _btnArray = btnArray;
}
@end


@interface ccell ()
@end
@implementation ccell
{
    sBtn *btn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        btn = [[sBtn alloc] initWithFrame:self.bounds];
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(ac:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
    return self;
}

- (void)ac:(sBtn *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.backgroundColor = [UIColor yellowColor];
    } else {
        btn.backgroundColor = [UIColor redColor];
        btn.btnArray = @[@0];
    }
    
    if (self.block) {
        self.block(btn.tag);
    }
    if (self.cellBlock) {
        self.cellBlock(btn.btnArray);
    }
}
- (void)setCellArray:(NSArray *)cellArray {
    _cellArray = cellArray;
    btn.btnArray = _cellArray;
}

- (void)setI:(NSInteger)i {
    _i = i;
    btn.tag = _i;
}

@end

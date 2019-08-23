
//
//  views.m
//  setter属性测试
//
//  Created by kadis on 2019/8/23.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "views.h"

@implementation views

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)testArrayEvent:(NSArray *)testArray {
    _testArray = testArray;
    NSLog(@"\n_testArray = %@", _testArray);
}

- (void)setTestDic:(NSDictionary *)testDic {
    _testDic = testDic;
    NSLog(@"\n_testDic = %@", _testDic);
}

@end

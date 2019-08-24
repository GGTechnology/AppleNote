//
//  bb.h
//  Block的使用
//
//  Created by kadis on 2019/8/21.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^block3)(NSString * _Nonnull str);



NS_ASSUME_NONNULL_BEGIN

@interface bb : UIViewController

@property (nonatomic, copy) block3 block3;

@property (copy, nonatomic) void (^block)(NSDictionary *str);

@end

NS_ASSUME_NONNULL_END

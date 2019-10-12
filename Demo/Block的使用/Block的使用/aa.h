//
//  aa.h
//  Block的使用
//
//  Created by kadis on 2019/10/10.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockAA)(NSString *str, NSDictionary *dic);

@interface aa : UIView

@property (nonatomic, copy) blockAA block_a1;
@property (nonatomic, copy) blockAA block_a2;

@property (copy, nonatomic) void (^block)(NSString *str, NSDictionary *dic);

@end


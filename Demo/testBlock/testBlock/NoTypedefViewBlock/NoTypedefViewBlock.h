//
//  NoTypedefViewBlock.h
//  testBlock
//
//  Created by LvGuangDa on 2020/2/4.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoTypedefViewBlock : UIButton

@property (nonatomic, copy) void(^voidBlock)(BOOL status);

// 这种方式不方便，一般推荐使用 typedef
- (void)TimeCount:(void (^) (void))timeBlock;
@end

NS_ASSUME_NONNULL_END

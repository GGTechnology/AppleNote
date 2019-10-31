//
//  aa.h
//  Block的使用
//
//  Created by kadis on 2019/10/10.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockAA)(NSString *str, NSDictionary *dic);
typedef void(^blockBB)(NSString *str);

@interface aa : UIView

+ (instancetype) shareInstance;

//------------------------ a1 -------------------------------
@property (nonatomic, copy) blockAA block_a1;
//------------------------ a2 -------------------------------
@property (nonatomic, copy) blockAA block_a2;
//------------------------ a3 -------------------------------
- (void)changeBackgroundColorr:(blockAA )blockChange;
@property (nonatomic, copy) blockAA blockChange;
//------------------------ a4 -------------------------------
@property (nonatomic, copy) void (^blockName)(void);
//------------------------ a5 -------------------------------
- (void)blue:(blockBB )blockCC;
@property (nonatomic, copy) blockBB tempBlockBB;
//------------------------ a6 -------------------------------
@end


//
//  ButtonBlock.h
//  testBlock
//
//  Created by LvGuangDa on 2020/2/4.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import <UIKit/UIKit.h>

//
// 形式一:无传参，无返回值
//
typedef void (^firstTypeBlockName)(void);

//
// 形式二:无传参，有返回值(id)
//
typedef void (^secondTypeBlockName)(id anyID);

//
// 形式三:有传参(NSString)，有返回值(NSString)
//
typedef NSString *(^thirdTypeBlockName)(NSString *valueStr);

@interface ButtonBlock : UIView
@property (nonatomic, copy) firstTypeBlockName firstBlock;
@property (nonatomic, copy) secondTypeBlockName secondBlock;
@property (nonatomic, copy) thirdTypeBlockName thirdBlock;
@end


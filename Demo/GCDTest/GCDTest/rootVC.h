//
//  rootVC.h
//  GCDTest
//
//  Created by kadis on 2020/3/17.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface rootVC : UIViewController
@property (nonatomic, copy)   NSString *codeImageStr;
@property (nonatomic, copy)   NSString *resultStr;
- (void)loading;
- (void)close;
@end

NS_ASSUME_NONNULL_END

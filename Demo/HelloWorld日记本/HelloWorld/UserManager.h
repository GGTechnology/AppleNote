//
//  UserManager.h
//  HelloWorld
//
//  Created by kadis on 2020/4/22.
//  Copyright © 2020 Lv. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UM [UserManager sharedManager]
NS_ASSUME_NONNULL_BEGIN
@interface UserManager : NSObject
+ (UserManager *)sharedManager;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) NSArray *dateArray;
@end
NS_ASSUME_NONNULL_END




//
//  UserManager.m
//  HelloWorld
//
//  Created by kadis on 2020/4/22.
//  Copyright © 2020 Lv. All rights reserved.
//

#import "UserManager.h"
@implementation UserManager
+ (UserManager *)sharedManager {
    static UserManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}
- (NSArray *)titleArray {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"titleArray"];
}
- (void)setTitleArray:(NSArray *)titleArray {
    [[NSUserDefaults standardUserDefaults] setValue:titleArray forKey:@"titleArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSArray *)contentArray {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"contentArray"];
}
- (void)setContentArray:(NSArray *)contentArray {
    [[NSUserDefaults standardUserDefaults] setValue:contentArray forKey:@"contentArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSArray *)dateArray {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"dateArray"];
}
- (void)setDateArray:(NSArray *)dateArray {
    [[NSUserDefaults standardUserDefaults] setValue:dateArray forKey:@"dateArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end

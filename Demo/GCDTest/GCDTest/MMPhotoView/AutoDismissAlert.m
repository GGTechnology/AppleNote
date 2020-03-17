//
//  AutoDismissAlert.m
//  ZZGHapp
//
//  Created by 赵 志岩 on 2017/3/22.
//  Copyright © 2017年 Ingcare. All rights reserved.
//

#import "AutoDismissAlert.h"

@implementation AutoDismissAlert







+(void)autoDismissAlert2With:(NSString *)string{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    [[UIView appearance]setTintColor:[UIColor blackColor]];
    [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:@[@"0",@"1"] afterDelay:1.5];
}
@end

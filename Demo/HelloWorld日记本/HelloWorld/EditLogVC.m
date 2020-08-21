//
//  EditLogVC.m
//  HelloWorld
//
//  Created by kadis on 2020/4/22.
//  Copyright © 2020 Lv. All rights reserved.
//

#import "EditLogVC.h"
#import "UserManager.h"
@interface EditLogVC ()
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
@implementation EditLogVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)SaveLog:(id)sender {
    NSString *titleStr = [NSString stringWithFormat:@"%@", _titleField.text];
    NSString *contentStr = [NSString stringWithFormat:@"%@", _textView.text];
    NSString *dateStr = [self currentDateStr];
    NSMutableArray *titleArray = [NSMutableArray arrayWithArray:UM.titleArray];
    NSMutableArray *contentArray = [NSMutableArray arrayWithArray:UM.contentArray];
    NSMutableArray *dateArray = [NSMutableArray arrayWithArray:UM.dateArray];
    [titleArray addObject:titleStr];
    [contentArray addObject:contentStr];
    [dateArray addObject:dateStr];
    UM.titleArray = [titleArray copy];
    UM.contentArray = [contentArray copy];
    UM.dateArray = [dateArray copy];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"save" object:nil];
    [self.navigationController popViewControllerAnimated:NO];
}
- (NSString *)currentDateStr{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS "];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    return dateString;
}
@end

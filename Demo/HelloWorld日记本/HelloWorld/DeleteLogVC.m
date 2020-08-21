//
//  DeleteLogVC.m
//  HelloWorld
//
//  Created by kadis on 2020/4/22.
//  Copyright © 2020 Lv. All rights reserved.
//

#import "DeleteLogVC.h"
#import "UserManager.h"
@interface DeleteLogVC ()
@property (strong, nonatomic) UITextField *dateField;
@property (strong, nonatomic) UITextView *contentView;
@end
@implementation DeleteLogVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteLog)];
    [self.navigationItem setRightBarButtonItem:deleteItem];
    _dateField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
    [self.view addSubview:_dateField];
    _contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, 108, self.view.bounds.size.width, self.view.bounds.size.height-108)];
    [self.view addSubview:_contentView];
    NSMutableArray *titleArray = [NSMutableArray arrayWithArray:UM.titleArray];
    NSMutableArray *contentArray = [NSMutableArray arrayWithArray:UM.contentArray];
    NSMutableArray *dateArray = [NSMutableArray arrayWithArray:UM.dateArray];
    NSString *title = [NSString stringWithFormat:@"%@", titleArray[_page]];
    NSString *content = [NSString stringWithFormat:@"%@", contentArray[_page]];
    NSString *date = [NSString stringWithFormat:@"%@", dateArray[_page]];
    self.title = title;
    _dateField.text = date;
    _contentView.text = content;
}
- (void)deleteLog {
    NSMutableArray *titleArray = [NSMutableArray arrayWithArray:UM.titleArray];
    NSMutableArray *contentArray = [NSMutableArray arrayWithArray:UM.contentArray];
    NSMutableArray *dateArray = [NSMutableArray arrayWithArray:UM.dateArray];
    [titleArray removeObjectAtIndex:_page];
    [contentArray removeObjectAtIndex:_page];
    [dateArray removeObjectAtIndex:_page];
    UM.titleArray = [titleArray copy];
    UM.contentArray = [contentArray copy];
    UM.dateArray = [dateArray copy];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"save" object:nil];
    [self.navigationController popViewControllerAnimated:NO];
}
@end

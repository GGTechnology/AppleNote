//
//  ViewController.m
//  HelloWorld
//
//  Created by kadis on 2020/4/22.
//  Copyright © 2020 Lv. All rights reserved.
//

#import "ViewController.h"
#import "UserManager.h"
#import "DeleteLogVC.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *tableView;
}
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的日记";
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.sectionHeaderHeight = 0;
    tableView.sectionFooterHeight = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"save" object:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return UM.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *idenfier = @"tableViewIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenfier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:idenfier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", UM.titleArray[indexPath.row]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", UM.dateArray[indexPath.row]];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DeleteLogVC *vc = [[DeleteLogVC alloc] init];
    vc.page = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)refresh {
    [tableView reloadData];
}
@end

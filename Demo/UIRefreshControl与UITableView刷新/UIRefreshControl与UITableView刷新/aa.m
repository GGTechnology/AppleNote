//
//  aa.m
//  UIRefreshControl与UITableView刷新
//
//  Created by LvGuangDa on 2020/2/5.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "aa.h"

@interface aa ()
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation aa

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    self.data = [[NSMutableArray alloc] initWithObjects: @"aa", @"bb", @"cc", @"dd", @"ee", @"dd", @"ee", @"ff", @"gg", @"hh", @"ii", @"jj", @"kk", @"ll", @"mm", @"nn", @"oo", nil];
    
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
}

#pragma -- mark dataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld + %@", (long)indexPath.row, self.data[indexPath.row]];
    
    return cell;
}

#pragma -- mark DownPullAction
- (void)refreshTableView {
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中..."];
        
        // 往 data 的第一元素加点东东
        [self.data insertObject:@"down hello world" atIndex:0];
        
        // 模拟请求完成之后，回调 callBackMethod 方法，0.5秒
        [self performSelector:@selector(callBackMethod:) withObject:nil afterDelay:0.5];
    }
}

- (void)callBackMethod:(id )obj {
    // 恢复原状
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    
    // 刷新 TableView
    [self.tableView reloadData];
}

#pragma --mark UpPullAction
// 通过 tableview 的 一个 delegate 函数来判断
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 当前行数
    NSInteger row = [indexPath row];
    NSLog(@"%ld", (long)indexPath.row);
    
// cell滚到哪个地方，是否是倒数第五行，是的话添加 "正在加载..." 的效果
    if (row == (self.data.count - 5)) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 50)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120, 14, 100, 20)];
        label.text = @"正在加载...";
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(70, 12, 20, 25)];
        activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [activity startAnimating];
        
        [view addSubview:label];
        [view addSubview:activity];
        
        self.tableView.tableFooterView = view;
        
        [self performSelector:@selector(getMoreMethod) withObject:nil afterDelay:0.5];
    }
}

- (void)getMoreMethod {
    int preCount = (int)self.data.count;
    
    self.tableView.tableFooterView = nil;
    [self.data addObject:@"up hello world"];
    
    NSMutableArray *indexPath = [[NSMutableArray alloc] init];
    for (int i = preCount; i < self.data.count; i++) {
        [indexPath addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    // 在 TableView 底部添加数据
    [self.tableView insertRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationNone];
    
    // 滚动条滚到刚加载的位置
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:preCount inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end

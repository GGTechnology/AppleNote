//
//  ViewController.m
//  TableView顶部滑动自适应
//
//  Created by kadis on 2019/12/30.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
    UITableView *tableView;
    UIView *headerView;
    
    NSInteger rowCount;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    rowCount = 10;
    
    // Do any additional setup after loading the view.
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
    headerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:headerView];
    
    UIView *v = [[UIView alloc] init];
    [headerView addSubview:v];
    v.backgroundColor = [UIColor orangeColor];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_offset(10);
    }];
    
    UIView *c = [[UIView alloc] initWithFrame:CGRectMake(0, 190, self.view.frame.size.width, 10)];
    c.backgroundColor = [UIColor redColor];
    [headerView addSubview:c];
    
    UIView *k = [[UIView alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 50)];
    k.backgroundColor = [UIColor brownColor];
    [headerView addSubview:k];
    
    UIView *u = [[UIView alloc] init];
    u.backgroundColor = [UIColor cyanColor];
    [headerView addSubview:u];
    [u mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(10);
    }];
    
    tableView = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor greenColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionFooterHeight = 0;

    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.view);
        make.top.equalTo(headerView.mas_bottom);
    }];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    [btn.layer setCornerRadius:50];
    btn.backgroundColor = [UIColor purpleColor];
    [btn.layer setBorderColor:[UIColor cyanColor].CGColor];
    [btn.layer setBorderWidth:2];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)action {
    [self _scrollViewToBottom:NO];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
        //只要实现这个方法，就实现了默认滑动删除！！！！！
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            rowCount -= 1;
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rowCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld - %ld", (long)indexPath.section, (long)indexPath.row];
    switch (indexPath.section) {
        case 0:
            cell.backgroundColor = [UIColor grayColor];
            break;
        case 1:
            cell.backgroundColor = [UIColor orangeColor];
            break;
        case 2:
            cell.backgroundColor = [UIColor cyanColor];
            break;
        case 3:
            cell.backgroundColor = [UIColor blueColor];
            break;
        default:
            cell.backgroundColor = [UIColor redColor];
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat a = scrollView.contentOffset.y;
    CGFloat b = scrollView.contentInset.bottom;
    CGFloat c = scrollView.contentSize.height;
    CGFloat d = scrollView.frame.size.height;
    NSLog(@"🍏 = %f \n %f \n %f \n %f", a, b, c, d);

    CGFloat top = scrollView.contentOffset.y;
    NSLog(@"🍎 = %f", top);


    if (headerView.frame.size.height > 200) {
        if (top > 0) {
            if ((a+d)<=c) {
               headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 400 - top);
            }

        }
    } else if (headerView.frame.size.height < 401) {
        if (top < 200) {
            headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200+(201-top));
        }
    }
    if (top < 0) {
        headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 400);
    }
    if (top > 200) {
        headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    }
}

// 表示图滑动到底部
- (void)_scrollViewToBottom:(BOOL)animated {
//    if (tableView.contentSize.height > tableView.frame.size.height) {
//        CGPoint offset = CGPointMake(0, tableView.contentSize.height - tableView.frame.size.height);
//        [tableView setContentOffset:offset animated:animated];
//    }
    
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end

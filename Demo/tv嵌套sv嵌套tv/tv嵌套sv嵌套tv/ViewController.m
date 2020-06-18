//
//  ViewController.m
//  tv嵌套sv嵌套tv
//
//  Created by kadis on 2020/6/18.
//  Copyright © 2020 lvguangda. All rights reserved.
//

#import "ViewController.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *leftTV;
@property (nonatomic, strong) UIScrollView *SV;
@property (nonatomic, strong) UITableView *rightTV;
@property (nonatomic, assign) NSInteger nowTag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _leftTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth/2, kHight) style:UITableViewStylePlain];
    _leftTV.sectionHeaderHeight = 0;
    _leftTV.sectionFooterHeight = 0;
    _leftTV.delegate = self;
    _leftTV.dataSource = self;
    _leftTV.tag = 10;
    [self.view addSubview:_leftTV];
    _leftTV.backgroundColor = [UIColor blueColor];
    
    _SV = [[UIScrollView alloc] initWithFrame:CGRectMake(kWidth/2, 0, kWidth/2, kHight)];
    _SV.contentSize = CGSizeMake(kWidth, kHight);
    _SV.delegate = self;
    [self.view addSubview:_SV];
    _SV.backgroundColor = [UIColor brownColor];
    
    _rightTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHight) style:UITableViewStylePlain];
    _rightTV.sectionHeaderHeight = 0;
    _rightTV.sectionFooterHeight = 0;
    _rightTV.delegate = self;
    _rightTV.dataSource = self;
    _rightTV.tag = 20;
    [_SV addSubview:_rightTV];
    _rightTV.backgroundColor = [UIColor orangeColor];
    
    _SV.bounces = NO;
    _rightTV.bounces = NO;
    _leftTV.bounces = NO;
    _SV.showsHorizontalScrollIndicator = NO;
    _rightTV.showsVerticalScrollIndicator = NO;
    _leftTV.showsVerticalScrollIndicator = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _rightTV) {
        static NSString *right = @"rightIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:right];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:right];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        if (indexPath.row%2==0) {
            cell.backgroundColor = [UIColor greenColor];
        } else {
            cell.backgroundColor = [UIColor lightGrayColor];
        }
        
        return cell;
    } else if (tableView == _leftTV) {
        static NSString *left = @"leftIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:left];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:left];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        if (indexPath.row%2==0) {
            cell.backgroundColor = [UIColor greenColor];
        } else {
            cell.backgroundColor = [UIColor whiteColor];
        }
        
        return cell;
    } else {
        return [UITableViewCell new];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_nowTag == 10) {
        [_rightTV setContentOffset:CGPointMake(0, _leftTV.contentOffset.y) animated:NO];
    } else if (_nowTag == 20) {
        [_leftTV setContentOffset:CGPointMake(0, _rightTV.contentOffset.y) animated:NO];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_leftTV setContentOffset:CGPointMake(0, _rightTV.contentOffset.y) animated:NO];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        _nowTag = scrollView.tag;
    }
}

@end

//
//  ViewController.m
//  GCDTest
//
//  Created by LvGuangDa on 2020/3/16.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "ViewController.h"
#import "VC1.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionHeaderHeight = 0;
    tableView.sectionFooterHeight = 0;
    [self.view addSubview:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
    
    switch (indexPath.row) {
        case 0:
        {
            VC1 *vc = [VC1 new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end

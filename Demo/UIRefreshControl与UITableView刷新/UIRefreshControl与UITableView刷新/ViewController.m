//
//  ViewController.m
//  UIRefreshControl与UITableView刷新
//
//  Created by LvGuangDa on 2020/2/5.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "ViewController.h"
#import "aa.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
}
- (IBAction)presentTableViewController {
    aa *vc = [aa new];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
}


@end

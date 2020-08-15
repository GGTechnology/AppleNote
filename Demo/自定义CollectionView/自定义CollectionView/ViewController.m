//
//  ViewController.m
//  自定义CollectionView
//
//  Created by kadis on 2020/7/30.
//  Copyright © 2020 lvguangda. All rights reserved.
//

#import "ViewController.h"
#import "LGDFlowLayout.h"
#import "AC.h"

@interface ViewController () <UICollectionViewDataSource>
@end
@implementation ViewController
static  NSString *ZWCellID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    //若为UICollectionViewLayout，itemSize和scrollDirection都需要自己写，下面的类继承自UICollectionViewLayout
    LGDFlowLayout *layout = [[LGDFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(160, 160);
    CGRect rect = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width * 0.6);
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    collection.dataSource = self;
    collection.backgroundColor = [UIColor greenColor];
    [self.view addSubview:collection];
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ZWCellID];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 50, 50)];
    [btn addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor cyanColor];
}
- (void)Click {
    NSString *name = @"AC";
    Class cls = NSClassFromString(name);
    UIViewController *vc = [[cls alloc] init];
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSLog(@"请跟新最新版本");
    }
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZWCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}
@end

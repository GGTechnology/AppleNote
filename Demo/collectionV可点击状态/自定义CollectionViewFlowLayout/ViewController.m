//
//  ViewController.m
//  自定义CollectionViewFlowLayout
//
//  Created by kadis on 2019/11/29.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import "ccell.h"
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width

#define cWidth IPHONE_WIDTH/3-3.3

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor greenColor];
        [_collectionView registerClass:[ccell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MyFooter"];
        
//        MyFooter MyHeader
    }
    return _collectionView;
}
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ccell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.i = indexPath.item;
    cell.cellArray = @[@(indexPath.section), @(indexPath.item)];
    cell.block = ^(NSInteger i) {
        [self iPrintf:i];
    };
    cell.cellBlock = ^(NSArray * _Nonnull btnArray) {
        [self aPrintf:btnArray];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.item);
//    collectionView.
}
- (void)iPrintf:(NSInteger )i {
    NSLog(@"🍎 = %@", self.dataArray);
}
- (void)aPrintf:(NSArray *)btnArray {
    NSLog(@"🍐 = %@", btnArray);
    if (btnArray.count < 2) {
        [self.dataArray removeLastObject];
    } else {
        [self.dataArray addObjectsFromArray:btnArray];
    }
    NSLog(@"🍎 = %@", self.dataArray);
}

// 返回Header/Footer内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {          // Header视图
        // 从复用队列中获取HooterView
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader" forIndexPath:indexPath];
        // 设置HooterView
        headerView.backgroundColor = [UIColor redColor];
        UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是Header";
        label.textColor = [UIColor whiteColor];
        [headerView addSubview:label];
        // 返回HooterView
        return headerView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {    // Footer视图
        // 从复用队列中获取FooterView
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MyFooter" forIndexPath:indexPath];
        // 设置FooterView
        footerView.backgroundColor = [UIColor blueColor];
        UILabel *label = [[UILabel alloc] initWithFrame:footerView.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是Footer";
        label.textColor = [UIColor whiteColor];
        [footerView addSubview:label];
        // 返回FooterView
        return footerView;
    }
    return nil;
}

// 返回Header的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(IPHONE_WIDTH, 33);
}

// 返回Footer的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(IPHONE_WIDTH, 33);
}
// 返回cell之间行间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
// 返回cell之间列间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.5;
}
// 设置上左下右边界缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath {
    return CGSizeMake(cWidth, 175*(cWidth)/122);
}



@end

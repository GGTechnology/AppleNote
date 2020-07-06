//
//  ViewController.m
//  UISearchController用法
//
//  Created by kadis on 2020/6/22.
//  Copyright © 2020 lvguangda. All rights reserved.
//

#import "ViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating, UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray *allData;
@property (nonatomic, strong) NSMutableArray *searchData;
@property (nonatomic, strong) UITableView *myTable;
@property (nonatomic, strong) UISearchController *searchVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"搜索";
    
    self.allData = [NSMutableArray array];
    self.searchData = [NSMutableArray array];
    
    [self createTableView];
    [self createSearchVC];
    
    for (int i = 0; i < 100; i++) {
        [self.allData addObject:[NSString stringWithFormat:@"%d", i]];
    }
}

- (void)createTableView{
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.myTable.dataSource = self;
    self.myTable.delegate = self;
    [self.view addSubview:self.myTable];
}

-(void)createSearchVC{
    self.searchVC = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置searchVC的代理
    self.searchVC.searchResultsUpdater = self;
    //点击搜索时是否加半透明遮罩视图
    self.searchVC.obscuresBackgroundDuringPresentation = NO;
    self.searchVC.searchBar.delegate = self;
    //点击搜索框时是否隐藏原来的导航栏
    self.searchVC.hidesNavigationBarDuringPresentation = YES;
    //设置搜索框上的文字
    self.searchVC.searchBar.placeholder = @"搜索";
    self.myTable.tableHeaderView = self.searchVC.searchBar;

    //下面这两行是设置 searchVC上searchBar后面的cancle改为取消
    //   [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];
    [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].title = @"取消";
    
}

//这个方法也能设置搜索框上的cancelBtn系显示样式
#pragma mark -UISearchBarDelegate
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    [searchBar setShowsCancelButton:YES animated:YES];
////    searchBar.showsCancelButton = YES;
//    for (id view in [[searchBar.subviews objectAtIndex:0] subviews]) {
//        if ([view isKindOfClass:[UIButton class]]) {
//
//            UIButton *btn = (UIButton *)view;
//            [btn setTitle:@"取消" forState:UIControlStateNormal];
//            break;
//        }
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.searchVC.active) {
        return [self.searchData count];
    }else{
        return [self.allData count];
    }
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cellFlag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (self.searchVC.active) {
        [cell.textLabel setText:self.searchData[indexPath.row]];
    }
    else{
        [cell.textLabel setText:self.allData[indexPath.row]];
    }
    //
    return cell;
}

#pragma mark -UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *searchText = self.searchVC.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", searchText];
    if ([self.searchData count] != 0) {
        [self.searchData removeAllObjects];
    }
    
    // 直接用赋值的方法，可变数组会变成不可变 这样强转searchData仍是不可变数组，再去调removeAllObjects会崩溃
//    self.searchData = (NSMutableArray *)[self.allData filteredArrayUsingPredicate:predicate];
//    错误提示： [__NSArrayI removeAllObjects]: unrecognized selector sent to instance
    
    //以下三种方法是可以的
    [self.searchData addObjectsFromArray:[self.allData filteredArrayUsingPredicate:predicate]];
    
//    self.searchData = [[self.allData filteredArrayUsingPredicate:predicate] mutableCopy];

//    self.searchData = [NSMutableArray arrayWithArray:[self.allData filteredArrayUsingPredicate:predicate]];
    
    [self.myTable reloadData];
}

@end

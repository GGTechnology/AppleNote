//
//  ViewController.m
//  自定义xib
//
//  Created by mingcol on 2019/6/21.
//  Copyright © 2019 mingcol. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

#define CUSTOMIDFIER @"customCell"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray* tableSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:tableView];
    
    NSArray* array =
    @[@"当你老了，回顾一生，就会发觉：什么时候出国读书、什么时候决定做第一份职业、何时选定了对象而恋爱、什么时候结婚，其实都是命运的巨变。只是当时站在三岔路口，还以为是生命中普通的一天。",
      @"眼光是大格局的基础，胸襟是大格局的态度，胆识是大格局的潜力；站高看远有眼光，忍耐包容胸襟会宽阔，多学善研增胆识，海纳百川活人生，做大格局创人生，努力奋斗叙人生，人生结局定是赢！",
      @"格局就是指一个人的眼光、胸襟、胆识、心理等要素的内在。",@"一个人的发展往往受局限，其实“局限”就是格局太小，为其所限。",
      @"有自知之明的人才不显摆，因为读懂了世情繁杂，人都各有长处，天下没有完人包括自我。于是与人相处时态度就谦和不盛气凌人，而这正是获得好人缘的开始。半罐水，响叮当，满罐水，摇不响群众中不乏智慧人才；到群众中去，到群众学，才能学到更实用，更智慧的东西。孔子曰：三人行，必有我师。富贵荣华、可自我享受、一但显摆了、就浅薄无知了。就坏事了、古人不谈、今人越小时穷困而后发达之人、越想，示富、示强、修豪门、开豪车……招摇过市。生活需要多彩多姿的阳光，更需要人世间最美的感情，亲情友情。诚信为本守信任，爱生活怀有一颗感恩的心热爱生活，拥抱生活明天就会更完美。",
      @"格局"];
    self.tableSource = [NSArray arrayWithArray:array];
    
    // 注册自定义代码创建的Cell
    // tableView registerClass:<#(nullable Class)#> forCellReuseIdentifier:<#(nonnull NSString *)#>
    
    // 注册自定义Nib创建的cell
    UINib* nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CUSTOMIDFIER];
}

#pragma mark- tableview data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell* cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMIDFIER forIndexPath:indexPath];
    
    cell.labels.text = self.tableSource[indexPath.row];
    
    cell.images.backgroundColor = [UIColor redColor];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end

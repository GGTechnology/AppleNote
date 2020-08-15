//
//  VC.m
//  iOS13Present
//
//  Created by kadis on 2019/11/26.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "VC.h"

@interface VC ()

@end

@implementation VC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(glyp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
//    _shareInfoDic = {
//        miniapp = {
//            content = string--欢迎各位小仙女一起来种草~;
//            tip = ;
//            pic = https://img06.vmei.com/201909/0A25CB0400B9494AB1831B74A4B730BE.png;
//            title = string--欢迎各位小仙女一起来种草~;
//            appId = gh_5b08b212e368;
//            link = https://m.mei.com;
//            path = pages/dresser/herDresser?targetUserId=3149695&type=2;
//        };
//    }
    NSDictionary *dic = @{@1:@2, @3:@5};
    NSLog(@"%@", dic);
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [muDic setObject:@"love" forKey:@1];
    NSLog(@"muDic = %@", muDic);
    
}

- (void)glyp {
    [self dismissViewControllerAnimated:self completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

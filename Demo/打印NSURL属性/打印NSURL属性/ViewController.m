//
//  ViewController.m
//  打印NSURL属性
//
//  Created by kadis on 2020/2/25.
//  Copyright © 2020 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/search/build?id=1&page=3"];
    
    
    // --- https
    NSLog(@"--- %@", [url scheme]);           // 协议 http

    // www.baidu.com
    NSLog(@"--- %@", [url host]);             // 域名 www.baidu.com

    // https://www.baidu.com/search?id=1
    NSLog(@"--- %@", [url absoluteString]);   // 完整的url字符串 https://www.baidu.com/search/build?id=1&page=3

    // /search
    NSLog(@"--- %@", [url relativePath]);    // 相对路径 search

    // (null)
    NSLog(@"--- %@", [url port]);            // 端口 8080

    // /search
    NSLog(@"--- %@", [url path]);            // 路径 search
     
    //  官方解释：包含路径组件的数组。(只读)
    //    "/",
    //    search,
    //    build
    NSLog(@"--- %@", [url pathComponents]);  // search

    // id=1
    NSLog(@"--- %@", [url query]);           // 参数 id=1&page=3
}


@end

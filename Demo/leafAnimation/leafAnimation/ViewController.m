//
//  ViewController.m
//  leafAnimation
//
//  Created by kadis on 2019/8/29.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CAEmitterLayer *leafEmitter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.view.layer addSublayer:self.leafEmitter];  // 第一种效果
//    [self leaf];    // 第二种效果
    [self fire];    // 第三种效果
}

- (void)leaf {
    CAEmitterLayer *leafEmitter = [CAEmitterLayer layer];
    [self.view.layer addSublayer:leafEmitter];
    
    leafEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width/2, 0);//发射器中心点
    leafEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width, 0);//发射器大小，因为emitterShape设置成线性所以高度可以设置成0，
    
    leafEmitter.emitterShape = kCAEmitterLayerLine;//发射器形状为线性
    leafEmitter.emitterMode = kCAEmitterLayerOutline;//从发射器边缘发出
    
    NSMutableArray *array = [NSMutableArray array];//CAEmitterCell数组，存放不同的CAEmitterCell，我这里准备了四张不同形态的叶子图片。
    for (int i = 0; i<4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"leaf%d",i];
        
        CAEmitterCell *leafCell = [CAEmitterCell emitterCell];
        leafCell.birthRate = 2;//粒子产生速度
        leafCell.lifetime = 50;//粒子存活时间
        
        leafCell.velocity = 10;//初始速度
        leafCell.velocityRange = 5;//初始速度的差值区间，所以初始速度为5~15，后面属性range算法相同
        
        leafCell.yAcceleration = 2;//y轴方向的加速度，落叶下飘只需要y轴正向加速度。
        
        leafCell.spin = 1.0;//粒子旋转速度
        leafCell.spinRange = 2.0;//粒子旋转速度范围
        
        leafCell.emissionRange = M_PI;//粒子发射角度范围
        
        leafCell.contents = (id)[[UIImage imageNamed:imageName] CGImage];//粒子图片
        
        leafCell.scale = 0.3;//缩放比例
        leafCell.scaleRange = 0.2;//缩放比例
        
        
        [array addObject:leafCell];
    }
    leafEmitter.emitterCells = array;
    [self.view.layer addSublayer:leafEmitter];
}

#pragma mark------红包雨
-(CAEmitterLayer *)leafEmitter{
    if (!_leafEmitter) {
        CAEmitterLayer *leafEmitter = [CAEmitterLayer layer];
        
        [self.view.layer addSublayer:leafEmitter];
        leafEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width/2, -20);//发射器中心点
        leafEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width, -20);//发射器大小，因为emitterShape设置成线性所以高度可以设置成0，
        
        leafEmitter.emitterShape = kCAEmitterLayerLine;         // 发射器形状为线性
        leafEmitter.emitterMode = kCAEmitterLayerOutline;       // 从发射器边缘发出
        
        NSMutableArray *array = [NSMutableArray array];         // CAEmitterCell数组，存放不同的CAEmitterCell，我这里准备了四张不同形态的叶子图片。
        for (int i = 0; i<4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"rain%d",i];
            
            CAEmitterCell *leafCell = [CAEmitterCell emitterCell];
            leafCell.birthRate = 3; // 粒子产生速度 test:值越大，产生对象速度越快，差不多可以布满屏幕
            leafCell.lifetime = 10; // 粒子存活时间 test:如果lifetimeRange是3秒，而cell的生存期是10秒，那么cell的实际生存期将在7到13秒之间。值太小会很快消失。
            
            leafCell.velocity = 100;                                          // 初始速度          test:值越大，速度越快
            leafCell.yAcceleration = 100;                                     // y轴方向的加速度，落叶下飘只需要y轴正向加速度。
            
            leafCell.spin = 0.0;                                              // 粒子旋转速度       test:值越大，图片旋转速度越快
            leafCell.spinRange = 0.1;                                         // 粒子旋转速度范围    test:两个对象旋转速度的差距，值越大，两个对象d的快慢对比越明显
            leafCell.contents = (id)[[UIImage imageNamed:imageName] CGImage]; // 粒子图片
            leafCell.scale = 0.3;                                             // 缩放比例          test:值越大，图片放大比例越大
            leafCell.scaleRange = 10;                                         // 缩放比例          test:值越大，各种图片的大小比例差距越大
            
            
            [array addObject:leafCell];
            _leafEmitter = leafEmitter;
        }
        leafEmitter.emitterCells = array;
    }
    return _leafEmitter;
}

- (void)fire {
    CAEmitterLayer *fireEmitter = [CAEmitterLayer layer];
    [self.view.layer addSublayer:fireEmitter];
    
    fireEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height-60);
    fireEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width, 0);
    
    fireEmitter.emitterShape = kCAEmitterLayerLine;
    fireEmitter.emitterMode = kCAEmitterLayerOutline;
    fireEmitter.renderMode = kCAEmitterLayerAdditive;//混合渲染效果
    
    NSString *imageName = @"火焰";
    
    CAEmitterCell *fireCell = [CAEmitterCell emitterCell];
    fireCell.birthRate = 15;
    fireCell.lifetime = 6;
    
    fireCell.velocity = 10;
    fireCell.velocityRange = 10;
    
    fireCell.emissionRange = 0;
    
    fireCell.contents = (id)[[UIImage imageNamed:imageName] CGImage];
    
    fireCell.scale = 0.5;
    fireCell.scaleRange = 0.2;
    
    fireCell.alphaSpeed = -0.2;//透明度改变速度
    
    fireEmitter.emitterCells = @[fireCell];
    
    [self.view.layer addSublayer:fireEmitter];
}

@end

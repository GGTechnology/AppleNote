//
//  ViewController.m
//  手势
//
//  Created by kadis on 2020/3/26.
//  Copyright © 2020 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *views;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _label.text = @"两个手指触发";
//    [self TapGestureRecognizer];
//    [self SwipeGestureRecognizer];
//    [self LongPressGestureRecognizer];
//    [self PanGestureRecognizer];
//    [self ScreenEdgePanGestureRecognizer];
//    [self PinchGestureRecognizer];
//    [self RotationGestureRecognizer];
    [self leftAndRightGesture];
}

#pragma -- mark 左滑右滑上滑下滑手势
- (void)leftAndRightGesture {
    UISwipeGestureRecognizer *swipeLeftGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeLeftGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    UISwipeGestureRecognizer *swipeRightGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeRightGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
    
    UISwipeGestureRecognizer *swipeUpGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeUpGesture.direction=UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpGesture];
    
    UISwipeGestureRecognizer *swipeDownGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeDownGesture.direction=UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDownGesture];
}
- (void)handleSwipeGesture:(UISwipeGestureRecognizer *)swipeGes {
    if (swipeGes.direction == UISwipeGestureRecognizerDirectionLeft) {
        _label.text = @"从右到左：左滑";
    } else if (swipeGes.direction == UISwipeGestureRecognizerDirectionRight) {
        _label.text = @"从左到右：右滑";
    } else if (swipeGes.direction == UISwipeGestureRecognizerDirectionUp) {
        _label.text = @"从下到上：上滑";
    } else if (swipeGes.direction == UISwipeGestureRecognizerDirectionDown) {
        _label.text = @"从上到下：下滑";
    }
}

- (void)TapGestureRecognizer {
    //创建手势 使用initWithTarget:action:的方法创建
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    
    //设置属性
    //tap 手势一共两个属性，一个是设置轻拍次数，一个是设置点击手指个数
    //设置轻拍次数
    tap.numberOfTapsRequired = 2;
    //设置手指字数
    tap.numberOfTouchesRequired = 2;
    
    //别忘了添加到testView上
    [_views addGestureRecognizer:tap];
}

#pragma mark --- UITapGestureRecognizer 轻拍手势事件 ---

-(void)tapView:(UITapGestureRecognizer *)sender{
    //设置轻拍事件改变testView的颜色
    _label.text = @"轻拍手势 + 设置了两个手指触发";
}


- (void)SwipeGestureRecognizer {
    //创建手势
      UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeView:)];
    //设置属性，swipe也是有两种属性设置手指个数及轻扫方向
    swipe.numberOfTouchesRequired = 2;
        //设置轻扫方向(默认是从左往右)
        //direction是一个枚举值有四个选项，我们可以设置从左往右，从右往左，从下往上以及从上往下
      //设置轻扫方向(默认是从左往右)
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [_views addGestureRecognizer:swipe];
}
#pragma mark swipe轻扫手势事件
-(void)swipeView:(UISwipeGestureRecognizer *)sender{
    _label.text = @"轻扫 + 设置了两个手指触发";
}

- (void)LongPressGestureRecognizer {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
       //属性设置
       //最小长按时间
       longPress.minimumPressDuration = 2;
    [_views addGestureRecognizer:longPress];
}
#pragma mark langPress 长按手势事件
-(void)longPress:(UILongPressGestureRecognizer *)sender{
    //进行判断,在什么时候触发事件
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按状态");
//改变testView颜色
        _label.text = @"长按";
    }
}

- (void)PanGestureRecognizer {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
       
    [_views addGestureRecognizer:pan];
}

#pragma mark pan   平移手势事件
-(void)panView:(UIPanGestureRecognizer *)sender{
    CGPoint point = [sender translationInView:_views];
//    sender.view.transform = CGAffineTransformMake(1, 0, 0, 1, point.x, point.y);
    
//平移一共两种移动方式
 //第一种移动方法:每次移动都是从原来的位置移动
//    sender.view.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    
    //第二种移动方式:以上次的位置为标准(移动方式 第二次移动加上第一次移动量)
    sender.view.transform = CGAffineTransformTranslate(sender.view.transform, point.x, point.y);
    //增量置为o
    [sender setTranslation:CGPointZero inView:sender.view];
    
    _label.text = @"平移";
}

- (void)ScreenEdgePanGestureRecognizer {
      UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenEdgePanView:)];

      //注意:,使用屏幕边界平移手势,需要注意两点
      //1. 视图位置(屏幕边缘)
      //2. 设置edges属性
       // 设置屏幕边缘手势支持方法
      screenEdgePan.edges = UIRectEdgeLeft;
      //属性设置
    [_views addGestureRecognizer:screenEdgePan];
}
#pragma mark screenEdgePan 屏幕边界平移事件
-(void)screenEdgePanView:(UIScreenEdgePanGestureRecognizer *)sender{
    
    //计算偏移量
    CGPoint point = [sender translationInView:_views];
    //进行平移
    sender.view.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    _label.text = @"屏幕边界平移";
}

-(void)PinchGestureRecognizer {
     UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [_views addGestureRecognizer:pinch];
}
#pragma mark pinch 捏合手势事件
-(void)pinchView:(UIPinchGestureRecognizer *)sender{
    //scale 缩放比例
//    sender.view.transform = CGAffineTransformMake(sender.scale, 0, 0, sender.scale, 0, 0);
    //每次缩放以原来位置为标准
//    sender.view.transform = CGAffineTransformMakeScale(sender.scale, sender.scale);
   
    //每次缩放以上一次为标准
    sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
    //重新设置缩放比例 1是正常缩放.小于1时是缩小(无论何种操作都是缩小),大于1时是放大(无论何种操作都是放大)
    sender.scale = 1;
   _label.text = @"捏合";
}

- (void)RotationGestureRecognizer {
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationView:)];
       
    [_views addGestureRecognizer:rotation];
}
-(void)rotationView:(UIRotationGestureRecognizer *)sender{
//    sender.view.transform = CGAffineTransformMake(cos(M_PI_4), sin(M_PI_4), -sin(M_PI_4), cos(M_PI_4), 0, 0);
    //捏合手势两种改变方式
    //以原来的位置为标准
//    sender.view.transform = CGAffineTransformMakeRotation(sender.rotation);//rotation 是旋转角度
    
    //两个参数,以上位置为标准
    sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
    //消除增量
    sender.rotation = 0.0;
    _label.text = @"旋转";
}

@end

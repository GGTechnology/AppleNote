//
//  MMPhotoViewController.m
//  MMPhoto
//
//  Created by 李沫 on 2019/3/1.
//  Copyright © 2019 MOMO. All rights reserved.
//

#import "MMPhotoViewController.h"
#import "ZoomingView.h"
#import "AppDelegate.h"
#import "DACircularProgressView.h"
#import "AutoDismissAlert.h"
#import "UIView+Extension.h"

//全屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//全屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)


@interface MMPhotoViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,retain) UILabel *pageLabel;
@property (nonatomic,assign) BOOL tap;
@property (nonatomic,strong) NSMutableArray * tempArr;
@property (nonatomic,strong) UIImageView * tapImageView;
@property (nonatomic,assign) CGFloat tapImageW;//记录缩放后的宽度
@property (nonatomic,assign) CGRect tempRect;
/**
 添加拖动手势
 */
@property (nonatomic, strong) UIPanGestureRecognizer *panGes;

@end

@implementation MMPhotoViewController
{
    BOOL isHidden;
    UIView * topBGView;
    int page;
    
    CGPoint firstTouchPoint;//手指第一次按的位置 用来判断方向
    CGPoint moveImgFirstPoint; //记录移动图片 的第一次接触的位置
    NSTimer * _timer; //计时器 根据时长来判断是否删除图片
    CGFloat timeCount; //记录手指在图片上按压的时间 来判断是否继续展示 还是缩小
    UIView *poiView;//这个view只是用来算相对坐标，用来缩放
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _imageArray = [[NSMutableArray alloc] init];
        
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (void)hiddenTap:(UITapGestureRecognizer *)tap
{
    _tapImageView = (UIImageView *)tap.view;
    //    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.view removeFromSuperview];
    //    [self removeFromParentViewController];
    [self tapHidden];
}

- (void)backBtn:(UIButton *)sender

{
    //    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.view removeFromSuperview];
    //    [self removeFromParentViewController];
    //        [self tapHidden];
}
-(void)tapHidden
{
    UIScrollView *sc = (UIScrollView *)self.tapImageView.superview ;//找出父view(scrollView)
    
    
    [UIView animateWithDuration:0.4 animations:^{
        [sc setZoomScale:1];//缩放为原大小
        [sc setContentOffset:CGPointZero];//回到原位置
        if (self.rect.origin.x>0) {
            
            self.tapImageView.frame = self.rect;
        }else{
            self.tapImageView.bounds = CGRectZero;
        }
        self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}
-(void)hiddenAction
{
    UIScrollView *sc = (UIScrollView *)self.tapImageView.superview ;//找出父view(scrollView)
    [UIView animateWithDuration:0.4 animations:^{
        if (self.rect.origin.x>0) {
            [sc setZoomScale:1];//缩放为原大小
            [sc setContentOffset:CGPointZero];//回到原位置
            
            self.tapImageView.frame = self.rect;
        }else{
            self.tapImageView.bounds = CGRectZero;
        }
        self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
    
}
-(void)showImageWithIV:(ZoomingView *)zoomingView{
    DACircularProgressView *progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(140.0f, 20.0f, 40.0f, 40.0f)];
    progressView.center = zoomingView.iv.center;
    progressView.hidden = YES;
    progressView.progress = 0.01;
    progressView.trackTintColor = [UIColor grayColor];
    progressView.progressTintColor = [UIColor whiteColor];
    [zoomingView addSubview:progressView];
    [self.imageArray replaceObjectAtIndex:zoomingView.tag-100 withObject:[NSObject new]];
    
//    [zoomingView.iv sd_setImageWithURL:[NSURL URLWithString:self.tempArr[zoomingView.tag-100]] placeholderImage:[UIImage imageNamed:@"essence_singleImage_default"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        progressView.hidden = NO;
//        progressView.progress = (double)receivedSize / (double)expectedSize;
//
//        if (receivedSize == expectedSize) {
//            progressView.hidden = YES;
//        }
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        progressView.hidden = YES;
//        if (image) {
//
//            /// 修改了这一句代码就可以使用
//            [zoomingView.iv setImage:self.imageObj];
//
//#pragma mark - 设置图片的frame
//            [UIView animateWithDuration:0.4 animations:^{
//                self.tempRect = [self getImageFrameWithImage:image];
//                zoomingView.iv.frame = self.tempRect;
//                //                zoomingView.iv.bounds = rect;
//
//                //                zoomingView.iv.center = CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.5);
//            }];
//        }else{
//            [AutoDismissAlert autoDismissAlert2With:@"图片加载失败"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self tapHidden];
//            });
//
//        }
//
//
//    }];
    
    /// 修改了这一句代码就可以使用
                  [zoomingView.iv setImage:self.imageObj];
                  
      #pragma mark - 设置图片的frame
                  [UIView animateWithDuration:0.4 animations:^{
                      self.tempRect = [self getImageFrameWithImage:self.imageObj];
                      zoomingView.iv.frame = self.tempRect;
                      //                zoomingView.iv.bounds = rect;
                      
                      //                zoomingView.iv.center = CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.5);
                  }];
}
-(void)setRect:(CGRect)rect
{
    _rect = rect;
}
- (void)viewDidLoad
{
    self.tap = YES;
    isHidden = NO;
    [super viewDidLoad];
    //    self.view.backgroundColor = [GetColor16 hexStringToColor:@"#000000"];
    self.view.backgroundColor = [UIColor blackColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.imageArray = [NSMutableArray arrayWithArray:self.urlArray];
    
    self.tempArr = [NSMutableArray arrayWithArray:self.urlArray];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(-10, 0, SCREEN_WIDTH+20, SCREEN_HEIGHT)];
    self.scrollView.contentSize = CGSizeMake((SCREEN_WIDTH + 20)*(self.tempArr.count), SCREEN_HEIGHT);
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake((self.imgIndex-1)* (SCREEN_WIDTH + 20), 0);
    [self.view addSubview:self.scrollView];
    
    
    
    //    self.arr = [NSMutableArray array];
    //添加图片
    for (int i = 0; i < self.tempArr.count; i ++) {
        ZoomingView * zoomingView = [[ZoomingView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH + 20 )*i+10, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        zoomingView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        zoomingView.minimumZoomScale = 1;
        zoomingView.maximumZoomScale = 4;
        zoomingView.delegate = self;
        [self.scrollView addSubview:zoomingView];
        //        zoomingView.backgroundColor = [UIColor whiteColor];
        zoomingView.tag = 100+i;
        
        UIImageView * imageV = [[UIImageView alloc] init];
        if(self.rect.size.width>0 ){
            imageV.frame = self.rect;
        }else{
            imageV.frame = CGRectMake(SCREEN_WIDTH*0.5-50, SCREEN_HEIGHT*0.5-50, 100, 100);
        }
        imageV.userInteractionEnabled = YES;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.backgroundColor = [UIColor clearColor];
        imageV.clipsToBounds = YES;
        [zoomingView addSubview:imageV];
        zoomingView.iv = imageV;
        
        
        if (i==(self.imgIndex-1)) {
            [self showImageWithIV:zoomingView];
        }else{
//            UIImage *img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.tempArr[i]];
            UIImage *img = self.imageObj;
            if (img) {
                [imageV setImage:img];
                [self.imageArray replaceObjectAtIndex:i withObject:[NSObject new]];
                imageV.frame = [self getImageFrameWithImage:img];
            }else {
                UIImage *img = [UIImage imageNamed:@"btn_photo_normal"];
                [imageV setImage:img];
                imageV.frame = [self getImageFrameWithImage:img];
                
            };
        }
        //        [self.arr addObject:zoomingView];
        
        
        //单击取消
        UITapGestureRecognizer * hiddenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTap:)];
        [imageV addGestureRecognizer:hiddenTap];
        
        //双击放大缩小的手势
        UITapGestureRecognizer *doubelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomingTap:)];
        doubelTap.numberOfTapsRequired = 2;
        [zoomingView addGestureRecognizer:doubelTap];
        [hiddenTap requireGestureRecognizerToFail:doubelTap];
        
        
        //拖动手势
        self.panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewPressAction:)];
        self.panGes.delegate = self;
        [imageV addGestureRecognizer:self.panGes];
    }
    
    //顶部view
//    topBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40)];
//    topBGView.backgroundColor = [UIColor clearColor];
//    //topBGView.hidden = YES;
//    topBGView.alpha = 1;
//    [self.view addSubview:topBGView];
    
    
    
    //显示页数
    if (!self.isPageNumHide) {
        self.pageLabel = [[UILabel alloc] init];
        self.pageLabel.frame = CGRectMake((SCREEN_WIDTH - 60)/2, 12, 60, 16);
        page = _scrollView.contentOffset.x/SCREEN_WIDTH+1;
        self.pageLabel.text = [NSString stringWithFormat:@"%zd/%lu",self.imgIndex,(unsigned long)self.tempArr.count];
        self.pageLabel.textColor = [UIColor whiteColor];
        self.pageLabel.textAlignment = NSTextAlignmentCenter;
        self.pageLabel.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:self.pageLabel];
    }
    
}
#pragma mark - 获取图片尺寸
-(CGRect)getImageFrameWithImage:(UIImage *)image{
    CGFloat imageViewY = 0;
    
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    if (imageWidth <0.1 || imageHeight <0.1) {
        return CGRectZero;
    }
    CGFloat fitWidth = SCREEN_WIDTH;
    CGFloat fitHeight = fitWidth * imageHeight / imageWidth;
    
    if (fitHeight < [UIScreen mainScreen].bounds.size.height) {
        imageViewY = ([UIScreen mainScreen].bounds.size.height - fitHeight) * 0.5;
    }
    return  CGRectMake(0, imageViewY, fitWidth, fitHeight);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //记录刚接触时的坐标 记录这个坐标 与移动的坐标 两个点来判断滑动方向
    firstTouchPoint = [touch locationInView:self.view];
    return YES;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //判断是否是左右滑动  滑动区间设置为+-10
    CGPoint touchPoint = [gestureRecognizer locationInView:self.view];
    CGFloat dirTop = firstTouchPoint.y - touchPoint.y;
    if (dirTop > -10 && dirTop < 10) {
        return NO;
    }
//    if (dirTop > 0) {
//        return NO;//禁止上滑
//    }
    //判断是否是上下滑动
    CGFloat dirLift = firstTouchPoint.x - touchPoint.x;
    if (dirLift > -10 && dirLift < 10 && gestureRecognizer.view.height > SCREEN_HEIGHT) {
        return NO;
    }
    
    return YES;
}
/**
 图片各种手势的处理
 
 @param ges 手势
 */
- (void)imageViewPressAction:(UIPanGestureRecognizer *)ges
{
    //获取手势坐标
    CGPoint movePoint = [ges locationInView:self.view];
    
    //判断手势状态
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:{
            _tapImageView = (UIImageView *)ges.view;
            
            //创建_timer 记录手指停留时间 判断是否隐藏图片
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(redurecd) userInfo:nil repeats:YES];
            
            
            //第一次接触的点 根据该点坐标计算缩放比例
            moveImgFirstPoint = [ges locationInView:self.view];
            
            
            //这个view只是用来算相对坐标，用来缩放
            poiView = nil;
            poiView = [[UIView alloc]initWithFrame:ges.view.frame];
            poiView.userInteractionEnabled = NO;
            poiView.backgroundColor = [UIColor clearColor];
            [ges.view.superview addSubview:poiView];
            
            
            poiView.frame = ges.view.frame;
            //改变缩放的中心点 就是以第一次接触的点为中心点来缩放
            CGPoint point = [ges locationInView:poiView];
            [self setAnchorPoint:CGPointMake(point.x/ges.view.width, point.y/ges.view.height) forView:ges.view];
            
            if (_tapImageW <SCREEN_WIDTH) {//当放大时滑动就不用重新赋值了,不然赋值后_tapImageW/SCREEN_WIDTH = 1，滑动缩放会卡一下
                _tapImageW = SCREEN_WIDTH;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
                
            
            _tapImageView = (UIImageView *)ges.view;
            
            //计算开始的点到屏幕底部的总距离
            CGFloat scrollDistance = (SCREEN_HEIGHT-moveImgFirstPoint.y);
            //实际滑动的距离
            CGFloat mov = ABS(movePoint.y-moveImgFirstPoint.y);
            //开始滑动时的放大倍数 >= 1 当放大时_tapImageW/SCREEN_WIDTH>1
            float space = _tapImageW/SCREEN_WIDTH;
            //最小缩放比例
            float minPro = 0.3;
            CGFloat offset_y = ((space-minPro)*(1-mov/scrollDistance)+minPro);
            
            //仿射变换
            CGAffineTransform transform1 = CGAffineTransformMakeTranslation((movePoint.x - moveImgFirstPoint.x), (movePoint.y - moveImgFirstPoint.y));
            if (movePoint.y>moveImgFirstPoint.y) {
            self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:offset_y];
            ges.view.transform = CGAffineTransformScale(transform1, offset_y, offset_y);
            
            }else{
                
                ges.view.transform = CGAffineTransformScale(transform1, ges.view.width/SCREEN_WIDTH, ges.view.width/SCREEN_WIDTH);
            }
            
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
            //在进行完围绕AnchorPoint的变换之后，一定要切记将AnchorPoint改回默认。否则有些不需要特殊AnchorPoint的操作，比如拖动，就会变得乱七八糟了。
            [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:ges.view];
            
            /*
             触摸结束
             如果手指停留时间大于15 秒 那么就恢复大图状态
             否则 就 缩小隐藏图片
             */
            if (timeCount > 1) {
                
                
                [UIView animateWithDuration:0.4 animations:^{
                    UIScrollView *sc = (UIScrollView *)self.tapImageView.superview ;//找出父view(scrollView)
                    [sc setZoomScale:1];//缩放为原大小
                    [sc setContentOffset:CGPointZero];//回到原位置
                    
                    
                    CGAffineTransform transform1 = CGAffineTransformMakeTranslation(0,0);
                    ges.view.transform = CGAffineTransformScale(transform1, 1, 1);
                    //                   self.view.alpha = 1;
                    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:1.0];
                    
                }];
            }else
            {
                
                [self hiddenAction];
            }
            
            //清除_timer
            timeCount = 0;
            [_timer invalidate];
            _timer = nil;
        }
            break;
            
        default:
            break;
    }
    
}
/**
 记录手指停留时间
 */
- (void)redurecd
{
    timeCount += 0.1;
}


//代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.scrollView]) {
        for (UIScrollView *s in scrollView.subviews){
            if ([s isKindOfClass:[UIScrollView class]]){
                if (page != (self.scrollView.contentOffset.x/(SCREEN_WIDTH+20) + 1)) {
                    [s setZoomScale:1.0];
                }
            }
        }
        page = self.scrollView.contentOffset.x/(SCREEN_WIDTH+20)+1;
        if (page<=0) {
            page = 1;
        }
        self.pageLabel.text = [NSString stringWithFormat:@"%d/%lu",page,(unsigned long)self.tempArr.count];
        if ([self.imageArray[page-1] isKindOfClass:[NSString class]]) {
            [self showImageWithIV:[self.scrollView viewWithTag:page+99]];
        }
    }
}

//自定义方法
- (void)zoomingTap:(UITapGestureRecognizer *)doubleTap
{
    UIScrollView *s = (UIScrollView *)doubleTap.view;
    if ([s isKindOfClass:[ZoomingView class]]) {
        ZoomingView *zoom = (ZoomingView *)s;
        self.tapImageView = zoom.iv;
        float newScale;
        if (s.zoomScale==1) {
            
            newScale = s.zoomScale *4.0;
            self.tap = NO;
        }else{
            
            newScale = s.zoomScale *0.0;
            self.tap = YES;
        }
        
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[doubleTap locationInView:doubleTap.view]];
        
        [s zoomToRect:zoomRect animated:YES];
        
        
        
    }
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = SCREEN_HEIGHT/ scale;
    zoomRect.size.width  =SCREEN_WIDTH  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  /2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height /2.0);
    return zoomRect;
}
/**
 缩放图片的时候将图片放在中间
 
 @param scrollView 背景scrollView
 */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.tapImageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                           scrollView.contentSize.height * 0.5 + offsetY);
    
    
    _tapImageW = self.tapImageView.width;
}

// 开始放大或者缩小
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:
(UIView *)view
{
    
    if ([scrollView isKindOfClass:[ZoomingView class]]) {
        ZoomingView *zoom = (ZoomingView *)scrollView;
        self.tapImageView = zoom.iv;
        
    }
}
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    //返回需要缩放的view
    if ([scrollView isKindOfClass:[ZoomingView class]]) {
        ZoomingView *zoom = (ZoomingView *)scrollView;
        self.tapImageView = zoom.iv;
        
    }
    return self.tapImageView;
}
#pragma mark - 缩放的中心点
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

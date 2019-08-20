//
//  ViewController.m
//  视频拍摄
//
//  Created by mingcol on 2019/7/17.
//  Copyright © 2019 mingcol. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);

@interface ViewController ()<AVCaptureFileOutputRecordingDelegate,NSURLConnectionDelegate>//视频文件输出代理
@property (strong,nonatomic) AVCaptureSession *captureSession;//负责输入和输出设备之间的数据传递
@property (strong,nonatomic) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据
@property (strong,nonatomic) AVCaptureMovieFileOutput *captureMovieFileOutput;//视频输出流
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层
@property (assign,nonatomic) BOOL enableRotation;//是否允许旋转（注意在视频录制过程中禁止屏幕旋转）
@property (assign,nonatomic) CGRect *lastBounds;//旋转的前大小
@property (assign,nonatomic) UIBackgroundTaskIdentifier backgroundTaskIdentifier;//后台任务标识
//@property (strong, nonatomic)UIView *viewContainer;
//@property (strong, nonatomic)UIButton *takeButton;//拍照按钮
//@property (strong, nonatomic)UIImageView *focusCursor; //聚焦光标

//创建定时器(因为下面两个方法都使用,所以定时器拿出来设置为一个属性)
@property(nonatomic,strong)NSTimer *countDownTimer;

@property(nonatomic,strong)NSString *imagePath;
@property(nonatomic,strong)NSData *imageData;

@end

@implementation ViewController
{
    UIView *viewContainer;
    UIButton *takeButton;//拍照按钮
    UIImageView *focusCursor; //聚焦光标
    UIButton *playButton;
    UILabel *timeLable;
    //倒计时总的秒数
    NSInteger secondsCountDown;
    
    UIView *backView;
    UIImageView *imageViews;
    UIButton *leftButton;
    UIScrollView *scrollViews;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.captureSession startRunning];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.captureSession stopRunning];
    
    //销毁计时器
    [_countDownTimer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    secondsCountDown = 0;
    [self showView];
    [self addBackView];
}

-(void)showView{
    
    scrollViews = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    scrollViews.backgroundColor =[UIColor whiteColor];
    scrollViews.contentSize = CGSizeMake(self.view.frame.size.width *2, self.view.frame.size.height);
    scrollViews.scrollEnabled = NO;//禁止滑动
    [self.view addSubview:scrollViews];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view1.backgroundColor = [UIColor whiteColor];;
    [scrollViews addSubview:view1];
    
    viewContainer = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height -120)];
    viewContainer.backgroundColor = [UIColor lightGrayColor];
    [view1 addSubview:viewContainer];
    
    // 切换镜头按钮
    leftButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4 -50,self.view.frame.size.height -60,100,50)];
    leftButton.backgroundColor = [UIColor brownColor];
    [leftButton setTitle:@"前摄像头" forState: UIControlStateNormal];
    [leftButton setTitle:@"后摄像头" forState: UIControlStateSelected];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(toggleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:leftButton];
    
    // 播放按钮
    playButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 -50,self.view.frame.size.height -60,100,50)];
    playButton.backgroundColor = [UIColor orangeColor];
    [playButton setTitle:@"开始录制" forState: UIControlStateNormal];
    [playButton setTitle:@"结束录制" forState: UIControlStateSelected];
    [playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [playButton addTarget:self action:@selector(takeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:playButton];
    
    
    //时间
    timeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 +25,self.view.frame.size.height -60,self.view.frame.size.width/2 -25, 50)];
    timeLable.text = @"00:00:00";
    timeLable.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:timeLable];
    
    //设置定时器
    _countDownTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    
    //初始化会话
    _captureSession=[[AVCaptureSession alloc]init];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {//设置分辨率
        _captureSession.sessionPreset=AVCaptureSessionPreset1280x720;
    }
    //获得输入设备
    AVCaptureDevice *captureDevice = [self getCameraDeviceWithPosition:AVCaptureDevicePositionFront];//取得前置摄像头
    if (!captureDevice) {
        NSLog(@"取得前置摄像头时出现问题.");
        return;
    }
    //添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice =
    [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    
    NSError *error = nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    _captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    AVCaptureDeviceInput *audioCaptureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:audioCaptureDevice error:&error];
    if (error) {
        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    //初始化设备输出对象，用于获得输出数据
    _captureMovieFileOutput=[[AVCaptureMovieFileOutput alloc]init];
    
    //将设备输入添加到会话中
    if ([_captureSession canAddInput:_captureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
        [_captureSession addInput:audioCaptureDeviceInput];
        AVCaptureConnection *captureConnection=[_captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([captureConnection isVideoStabilizationSupported ]) {
            captureConnection.preferredVideoStabilizationMode=AVCaptureVideoStabilizationModeAuto;
        }
    }
    
    //将设备输出添加到会话中
    if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
        [_captureSession addOutput:_captureMovieFileOutput];
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    _captureVideoPreviewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    
    CALayer *layer = viewContainer.layer;
    layer.masksToBounds=YES;
    
    _captureVideoPreviewLayer.frame=layer.bounds;
    _captureVideoPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//填充模式
    //将视频预览层添加到界面中
    //[layer addSublayer:_captureVideoPreviewLayer];
    [layer insertSublayer:_captureVideoPreviewLayer below:focusCursor.layer];
    
    _enableRotation=YES;
    [self addNotificationToCaptureDevice:captureDevice];
    [self addGenstureRecognizer];
}

//成品
-(void)addBackView{
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0,self.view.frame.size.width,self.view.frame.size.height)];
    backView.backgroundColor = [UIColor whiteColor];
    [scrollViews addSubview:backView];
    
    imageViews = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [backView addSubview:imageViews];
    
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4 -30,self.view.frame.size.height -100, 60, 30)];
    clearButton.backgroundColor = [UIColor whiteColor];
    [clearButton setTitle:@"返回" forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clickClearButton) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:clearButton];
    
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4*3 -30,self.view.frame.size.height -100, 60, 30)];
    nextButton.backgroundColor = [UIColor whiteColor];
    [nextButton setTitle:@"确定" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClearButton) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:nextButton];
}

-(void)clickClearButton{
    NSLog(@"返回...");
    [self.captureSession stopRunning];
    [self.captureSession startRunning];
    
    [UIView animateWithDuration:0.3 animations:^{
        self->scrollViews.contentOffset = CGPointMake(0, 0);
    }];
    
}   // 取消
-(void)nextClearButton{
    NSLog(@"下一步");
    // 上传视频
    [self workLoadVideo:self.imageData andPath:self.imagePath];
}    // 确定

-(BOOL)shouldAutorotate{
    return self.enableRotation;
}

//屏幕旋转时调整视频预览图层的方向
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    AVCaptureConnection *captureConnection=[self.captureVideoPreviewLayer connection];
    captureConnection.videoOrientation=(AVCaptureVideoOrientation)toInterfaceOrientation;
}

//旋转后重新设置大小
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    _captureVideoPreviewLayer.frame=viewContainer.bounds;
}

-(void)dealloc{
    [self removeNotification];
}

#pragma mark 视频录制 （按钮 * 事件 * 开始 * 结束）
- (void)takeButtonClick:(UIButton *)sender {
    
    playButton.selected = !playButton.selected;
    
    if (playButton.selected == YES) {
        [self.captureSession startRunning];
        [_countDownTimer setFireDate:[NSDate date]];
    }
    
    //根据设备输出获得连接
    AVCaptureConnection *captureConnection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    //根据连接取得设备输出的数据
    if (![self.captureMovieFileOutput isRecording]) {
        self.enableRotation = NO;
        //如果支持多任务则则开始多任务
        if ([[UIDevice currentDevice] isMultitaskingSupported]) {
            self.backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
        }
        //预览图层和视频方向保持一致
        captureConnection.videoOrientation = [self.captureVideoPreviewLayer connection].videoOrientation;
        NSString *outputFielPath=[NSTemporaryDirectory() stringByAppendingString:@"myMovie.mp4"];
        
        NSLog(@"save path is :%@",outputFielPath);
        NSURL *fileUrl=[NSURL fileURLWithPath:outputFielPath];
        [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
        
        playButton.selected = YES;
    }else{
        [self.captureMovieFileOutput stopRecording];//停止录制
        playButton.selected = NO;
        timeLable.text = @"00:00:00";
    }
}

#pragma mark 切换前后摄像头
- (void)toggleButtonClick:(UIButton *)sender {
    
    leftButton.selected = !leftButton.selected;
    
    AVCaptureDevice *currentDevice=[self.captureDeviceInput device];
    AVCaptureDevicePosition currentPosition=[currentDevice position];
    [self removeNotificationFromCaptureDevice:currentDevice];
    AVCaptureDevice *toChangeDevice;
    AVCaptureDevicePosition toChangePosition=AVCaptureDevicePositionFront;
    if (currentPosition==AVCaptureDevicePositionUnspecified||currentPosition==AVCaptureDevicePositionFront) {
        toChangePosition=AVCaptureDevicePositionBack;
    }
    toChangeDevice=[self getCameraDeviceWithPosition:toChangePosition];
    [self addNotificationToCaptureDevice:toChangeDevice];
    //获得要调整的设备输入对象
    AVCaptureDeviceInput *toChangeDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:toChangeDevice error:nil];
    
    //改变会话的配置前一定要先开启配置，配置完成后提交配置改变
    [self.captureSession beginConfiguration];
    //移除原有输入对象
    [self.captureSession removeInput:self.captureDeviceInput];
    //添加新的输入对象
    if ([self.captureSession canAddInput:toChangeDeviceInput]) {
        [self.captureSession addInput:toChangeDeviceInput];
        self.captureDeviceInput=toChangeDeviceInput;
    }
    //提交会话配置
    [self.captureSession commitConfiguration];
}
#pragma mark - 视频输出代理
/**
 *  开始录制
 */
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    NSLog(@"开始录制...");
    
    //开始
    [[NSRunLoop mainRunLoop] addTimer:_countDownTimer forMode:NSDefaultRunLoopMode];
}
/**
 *  录制结束
 */
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    NSLog(@"视频录制完成.");
    
    //计时器暂停
    [_countDownTimer setFireDate:[NSDate distantFuture]];
    secondsCountDown = 0;
    
    //视频录入完成之后在后台将视频存储到相簿
    self.enableRotation=YES;
    UIBackgroundTaskIdentifier lastBackgroundTaskIdentifier = self.backgroundTaskIdentifier;
    self.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    ALAssetsLibrary *assetsLibrary=[[ALAssetsLibrary alloc]init];
    
    
    [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error) {
            NSLog(@"保存视频到相簿过程中发生错误，错误信息：%@",error.localizedDescription);
        }
        if (lastBackgroundTaskIdentifier!=UIBackgroundTaskInvalid) {
            [[UIApplication sharedApplication] endBackgroundTask:lastBackgroundTaskIdentifier];
        }
        NSLog(@"成功保存视频到相簿.");
        
        NSLog(@"path:%@",outputFileURL);
        
        NSData *data = [NSData dataWithContentsOfURL:outputFileURL];
        
        NSLog(@"data:%lu",(unsigned long)data.length);
        
        NSInteger size = data.length;
        
        
        NSLog(@"视频大小:%.2fM",size/1024.0/1024.0);
        // 视频压缩
        [self avConcerVideo:outputFileURL];
    }];
}

#pragma mark - 通知
/**
 *  给输入设备添加通知
 */
-(void)addNotificationToCaptureDevice:(AVCaptureDevice *)captureDevice{
    //注意添加区域改变捕获通知必须首先设置设备允许捕获
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        captureDevice.subjectAreaChangeMonitoringEnabled=YES;
    }];
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    //捕获区域发生改变
    [notificationCenter addObserver:self selector:@selector(areaChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}
-(void)removeNotificationFromCaptureDevice:(AVCaptureDevice *)captureDevice{
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}
/**
 *  移除所有通知
 */
-(void)removeNotification{
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
}
-(void)addNotificationToCaptureSession:(AVCaptureSession *)captureSession{
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    //会话出错
    [notificationCenter addObserver:self selector:@selector(sessionRuntimeError:) name:AVCaptureSessionRuntimeErrorNotification object:captureSession];
}
/**
 *  设备连接成功
 *
 *  @param notification 通知对象
 */
-(void)deviceConnected:(NSNotification *)notification{
    NSLog(@"设备已连接...");
}
/**
 *  设备连接断开
 *
 *  @param notification 通知对象
 */
-(void)deviceDisconnected:(NSNotification *)notification{
    NSLog(@"设备已断开.");
}
/**
 *  捕获区域改变
 *
 *  @param notification 通知对象
 */
-(void)areaChange:(NSNotification *)notification{
    NSLog(@"捕获区域改变...");
}
/**
 *  会话出错
 *
 *  @param notification 通知对象
 */
-(void)sessionRuntimeError:(NSNotification *)notification{
    NSLog(@"会话发生错误.");
}

#pragma mark - 私有方法
/**
 *  取得指定位置的摄像头
 *
 *  @param position 摄像头位置
 *
 *  @return 摄像头设备
 */
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position]==position) {
            return camera;
        }
    }
    return nil;
}

/**
 *  改变设备属性的统一操作方法
 *
 *  @param propertyChange 属性改变操作
 */
-(void)changeDeviceProperty:(PropertyChangeBlock)propertyChange{
    AVCaptureDevice *captureDevice= [self.captureDeviceInput device];
    NSError *error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if ([captureDevice lockForConfiguration:&error]) {
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
    }else{
        NSLog(@"设置设备属性过程发生错误，错误信息：%@",error.localizedDescription);
    }
}

/**
 *  设置闪光灯模式
 *
 *  @param flashMode 闪光灯模式
 */
-(void)setFlashMode:(AVCaptureFlashMode )flashMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFlashModeSupported:flashMode]) {
            [captureDevice setFlashMode:flashMode];
        }
    }];
}
/**
 *  设置聚焦模式
 *
 *  @param focusMode 聚焦模式
 */
-(void)setFocusMode:(AVCaptureFocusMode )focusMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:focusMode];
        }
    }];
}
/**
 *  设置曝光模式
 *
 *  @param exposureMode 曝光模式
 */
-(void)setExposureMode:(AVCaptureExposureMode)exposureMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:exposureMode];
        }
    }];
}
/**
 *  设置聚焦点
 *
 *  @param point 聚焦点
 */
-(void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        if ([captureDevice isFocusPointOfInterestSupported]) {
            [captureDevice setFocusPointOfInterest:point];
        }
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        if ([captureDevice isExposurePointOfInterestSupported]) {
            [captureDevice setExposurePointOfInterest:point];
        }
    }];
}
/**
 *  添加点按手势，点按时聚焦
 */
-(void)addGenstureRecognizer{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen:)];
    [viewContainer addGestureRecognizer:tapGesture];
}
-(void)tapScreen:(UITapGestureRecognizer *)tapGesture{
    CGPoint point= [tapGesture locationInView:viewContainer];
    //将UI坐标转化为摄像头坐标
    CGPoint cameraPoint= [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
    [self setFocusCursorWithPoint:point];
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}
/**
 *  设置聚焦光标位置
 *
 *  @param point 光标位置
 */
-(void)setFocusCursorWithPoint:(CGPoint)point{
    focusCursor.center=point;
    focusCursor.transform=CGAffineTransformMakeScale(1.5, 1.5);
    focusCursor.alpha=1.0;
    [UIView animateWithDuration:1.0 animations:^{
        self->focusCursor.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self->focusCursor.alpha=0;
        
    }];
}

#pragma mark ---------------------------------------------

//实现倒计时动作
-(void)countDownAction{
    //重新计算 时/分/秒
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",secondsCountDown/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(secondsCountDown%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",secondsCountDown%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    //修改倒计时标签及显示内容
    timeLable.text=[NSString stringWithFormat:@"%@",format_time];
    
    
    //当计时到30时做需要的操作，比如验证码过期不能提交
    //    if(secondsCountDown == 30){
    //
    //        [_countDownTimer invalidate];
    //    }
    
    //计时 +1
    secondsCountDown++;
    
}

//视频压缩
- (void)avConcerVideo:(NSURL *)url {
    
    //Asset 资源 可以是图片音频视频
    AVAsset *asset = [AVAsset assetWithURL:url];
    
    //设置压缩的格式
    AVAssetExportSession *session = [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetLowQuality];//mediumquality:低等质量
    
    //设置导出路径
    NSString *path =[NSTemporaryDirectory() stringByAppendingPathComponent:@"video.mp4"];
    
    //创建文件管理类 导出失败,删除已经导出的
    NSFileManager *manager = [[NSFileManager alloc]init];
    
    //删除已经存在的
    [manager removeItemAtPath:path error:NULL];
    
    //设置出路径
    session.outputURL = [NSURL fileURLWithPath:path];
    
    //设置输出文件的类型
    session.outputFileType=AVFileTypeMPEG4;
    
    // 提示窗：提示正在压缩视频
    NSLog(@"🌞🌞🌞🌞🌞🌞正在压缩视频..🌞🌞🌞🌞🌞🌞");
//    [GZXactivityIndicatior showViewString:@"正在压缩视频.." inView:self.view];
    
    
    //开辟子线程处理耗时操作
    [session exportAsynchronouslyWithCompletionHandler:^{
        
        // 关闭提示窗
//        [GZXactivityIndicatior hideView:self.view];
        
        NSLog(@"压缩完成status:%ld 路径:%@",(long)session.status,path);
        
        NSData *data = [NSData dataWithContentsOfURL:session.outputURL];
        NSInteger size = data.length;
        
        switch (session.status) {
            case AVAssetExportSessionStatusCancelled:
                break;
            case AVAssetExportSessionStatusUnknown:
                break;
            case AVAssetExportSessionStatusWaiting:
                break;
            case AVAssetExportSessionStatusExporting:
                break;
            case AVAssetExportSessionStatusCompleted:
            {
                NSLog(@"❄️❄️❄️❄️❄️❄️压缩视频结束❄️❄️❄️❄️❄️❄️");
                NSLog(@"压缩后的视频大小:%.2fM",size/1024.0/1024.0);
                NSLog(@"URL:%@",session.outputURL);
                //关闭摄像头
                [self->_captureSession stopRunning];
                //[self workLoadVideo:data andPath:path];
                self.imageData = data;
                self.imagePath = path;
            }
                break;
            case AVAssetExportSessionStatusFailed:
                break;
        }
    }];
    
    //获取图片
    [self showImage:url];
}

// 获取图片
- (void)showImage:(NSURL *)url {
    UIImage *image1 = [self thumbnailImageForVideo:url atTime:1];
    imageViews.image = image1;
    
    NSLog(@"开始偏移...");
    [UIView animateWithDuration:0.3 animations:^{
        self->scrollViews.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    }];
}

// 获取视频的第一帧图片
- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    NSLog(@"获取视频的第一帧图片");
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    
    assetImageGenerator.requestedTimeToleranceAfter = kCMTimeZero;
    assetImageGenerator.requestedTimeToleranceBefore = kCMTimeZero;
    
    // CMTimeMake(a,b) a当前第几帧, b每秒钟多少帧.当前播放时间a/b
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime,60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    NSLog(@"获取视频的第一帧图片完成");
    return thumbnailImage;
}
// 上传视频
-(void)workLoadVideo:(NSData *)datas andPath:(NSString *)path {
    
}

@end

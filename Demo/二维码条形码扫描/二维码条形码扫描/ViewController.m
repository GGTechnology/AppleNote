//
//  ViewController.m
//  二维码条形码扫描
//
//  Created by mingcol on 2019/7/5.
//  Copyright © 2019 mingcol. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
const char *kScanCodeQueueName = "ScanCodeQueue"; //the new process queue indentifier

@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate> {
    AVCaptureSession *session; //the session of captrue
    BOOL isLightOpen;
}

@property (nonatomic, strong) UIView *cameraView; //the camera frame view
@property (nonatomic, strong) UIButton *openLightBtn; //open the light
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    //add the cameara view
    _cameraView = [[UIView alloc] initWithFrame:self.view.bounds];
    _cameraView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_cameraView];
    
    //add a button to switch light
    isLightOpen = NO;
    UIButton *lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lightButton.frame = CGRectMake(self.view.frame.size.width/2 - 50, 500, 100, 50);
    [lightButton setTitle:@"open_light" forState:UIControlStateNormal];
    [lightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lightButton setTitleColor:[UIColor greenColor] forState:UIControlEventTouchDown];
    [lightButton addTarget: self action:@selector(switchLight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lightButton];
    
    
    
    //start capture
    [self initCapture];
    [session startRunning];
}

//- (void)loadView
//{
//    [super loadView];
//    //    [self initCapture];
//    
//}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    //    [self initCapture];
//}
- (void)switchLight
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //toggle the light
    isLightOpen = !isLightOpen;
    //turn on or off the light
    if([device hasTorch])
    {
        [device lockForConfiguration:nil];
        
        if(isLightOpen)
            [device setTorchMode:AVCaptureTorchModeOn];
        else
            [device setTorchMode:AVCaptureTorchModeOff];
        
        [device unlockForConfiguration];
    }
    
}
- (void)initCapture
{
    //get the camera device
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //create the session
    session = [[AVCaptureSession alloc]init];
    
    //create input
    NSError *error;
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if(!input)
    {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    [session addInput:input];
    
    //create output
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    [session addOutput:output];
    
    //make it run at a new process
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create(kScanCodeQueueName, NULL);
    [output setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    
    //set the sampling rate
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    //set the code type ,ex:QR and bar code
    if([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode])
        [output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, nil]];
    
    //add the camera layer
    AVCaptureVideoPreviewLayer *captureLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    captureLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    captureLayer.frame=self.cameraView.layer.bounds;
    [self.cameraView.layer insertSublayer:captureLayer atIndex:0]; //or use the addsublayer
//        [self.cameraView.layer addSublayer:captureLayer];
    
}
#pragma mark - capture delegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects && metadataObjects.count>0)
    {
        //stop the capture
        [session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //do sth to handle the capture result
        [self performSelectorOnMainThread:@selector(handleResult:) withObject:metadataObject waitUntilDone:NO];
    }
}

- (void)handleResult:(AVMetadataMachineReadableCodeObject *)metadataObject
{
    
    NSLog(@"%@", metadataObject.type);
    if([metadataObject.type isEqualToString:AVMetadataObjectTypeQRCode])
        NSLog(@"QR code");
    else
        NSLog(@"other code");
    
    NSString *captureStr = metadataObject.stringValue;
    NSLog(@"%@",captureStr);
    
    //if the string is URL, then push a view and open the website, otherwise just pop a dialog to show the msg
    if([self isURL:captureStr])
    {
        NSLog(@"你要执行的操作🍎");
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"scan result"
                                                        message:captureStr
                                                       delegate:nil
                                              cancelButtonTitle:@"ok"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

//use regular expression to recognize URL
- (BOOL)isURL:(NSString *)str
{
    NSString *regex = @"[a-zA-z]+://[^s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:str];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

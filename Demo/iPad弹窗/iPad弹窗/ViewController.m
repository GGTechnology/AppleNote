//
//  ViewController.m
//  iPad弹窗
//
//  Created by mingcol on 2019/7/15.
//  Copyright © 2019 mingcol. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)guy:(id)sender {
    NSLog(@"🍎");
    [self.view endEditing:YES];
    
//    UIActionSheet *sheet;
//    //判断是否有摄像头
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
//        sheet=[[UIActionSheet alloc]initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册中获取", nil];
//    }else{
//        sheet=[[UIActionSheet alloc]initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册中获取" otherButtonTitles: nil];
//    }
//    sheet.tag = 1003;
//    [sheet showInView:self.view];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择头像" message:@"请选择打开图像的方式" preferredStyle:UIAlertControllerStyleActionSheet];
    if (alertVC.popoverPresentationController) {
        [alertVC.popoverPresentationController setPermittedArrowDirections:0];//去掉arrow箭头
        alertVC.popoverPresentationController.sourceView=self.view;
        alertVC.popoverPresentationController.sourceRect=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    }
    [alertVC addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:self.pickerController animated:YES completion:nil];
    }]];
    // 判断相机是否可用，可用就能调用相机拍照
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//            [self presentViewController:self.pickerController animated:YES completion:nil];
        }]];
    }
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end

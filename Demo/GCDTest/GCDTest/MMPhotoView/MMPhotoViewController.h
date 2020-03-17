//
//  MMPhotoViewController.h
//  MMPhoto
//
//  Created by 李沫 on 2019/3/1.
//  Copyright © 2019 MOMO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMPhotoViewController : UIViewController
@property (nonatomic,strong) NSArray *urlArray;
@property (nonatomic,assign) NSInteger imgIndex;     //图片下标
@property (nonatomic, assign) BOOL isPageNumHide;
@property (nonatomic,assign) CGRect rect;//点击进来的那个view的frame


@property (nonatomic, strong) UIImage *imageObj;

@end

NS_ASSUME_NONNULL_END

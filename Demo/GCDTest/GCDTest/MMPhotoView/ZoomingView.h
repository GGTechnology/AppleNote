//
//  ZoomingView.h
//  MMPhoto
//
//  Created by 李沫 on 2019/3/1.
//  Copyright © 2019 MOMO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZoomingView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, weak) UIImageView *iv;

@end

NS_ASSUME_NONNULL_END

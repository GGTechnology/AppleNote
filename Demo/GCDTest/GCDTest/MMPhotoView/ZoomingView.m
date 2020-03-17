//
//  ZoomingView.m
//  MMPhoto
//
//  Created by 李沫 on 2019/3/1.
//  Copyright © 2019 MOMO. All rights reserved.
//

#import "ZoomingView.h"

@implementation ZoomingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
        
    }
    return self;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView.subviews objectAtIndex:0];
}

@end

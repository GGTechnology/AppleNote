//
//  A_Button.m
//  高斯模糊
//
//  Created by kadis on 2020/7/22.
//  Copyright © 2020 lvguangda. All rights reserved.
//

#import "A_Button.h"

@implementation A_Button

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];

    CGSize imageSize = self.currentImage.size;
    if ((self.currentTitle.length > 0 || self.currentAttributedTitle.length > 0) &&
        (imageSize.width > 0 && imageSize.height > 0)) {
        size.width += _spacing;
    }

    return size;
}

- (void)sizeToFit {
    [super sizeToFit];

    CGRect bounds = self.bounds;
    bounds.size = [self intrinsicContentSize];
    self.bounds = bounds;

    CGFloat offset = 0;
    CGSize imageSize = self.currentImage.size;
    if ((self.currentTitle.length > 0 || self.currentAttributedTitle.length > 0) &&
        (imageSize.width > 0 && imageSize.height > 0)) {
        offset = _spacing * 0.5;
    }

    CGPoint center = self.center;
    center.x += offset;
    self.center = center;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect rect = [super imageRectForContentRect:contentRect];

    if (_direction == ZUIButtonDirectionRowReverse) {
        CGRect titleRect = [super titleRectForContentRect:contentRect];
        titleRect.origin.x = rect.origin.x;
        rect.origin.x = CGRectGetMaxX(titleRect);
    }

    if (self.currentTitle.length > 0 || self.currentAttributedTitle.length > 0) {
        if (_direction == ZUIButtonDirectionRow) {
            rect.origin.x -= _spacing * 0.5;
        } else if (_direction == ZUIButtonDirectionRowReverse) {
            rect.origin.x += _spacing * 0.5;
        }
    }

    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect rect = [super titleRectForContentRect:contentRect];

    if (_direction == ZUIButtonDirectionRowReverse) {
        CGRect imageRect = [super imageRectForContentRect:contentRect];
        rect.origin.x = imageRect.origin.x;
    }

    CGSize imageSize = self.currentImage.size;
    if (imageSize.width > 0 && imageSize.height > 0) {
        if (_direction == ZUIButtonDirectionRow) {
            rect.origin.x += _spacing * 0.5;
        } else if (_direction == ZUIButtonDirectionRowReverse) {
            rect.origin.x -= _spacing * 0.5;
        }
    }

    return rect;
}


@end

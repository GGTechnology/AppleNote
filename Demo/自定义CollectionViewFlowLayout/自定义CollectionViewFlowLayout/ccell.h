//
//  ccell.h
//  自定义CollectionViewFlowLayout
//
//  Created by kadis on 2019/11/29.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ccell : UICollectionViewCell
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, copy) void (^block)(NSInteger i);
@property (nonatomic, copy) NSArray *cellArray;
@property (nonatomic, copy) void (^cellBlock)(NSArray *btnArray);
@end

@interface sBtn : UIButton
@property (nonatomic, copy) NSArray *btnArray;
@end

NS_ASSUME_NONNULL_END

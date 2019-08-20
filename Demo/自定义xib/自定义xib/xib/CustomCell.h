//
//  CustomCell.h
//  自定义xib
//
//  Created by mingcol on 2019/6/21.
//  Copyright © 2019 mingcol. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labels;
@property (weak, nonatomic) IBOutlet UIImageView *images;

@end

NS_ASSUME_NONNULL_END

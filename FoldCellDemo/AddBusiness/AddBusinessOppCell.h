//
//  AddBusinessOppCell.h
//  FoldCellDemo
//
//  Created by Turbo on 2017/6/27.
//  Copyright © 2017年 Turbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define DEF_RGB_INT_COLOR(rgb) [UIColor colorWithRGB:rgb]

@interface AddBusinessOppCell : UITableViewCell

@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UILabel *titleLabel;

@end

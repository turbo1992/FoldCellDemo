//
//  AddBusinessOppCell.m
//  FoldCellDemo
//
//  Created by Turbo on 2017/6/27.
//  Copyright © 2017年 Turbo. All rights reserved.
//

#import "AddBusinessOppCell.h"

@implementation AddBusinessOppCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, .0f, SCREEN_WIDTH/2, 44.0f)];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.titleLabel.text = @"二狗子二狗子";
        self.titleLabel.alpha = 0.6;
        [self.contentView addSubview:self.titleLabel];
        
        //细线
        self.line = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 43.5f, SCREEN_WIDTH-15.0f, 0.5f)];
        self.line.backgroundColor = [UIColor blackColor];
        self.line.alpha = 0.1;
        [self.contentView addSubview:self.line];
        
    }
    return self;
}


@end

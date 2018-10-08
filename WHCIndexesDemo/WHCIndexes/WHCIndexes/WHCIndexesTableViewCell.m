//
//  WHCIndexesTableViewCell.m
//  whc2
//
//  Created by 汪弘昌 on 2018/9/30.
//  Copyright © 2018年 汪弘昌. All rights reserved.
//

#import "WHCIndexesTableViewCell.h"

@interface WHCIndexesTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation WHCIndexesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setDescStr:(NSString *)descStr
{
    _descStr = descStr;
    _descLabel.text = descStr;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

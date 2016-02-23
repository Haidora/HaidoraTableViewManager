//
//  TitlePresentable.m
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 16/2/23.
//  Copyright © 2016年 mrdaios. All rights reserved.
//

#import "TitlePresentable.h"

@implementation NSObject (TitlePresentable)

//去除警告
@dynamic title;

- (UIColor *)titleColor
{
    return [UIColor redColor];
}

- (UIFont *)titleFont
{
    return [UIFont systemFontOfSize:14];
}

- (void (^)(UILabel *label))updateTitleLabel
{
    void (^updateTitleLabel)(UILabel *label) = ^(UILabel *label) {
      label.text = self.title;
      label.textColor = self.titleColor;
      label.font = self.titleFont;
    };
    return updateTitleLabel;
}

@end

//
//  HDViewControllerCell.m
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 15/7/16.
//  Copyright (c) 2015年 mrdaios. All rights reserved.
//

#import "HDViewControllerCell.h"
#import <HaidoraTableViewManager.h>

@implementation HDViewControllerCell

+ (NSString *)hd_nibName
{
    return @"HDViewControllerCell";
}

+ (NSString *)hd_cellIdentifier
{
    return @"HDViewControllerCell";
}

@end

@implementation HDViewControllerCell1

+ (NSString *)hd_nibName
{
    return @"HDViewControllerCell";
}

+ (NSString *)hd_cellIdentifier
{
    return @"HDViewControllerCell1";
}

//这里用Protcol可以去除对model的引用,解耦以后换model方便
- (void)hd_setContent:(id<HDCellModelProtcol>)content
{
    self.textLabel.text = [content title];
}

@end
//
//  TestTableViewCell.m
//  HaidoraTableViewManager
//
//  Created by DaiLingchi on 15-1-20.
//  Copyright (c) 2015年 Haidora. All rights reserved.
//

#import "TestTableViewCell.h"
#import "UITableViewCell+HDTableViewManager.h"

@implementation TestTableViewCell

+ (CGFloat)cellHeight_HDTableViewManager
{
    return 100.0;
}

- (void)cellDidLoad_HDTableViewManager
{
    [super cellDidLoad_HDTableViewManager];
    NSLog(@"1");
}

- (void)cellWillAppear_HDTableViewManager
{
    [super cellWillAppear_HDTableViewManager];
    NSLog(@"%@", self.indexPath_HDTableViewManager);
}

@end

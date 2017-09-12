//
//  HDDemo2Item1.m
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 16/3/9.
//  Copyright © 2016年 mrdaios. All rights reserved.
//

#import "HDDemo2Cell1.h"
#import "HDDemo2Item1.h"

@implementation HDDemo2Item1

+ (instancetype)item
{
    HDDemo2Item1 *item = [super item];
    item.cellClass = [HDDemo2Cell1 class];
    return item;
}

@end

//
//  HDDemo2Item2.m
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 16/3/9.
//  Copyright © 2016年 mrdaios. All rights reserved.
//

#import "HDDemo2Cell2.h"
#import "HDDemo2Item2.h"

@implementation HDDemo2Item2

+ (instancetype)item
{
    HDDemo2Item2 *item = [super item];
    item.cellClass = [HDDemo2Cell2 class];
    return item;
}

@end

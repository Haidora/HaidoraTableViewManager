//
//  HDTableViewSection.m
//  HaidoraTableViewManager
//
//  Created by DaiLingchi on 15-2-6.
//  Copyright (c) 2015年 Haidora. All rights reserved.
//

#import "HDTableViewSection.h"
#import "HDTableViewManagerProtocol.h"

@implementation HDTableViewSection

- (NSMutableArray *)sectionRows
{
    if (_sectionRows == nil)
    {
        _sectionRows = [NSMutableArray array];
    }
    return _sectionRows;
}

@end

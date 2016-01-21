//
//  HDTableViewItem.m
//  Pods
//
//  Created by Dailingchi on 15/7/15.
//
//

#import "HDTableViewItem.h"

@implementation HDTableViewItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.cellStyle = UITableViewCellStyleUnknow;
        self.cellHeight = HDTableViewManagerCellHeightUnknow;
    }
    return self;
}

+ (instancetype)item
{
    HDTableViewItem *item = [[self alloc] init];
    return item;
}

@end

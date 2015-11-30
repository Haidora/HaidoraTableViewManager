//
//  HDTableViewItem.m
//  Pods
//
//  Created by Dailingchi on 15/7/15.
//
//

#import "HDTableViewItem.h"

@implementation HDTableViewItem

+ (instancetype)item
{
    HDTableViewItem *item = [[self alloc] init];
    item.cellStyle = UITableViewCellStyleUnknow;
    item.cellHeight = HDTableViewManagerCellHeightUnknow;
    return item;
}

@end

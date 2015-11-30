//
//  HDTableViewSection.m
//  Pods
//
//  Created by Dailingchi on 15/7/15.
//
//

#import "HDTableViewSection.h"

@interface HDTableViewSection ()

@property (nonatomic, strong, readwrite) NSMutableArray *items;

@end

@implementation HDTableViewSection

+ (instancetype)section
{
    HDTableViewSection *section = [[self alloc] init];
    section.cellStyle = UITableViewCellStyleUnknow;
    section.cellHeight = HDTableViewManagerCellHeightUnknow;
    return section;
}

#pragma mark
#pragma mark Getter

- (NSMutableArray *)items
{
    if (nil == _items)
    {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end

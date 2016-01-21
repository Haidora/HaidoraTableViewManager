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

+ (instancetype)section
{
    HDTableViewSection *section = [[self alloc] init];
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

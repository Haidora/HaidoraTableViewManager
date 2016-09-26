//
//  HDTableViewManager+HDPrivateUtils.m
//
// Copyright (c) 2016年 mrdaios
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "HDTableViewManager+HDPrivateUtils.h"
#import "UITableViewCell+HDTableViewManager.h"
#import <objc/runtime.h>

static char *kHDTableViewSection_HDPrivateUtilsExtend_nibCache =
    "kHDTableViewSection_HDPrivateUtilsExtend_nibCache";

@implementation HDTableViewManager (HDPrivateUtils)

- (void (^)(UITableView *tableView, UITableViewCell *cell,
            NSIndexPath *indexPath))loadTableViewWillDisplayCellAtIndexPath:(NSIndexPath *)indexPath
{
    void (^tableViewWillDisplayCellAtIndexPath)(UITableView *tableView, UITableViewCell *cell,
                                                NSIndexPath *indexPath) = nil;
    NSObject<HDTableViewConfigureProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewConfigureProtocol)])
    {
        tableViewWillDisplayCellAtIndexPath = tableViewItem.tableViewWillDisplayCellAtIndexPath;
    }
    if (!tableViewWillDisplayCellAtIndexPath)
    {
        NSObject<HDTableViewConfigureProtocol> *tableViewSection = self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewConfigureProtocol)])
        {
            tableViewWillDisplayCellAtIndexPath =
                tableViewSection.tableViewWillDisplayCellAtIndexPath;
        }
    }
    if (!tableViewWillDisplayCellAtIndexPath)
    {
        tableViewWillDisplayCellAtIndexPath = self.tableViewWillDisplayCellAtIndexPath;
    }
    return tableViewWillDisplayCellAtIndexPath;
}

- (void (^)(UITableView *tableView, NSIndexPath *indexPath))
loadTableViewDidSelectRowAtIndexPathWith:(NSIndexPath *)indexPath
{
    void (^tableViewDidSelectRowAtIndexPathWith)(UITableView *tableView, NSIndexPath *indexPath) =
        nil;
    NSObject<HDTableViewConfigureProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewConfigureProtocol)])
    {
        tableViewDidSelectRowAtIndexPathWith = tableViewItem.tableViewDidSelectRowAtIndexPath;
    }
    if (!tableViewDidSelectRowAtIndexPathWith)
    {
        NSObject<HDTableViewConfigureProtocol> *tableViewSection = self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewConfigureProtocol)])
        {
            tableViewDidSelectRowAtIndexPathWith =
                tableViewSection.tableViewDidSelectRowAtIndexPath;
        }
    }
    if (!tableViewDidSelectRowAtIndexPathWith)
    {
        tableViewDidSelectRowAtIndexPathWith = self.tableViewDidSelectRowAtIndexPath;
    }
    return tableViewDidSelectRowAtIndexPathWith;
}

- (Class)loadClassWith:(NSIndexPath *)indexPath
{
    Class cellClass = nil;
    NSObject<HDTableViewCellConfigureProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
    {
        cellClass = tableViewItem.cellClass;
    }
    if (!cellClass)
    {
        NSObject<HDTableViewCellConfigureProtocol> *tableViewSection =
            self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
        {
            cellClass = tableViewSection.cellClass;
        }
    }
    if (!cellClass)
    {
        cellClass = self.cellClass;
    }
    if (!cellClass)
    {
        cellClass = [UITableViewCell class];
    }
    return cellClass;
}

- (NSString *)loadCellIdentifierWith:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier;
    NSObject<HDTableViewCellConfigureProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
    {
        cellIdentifier = tableViewItem.cellIdentifier;
    }
    if (!cellIdentifier)
    {
        NSObject<HDTableViewCellConfigureProtocol> *tableViewSection =
            self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
        {
            cellIdentifier = tableViewSection.cellIdentifier;
        }
    }
    if (!cellIdentifier)
    {
        cellIdentifier = self.cellIdentifier;
    }
    if (!cellIdentifier)
    {
        cellIdentifier = [[self loadClassWith:indexPath] hd_ReusableCellIdentifier];
    }
    return cellIdentifier;
}

- (UITableViewCellStyle)loadCellStyleWith:(NSIndexPath *)indexPath
{
    UITableViewCellStyle cellStyle = UITableViewCellStyleUnknow;
    NSObject<HDTableViewCellConfigureProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
    {
        cellStyle = tableViewItem.cellStyle;
    }
    if (cellStyle == UITableViewCellStyleUnknow)
    {
        NSObject<HDTableViewCellConfigureProtocol> *tableViewSection =
            self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
        {
            cellStyle = tableViewSection.cellStyle;
        }
    }
    if (cellStyle == UITableViewCellStyleUnknow)
    {
        cellStyle = self.cellStyle;
    }
    if (cellStyle == UITableViewCellStyleUnknow)
    {
        cellStyle = UITableViewCellStyleDefault;
    }
    return cellStyle;
}

- (CGFloat)loadCellHeightWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    CGFloat height = HDTableViewManagerCellHeightUnknow;
    NSObject<HDTableViewCellConfigureProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
    {
        height = tableViewItem.cellHeight;
    }
    if (height == HDTableViewManagerCellHeightUnknow)
    {
        NSObject<HDTableViewCellConfigureProtocol> *tableViewSection =
            self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
        {
            height = tableViewSection.cellHeight;
        }
    }
    if (height == HDTableViewManagerCellHeightUnknow)
    {
        height = self.cellHeight;
    }
    if (height == HDTableViewManagerCellHeightUnknow)
    {
        Class cellClass = [self loadClassWith:indexPath];
        if ([cellClass isSubclassOfClass:[UITableViewCell class]])
        {
            height = [cellClass hd_cellHeightForTableView:tableView
                                                  content:[self loadItemDataWith:indexPath]];
        }
    }
    return height;
}

- (void (^)(id cell, id itemData,
            NSIndexPath *indexPath))loadCellConfigureWith:(NSIndexPath *)indexPath
{
    void (^cellConfigure)(id cell, id itemData, NSIndexPath *indexPath) = nil;
    NSObject<HDTableViewCellConfigureProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
    {
        cellConfigure = tableViewItem.cellConfigure;
    }
    if (!cellConfigure)
    {
        NSObject<HDTableViewCellConfigureProtocol> *tableViewSection =
            self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
        {
            cellConfigure = tableViewSection.cellConfigure;
        }
    }
    if (!cellConfigure)
    {
        cellConfigure = self.cellConfigure;
    }
    return cellConfigure;
}

- (void (^)(UITableView *tableView, id cell,
            NSIndexPath *indexPath))loadCellDidLoadHandlerWith:(NSIndexPath *)indexPath
{
    void (^cellDidLoadHandler)(UITableView *tableView, id cell, NSIndexPath *indexPath) = nil;
    NSObject<HDTableViewCellConfigureProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
    {
        cellDidLoadHandler = tableViewItem.cellDidLoadHandler;
    }
    if (!cellDidLoadHandler)
    {
        NSObject<HDTableViewCellConfigureProtocol> *tableViewSection =
            self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
        {
            cellDidLoadHandler = tableViewSection.cellDidLoadHandler;
        }
    }
    if (!cellDidLoadHandler)
    {
        cellDidLoadHandler = self.cellDidLoadHandler;
    }
    return cellDidLoadHandler;
}

- (void (^)(UITableView *tableView, id cell,
            NSIndexPath *indexPath))loadCellWillAppearHandlerWith:(NSIndexPath *)indexPath
{
    void (^cellWillAppearHandler)(UITableView *tableView, id cell, NSIndexPath *indexPath) = nil;
    NSObject<HDTableViewCellConfigureProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
    {
        cellWillAppearHandler = tableViewItem.cellWillAppearHandler;
    }
    if (!cellWillAppearHandler)
    {
        NSObject<HDTableViewCellConfigureProtocol> *tableViewSection =
            self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewCellConfigureProtocol)])
        {
            cellWillAppearHandler = tableViewSection.cellWillAppearHandler;
        }
    }
    if (!cellWillAppearHandler)
    {
        cellWillAppearHandler = self.cellWillAppearHandler;
    }
    return cellWillAppearHandler;
}

- (UITableViewCell *)loadCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    Class cellClass = [self loadClassWith:indexPath];
    NSString *cellellIdentifier = [self loadCellIdentifierWith:indexPath];
    UINib *nib = [self loadNibCacheWith:cellClass];
    void (^cellDidLoadHandler)(UITableView *tableView, id cell, NSIndexPath *indexPath) =
        [self loadCellDidLoadHandlerWith:indexPath];
    void (^cellWillAppearHandler)(UITableView *tableView, id cell, NSIndexPath *indexPath) =
        [self loadCellWillAppearHandlerWith:indexPath];
    if (nib)
    {
        cell = [cellClass hd_cellForTableView:tableView
                                      fromNib:nib
                                   identifier:cellellIdentifier
                                    indexPath:indexPath
                               didLoadHandler:cellDidLoadHandler
                            willAppearHandler:cellWillAppearHandler];
    }
    else
    {
        UITableViewCellStyle cellStyle = [self loadCellStyleWith:indexPath];
        if (cellellIdentifier.length > 0)
        {
            cell = [cellClass hd_cellForTableView:tableView
                                        withStyle:cellStyle
                                       identifier:cellellIdentifier
                                        indexPath:indexPath
                                   didLoadHandler:cellDidLoadHandler
                                willAppearHandler:cellWillAppearHandler];
        }
        else
        {
            // need call
            cell =
                [cellClass hd_cellForTableView:tableView withStyle:cellStyle indexPath:indexPath];
        }
    }
    return cell;
}

- (UINib *)loadNibCacheWith:(Class)cellClass
{
    NSAssert([cellClass isSubclassOfClass:[UITableViewCell class]],
             @"cellClass need subClass of UITablViewCell");
    UINib *nib = self.nibCache[NSStringFromClass(cellClass)];
    if (!nib)
    {
        nib = [cellClass hd_nib];
        if (nib)
        {
            self.nibCache[NSStringFromClass(cellClass)] = nib;
        }
    }
    return nib;
}

- (id)loadItemDataWith:(NSIndexPath *)indexPath
{
    id item = nil;
    NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[indexPath.section];
    NSMutableArray *rows = [tableViewSection items];
    NSObject<HDTableViewItemProtocol> *tableViewItem = rows[indexPath.row];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        item = tableViewItem.itemData;
    }
    else
    {
        item = tableViewItem;
    }
    return item;
}

#pragma mark
#pragma mark Getter/Setter

- (void)setNibCache:(NSMutableDictionary *)nibCache
{
    objc_setAssociatedObject(self, &kHDTableViewSection_HDPrivateUtilsExtend_nibCache, nibCache,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)nibCache
{
    NSMutableDictionary *nibCache =
        objc_getAssociatedObject(self, &kHDTableViewSection_HDPrivateUtilsExtend_nibCache);
    if (nil == nibCache)
    {
        nibCache = [NSMutableDictionary dictionary];
        [self setNibCache:nibCache];
    }
    return nibCache;
}

@end

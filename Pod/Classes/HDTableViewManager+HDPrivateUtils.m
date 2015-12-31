//
//  HDTableViewManager+HDPrivateUtils.m
//  Pods
//
//  Created by Dailingchi on 15/12/30.
//
//

#import "HDTableViewManager+HDPrivateUtils.h"
#import <objc/runtime.h>

static char *kHDTableViewSection_HDPrivateUtilsExtend_nibCache =
    "kHDTableViewSection_HDPrivateUtilsExtend_nibCache";

@implementation HDTableViewManager (HDPrivateUtils)

- (void (^)(UITableView *tableView, NSIndexPath *indexPath))
loadTableViewDidSelectRowAtIndexPathWith:(NSIndexPath *)indexPath
{
    void (^tableViewDidSelectRowAtIndexPathWith)(UITableView *tableView, NSIndexPath *indexPath) =
        nil;
    NSObject<HDTableViewItemProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        tableViewDidSelectRowAtIndexPathWith = tableViewItem.tableViewDidSelectRowAtIndexPath;
    }
    if (!tableViewDidSelectRowAtIndexPathWith)
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
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
    NSObject<HDTableViewItemProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        cellClass = tableViewItem.cellClass;
    }
    if (!cellClass)
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
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
    NSObject<HDTableViewItemProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        cellIdentifier = tableViewItem.cellIdentifier;
    }
    if (!cellIdentifier)
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
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
        cellIdentifier = [[self loadClassWith:indexPath] hd_cellIdentifier];
    }
    return cellIdentifier;
}

- (UITableViewCellStyle)loadCellStyleWith:(NSIndexPath *)indexPath
{
    UITableViewCellStyle cellStyle = UITableViewCellStyleUnknow;
    NSObject<HDTableViewItemProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        cellStyle = tableViewItem.cellStyle;
    }
    if (cellStyle == UITableViewCellStyleUnknow)
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
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
    NSObject<HDTableViewItemProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        height = tableViewItem.cellHeight;
    }
    if (height == HDTableViewManagerCellHeightUnknow)
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            height = tableViewSection.cellHeight;
        }
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
    NSObject<HDTableViewItemProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        cellConfigure = tableViewItem.cellConfigure;
    }
    if (!cellConfigure)
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
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
    NSObject<HDTableViewItemProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        cellDidLoadHandler = tableViewItem.cellDidLoadHandler;
    }
    if (!cellDidLoadHandler)
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
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
    NSObject<HDTableViewItemProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        cellWillAppearHandler = tableViewItem.cellWillAppearHandler;
    }
    if (!cellWillAppearHandler)
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
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
                                         item:[self itemAtIndexPath:indexPath]
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
                                             item:[self itemAtIndexPath:indexPath]
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
        item = tableViewItem.item;
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

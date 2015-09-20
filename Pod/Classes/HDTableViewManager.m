//
//  HDTableViewManager.m
//  Pods
//
//  Created by Dailingchi on 15/7/15.
//
//

#import "HDTableViewManager.h"

const CGFloat HDTableViewManagerAutomaticDimension = -7;

@interface HDTableViewManager ()

@property (nonatomic, strong) NSMutableDictionary *nibCache;

@end

@implementation HDTableViewManager

#pragma mark
#pragma mark Init

- (id)initWithSections:(NSMutableArray *)sections
             cellClass:(Class)cellClass
             cellStyle:(UITableViewCellStyle)cellStyle
    configureCellBlock:(HDTableViewManagerCellConfigure)cellConfigure
              delegate:(id<HDTableViewManagerDelegate>)delegate
{
    self = [self init];
    if (self)
    {
        _sections = sections;
        _cellClass = cellClass;
        _cellStyle = cellStyle;
        _cellConfigure = [cellConfigure copy];
        _delegate = delegate;
    }
    return self;
}

+ (id)manager
{
    HDTableViewManager *manager =
        [[HDTableViewManager alloc] initWithSections:[NSMutableArray array]
                                           cellClass:[UITableViewCell class]
                                           cellStyle:UITableViewCellStyleDefault
                                  configureCellBlock:^(id cell, id item, NSIndexPath *indexPath) {
                                    UITableViewCell *mCell = cell;
                                    [mCell hd_setContent:item];
                                  } delegate:nil];
    return manager;
}

#pragma mark
#pragma mark public method

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[indexPath.section];
    NSMutableArray *rows = tableViewSection.items;
    return rows[indexPath.row];
}

- (id)itemDataAtIndexPath:(NSIndexPath *)indexPath
{
    return [self loadItemDataWith:indexPath];
}

- (CGFloat)hd_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;

    UITableViewCell *cell = [self loadCellWith:tableView indexPath:indexPath];
    HDTableViewManagerCellConfigure cellConfigure = [self loadCellConfigureWith:indexPath];
    if (cellConfigure)
    {
        cellConfigure(cell, [self loadItemDataWith:indexPath], indexPath);
    }
    [cell layoutIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    // fix contenView height +1
    // for uilabel you need set preferredMaxLayoutWidth
    height = size.height + 1;
    return height;
}

#pragma mark
#pragma mark Private Utils

- (id)loadItemDataWith:(NSIndexPath *)indexPath
{
    id item = nil;
    NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[indexPath.section];
    NSMutableArray *rows = [tableViewSection items];
    // 1.load Item config
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

- (Class)loadClassWith:(NSIndexPath *)indexPath
{
    Class cellClass = nil;
    // 1.load Item config
    NSObject<HDTableViewItemProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        cellClass = tableViewItem.cellClass;
    }
    if (!cellClass)
    {
        // 2.load Section config
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            cellClass = tableViewSection.cellClass;
        }
    }
    if (!cellClass)
    {
        // 3.load Manager config
        cellClass = _cellClass;
    }
    if (!cellClass)
    {
        // 4.load Default
        cellClass = [UITableViewCell class];
    }
    return cellClass;
}

- (CGFloat)loadCellHeightWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44.0;
    Class cellClass = [self loadClassWith:indexPath];
    if ([cellClass isSubclassOfClass:[UITableViewCell class]])
    {
        height = [cellClass hd_cellHeightForTableView:tableView
                                              content:[self loadItemDataWith:indexPath]];
    }
    return height;
}

- (UITableViewCellStyle)loadCellStyleWith:(NSIndexPath *)indexPath
{
    static NSInteger unknow = -3;
    UITableViewCellStyle cellStyle = unknow;
    //     1.load Item config
    NSObject<HDTableViewItemProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        cellStyle = tableViewItem.cellStyle;
    }
    if (cellStyle == unknow)
    {
        // 2.load Section config
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            cellStyle = tableViewSection.cellStyle;
        }
    }
    if (cellStyle == unknow)
    {
        // 3.load Manager config
        cellStyle = UITableViewCellStyleDefault;
    }
    return cellStyle;
}

- (HDTableViewManagerCellConfigure)loadCellConfigureWith:(NSIndexPath *)indexPath
{
    HDTableViewManagerCellConfigure cellConfigure = nil;
    //     1.load Item config
    NSObject<HDTableViewItemProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        cellConfigure = tableViewItem.cellConfigure;
    }
    if (!cellConfigure)
    {
        // 2.load Section config
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[indexPath.section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            cellConfigure = tableViewSection.cellConfigure;
        }
    }
    if (!cellConfigure)
    {
        // 3.load Manager config
        cellConfigure = _cellConfigure;
    }
    return cellConfigure;
}

- (NSString *)loadCellIdentifierWith:(NSIndexPath *)indexPath
{
    NSString *cellellIdentifier;
    //     1.load Item config
    NSObject<HDTableViewItemProtocol> *tableViewItem = [self itemAtIndexPath:indexPath];
    if ([tableViewItem conformsToProtocol:@protocol(HDTableViewItemProtocol)])
    {
        cellellIdentifier = tableViewItem.cellIdentifier;
    }
    if (!cellellIdentifier)
    {
        cellellIdentifier = [[self loadClassWith:indexPath] hd_cellIdentifier];
    }
    return cellellIdentifier;
}

- (UITableViewCell *)loadCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    Class cellClass = [self loadClassWith:indexPath];
    NSString *cellellIdentifier = [self loadCellIdentifierWith:indexPath];
    UINib *nib = [self loadNibCacheWith:cellClass];
    if (nib)
    {
        cell = [cellClass hd_cellForTableView:tableView
                                      fromNib:nib
                                   identifier:cellellIdentifier
                                    indexPath:indexPath
                                         item:[self itemAtIndexPath:indexPath]];
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
                                             item:[self itemAtIndexPath:indexPath]];
        }
        else
        {
            cell =
                [cellClass hd_cellForTableView:tableView withStyle:cellStyle indexPath:indexPath];
        }
    }
    return cell;
}

#pragma mark
#pragma mark UITableViewDataSource

#pragma mark UITableViewDataSource required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[section];
    if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
    {
        numberOfRows = [tableViewSection items].count;
    }
    else
    {
        NSAssert(NO, @"%@ need conforms to HDTableViewSectionProtocol", [tableViewSection class]);
    }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    // if have datasource then load datasource value
    if ([self.dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)])
    {
        cell = [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    // check cell is load;(when datasource is uitableviewcontroller)
    if (!cell)
    {
        cell = [self loadCellWith:tableView indexPath:indexPath];
    }
    // config  cell
    HDTableViewManagerCellConfigure cellConfigure = [self loadCellConfigureWith:indexPath];
    if (cellConfigure)
    {
        cellConfigure(cell, [self loadItemDataWith:indexPath], indexPath);
    }
    return cell;
}

#pragma mark
#pragma mark UITableViewDataSource optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger item = _sections.count;
    return item;
}

#pragma mark
#pragma mark UITableViewDataSource optional Section Title

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    if ([self.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)])
    {
        title = [self.dataSource tableView:tableView titleForHeaderInSection:section];
    }
    else
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            title = [tableViewSection titleForHeader];
        }
    }
    return title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *title = @"";
    if ([self.dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)])
    {
        title = [self.dataSource tableView:tableView titleForFooterInSection:section];
    }
    else
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            title = [tableViewSection titleForFooter];
        }
    }
    return title;
}

#pragma mark
#pragma mark UITableViewDataSource optional Delete Action

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL canEdit = NO;
    if ([self.dataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)])
    {
        canEdit = [self.dataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return canEdit;
}

#pragma mark
#pragma mark UITableViewDelegate
#pragma mark
#pragma mark UITableViewDelegate optional row height

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = HDTableViewManagerAutomaticDimension;
    if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
    {
        height = [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    if (height == HDTableViewManagerAutomaticDimension)
    {
        height = [self tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView
    estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = HDTableViewManagerAutomaticDimension;
    if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)])
    {
        height = [self.delegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    if (height == HDTableViewManagerAutomaticDimension)
    {
        height = [self loadCellHeightWith:tableView indexPath:indexPath];
    }
    return height;
}

#pragma mark
#pragma mark UITableViewDelegate optional Section height

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = UITableViewAutomaticDimension;
    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)])
    {
        height = [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            if ([tableViewSection viewForHeader])
            {
                height = [tableViewSection heightForHeader];
            }
        }
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = UITableViewAutomaticDimension;
    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)])
    {
        height = [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            if ([tableViewSection viewForFooter])
            {
                height = [tableViewSection heightForFooter];
            }
        }
    }
    return height;
}

#pragma mark
#pragma mark UITableViewDelegate optional Section View

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = nil;
    if ([self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)])
    {
        view = [self.delegate tableView:tableView viewForHeaderInSection:section];
    }
    else
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            view = [tableViewSection viewForHeader];
        }
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = nil;
    if ([self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)])
    {
        view = [self.delegate tableView:tableView viewForFooterInSection:section];
    }
    else
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            view = [tableViewSection viewForFooter];
        }
    }
    return view;
}

#pragma mark
#pragma mark optional Delete Action

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle editingStyle = UITableViewCellEditingStyleNone;
    if ([self.delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)])
    {
        editingStyle = [self.delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return editingStyle;
}

- (NSString *)tableView:(UITableView *)tableView
    titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleForDelete = NSLocalizedString(@"Delete", @"");
    if ([self.delegate respondsToSelector:@selector(tableView:
                                              titleForDeleteConfirmationButtonForRowAtIndexPath:)])
    {
        [self.delegate tableView:tableView
            titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return titleForDelete;
}

- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
     forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource
            respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
    {
        [self.dataSource tableView:tableView
                commitEditingStyle:editingStyle
                 forRowAtIndexPath:indexPath];
    }
    else
    {
        [tableView beginUpdates];
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[indexPath.section];
            NSMutableArray *rows = [tableViewSection items];
            [rows removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[ indexPath ]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        [tableView endUpdates];
    }
}

#pragma mark
#pragma mark UITableViewDelegate optional Action

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
    {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark
#pragma mark Getter

- (NSMutableDictionary *)nibCache
{
    if (nil == _nibCache)
    {
        _nibCache = [[NSMutableDictionary alloc] init];
    }
    return _nibCache;
}

- (NSMutableArray *)sections
{
    if (nil == _sections)
    {
        _sections = [[NSMutableArray alloc] init];
    }
    return _sections;
}

@end

@implementation HDTableViewManager (Deprecated)

- (id)initWithSections:(NSMutableArray *)sections
             cellClass:(Class)cellClass
    configureCellBlock:(HDTableViewManagerCellConfigure)cellConfigure
{
    return [self initWithSections:sections
                        cellClass:cellClass
                        cellStyle:UITableViewCellStyleDefault
               configureCellBlock:cellConfigure
                         delegate:nil];
}
@end
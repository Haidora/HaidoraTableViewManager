//
//  HDTableViewManager.m
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

#import "HDTableViewManager.h"
#import "HDTableViewManager+HDPrivateUtils.h"
#import "UITableViewCell+HDTableViewManager.h"

const CGFloat HDTableViewManagerAutomaticDimension = -7;
const UITableViewCellStyle UITableViewCellStyleUnknow = -7;
const CGFloat HDTableViewManagerCellHeightUnknow = NSIntegerMax;

@interface HDTableViewManager ()
@end

@implementation HDTableViewManager

#pragma mark
#pragma mark HDTableViewConfigureProtocol

@synthesize tableViewDidSelectRowAtIndexPath = _tableViewDidSelectRowAtIndexPath;

#pragma mark
#pragma mark HDTableViewCellConfigureProtocol

@synthesize cellClass = _cellClass;
@synthesize cellIdentifier = _cellIdentifier;
@synthesize cellStyle = _cellStyle;
@synthesize cellHeight = _cellHeight;
@synthesize cellConfigure = _cellConfigure;
@synthesize cellDidLoadHandler = _cellDidLoadHandler;
@synthesize cellWillAppearHandler = _cellWillAppearHandler;

#pragma mark
#pragma mark Init

- (instancetype)initWithSections:(NSMutableArray *)sections
                       cellClass:(Class)cellClass
                       cellStyle:(UITableViewCellStyle)cellStyle
              configureCellBlock:(void (^)(id cell, id itemData,
                                           NSIndexPath *indexPath))cellConfigure
                        delegate:(id<HDTableViewManagerDelegate>)delegate
{
    self = [self init];
    if (self)
    {
        _sections = sections;
        _cellClass = cellClass;
        _cellStyle = cellStyle;
        _cellConfigure = [cellConfigure copy];
        _cellHeight = HDTableViewManagerCellHeightUnknow;
        _delegate = delegate;
    }
    return self;
}

+ (instancetype)manager
{
    HDTableViewManager *manager =
        [[HDTableViewManager alloc] initWithSections:[NSMutableArray array]
                                           cellClass:[UITableViewCell class]
                                           cellStyle:UITableViewCellStyleDefault
                                  configureCellBlock:^(id cell, id item, NSIndexPath *indexPath) {
                                    UITableViewCell *mCell = cell;
                                    [mCell hd_setContent:item];
                                  }
                                            delegate:nil];
    return manager;
}

#pragma mark
#pragma mark Forwarding DataSource / Delegate
//@link http://blog.scottlogic.com/2012/11/19/a-multicast-delegate-pattern-for-ios-controls.html

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector])
    {
        return YES;
    }
    else if (((id)self != (id)self.dataSource) && [self.dataSource respondsToSelector:aSelector])
    {
        return YES;
    }
    else if (((id)self != (id)self.delegate) && [self.delegate respondsToSelector:aSelector])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (((id)self != (id)self.dataSource) && [self.dataSource respondsToSelector:aSelector])
    {
        return self.dataSource;
    }
    else if (((id)self != (id)self.delegate) && [self.delegate respondsToSelector:aSelector])
    {
        return self.delegate;
    }
    else
    {
        // never call
        return nil;
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    // never call
    NSLog(@"%@_doesNotRecognizeSelector:%@", NSStringFromClass([self class]),
          NSStringFromSelector(aSelector));
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
    void (^cellConfigure)(id cell, id itemData, NSIndexPath *indexPath) =
        [self loadCellConfigureWith:indexPath];
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
        height = [self loadCellHeightWith:tableView indexPath:indexPath];
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
    else
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
    else
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
        void (^tableViewDidSelectRowAtIndexPathWith)(UITableView *tableView,
                                                     NSIndexPath *indexPath) =
            [self loadTableViewDidSelectRowAtIndexPathWith:indexPath];
        if (tableViewDidSelectRowAtIndexPathWith)
        {
            tableViewDidSelectRowAtIndexPathWith(tableView, indexPath);
        }
        else
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
}

#pragma mark
#pragma mark Getter

- (NSMutableArray *)sections
{
    if (nil == _sections)
    {
        _sections = [[NSMutableArray alloc] init];
    }
    return _sections;
}

@end

@implementation HDTableViewManager (HDTableViewManager_Utils)

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
    void (^cellConfigure)(id cell, id itemData, NSIndexPath *indexPath) =
        [self loadCellConfigureWith:indexPath];
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
@end

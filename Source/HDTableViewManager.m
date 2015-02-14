//
//  HDTableViewManager.m
//  HaidoraTableViewManager
//
//  Created by DaiLingchi on 15-1-20.
//  Copyright (c) 2015年 Haidora. All rights reserved.
//

#import "HDTableViewManager.h"
#import "UITableViewCell+HDTableViewManager.h"

@interface HDTableViewManager ()

@property (nonatomic, strong) UINib *nib;

@end

@implementation HDTableViewManager

- (id)initWithSections:(NSMutableArray *)items
             cellClass:(Class)cellClass
    configureCellBlock:(HDTableViewManagerCellConfigureBlock)cellConfigureBlock
{
    self = [super init];
    if (self)
    {
        _sectionDatas = items;
        _cellConfigureBlock = [cellConfigureBlock copy];
        _cellClass = cellClass;
    }
    return self;
}

- (UINib *)nib
{
    if (nil == _nib)
    {
        if ([_cellClass isSubclassOfClass:[UITableViewCell class]])
        {
            _nib = [_cellClass nib_HDTableViewManager];
        }
        else
        {
            NSAssert(NO, @"cellClass need subClass of UITablViewCell");
        }
    }
    return _nib;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<HDTableViewSectionProtocol> *tableViewSection = _sectionDatas[indexPath.section];
    NSMutableArray *rows = [tableViewSection sectionRows];
    return rows[indexPath.row];
}

#pragma mark
#pragma mark UITableView DataSource
#pragma mark
#pragma mark UITableView DataSource required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    NSObject<HDTableViewSectionProtocol> *tableViewSection = _sectionDatas[section];
    if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
    {
        numberOfRows = [tableViewSection sectionRows].count;
    }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block UITableViewCell *cell = nil;

    void (^loadCell)() = ^() {
      if (!cell && [_cellClass isSubclassOfClass:[UITableViewCell class]])
      {
          if (self.nib)
          {
              cell = [_cellClass cellForTableView_HDTableViewManager:tableView
                                                             fromNib:self.nib
                                                           indexPath:indexPath];
          }
          else
          {
              cell = [_cellClass cellForTableView_HDTableViewManager:tableView
                                                           withStyle:UITableViewCellStyleDefault
                                                           indexPath:indexPath];
          }
      }
    };
    // if have datasource load datasource value
    if ([self.dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)])
    {
        cell = [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
        loadCell();
    }
    else
    {
        loadCell();
    }
    // config  cell
    if (self.cellConfigureBlock)
    {
        self.cellConfigureBlock(cell, [self itemAtIndexPath:indexPath], indexPath);
    }
    return cell;
}

#pragma mark
#pragma mark UITableView DataSource optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger item = _sectionDatas.count;
    return item;
}

#pragma mark
#pragma mark UITableView DataSource optional Section Title

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    if ([self.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)])
    {
        title = [self.dataSource tableView:tableView titleForHeaderInSection:section];
    }
    else
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sectionDatas[section];
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
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sectionDatas[section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            title = [tableViewSection titleForFooter];
        }
    }
    return title;
}


#pragma mark
#pragma mark optional Delete Action

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL canEdit = NO;
    if ([self.dataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)])
    {
        canEdit = [self.dataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return canEdit;
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
            NSObject<HDTableViewSectionProtocol> *tableViewSection =
            _sectionDatas[indexPath.section];
            NSMutableArray *rows = [tableViewSection sectionRows];
            [rows removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[ indexPath ]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        [tableView endUpdates];
    }
}

#pragma mark
#pragma mark UITableViewDelegate
#pragma mark
#pragma mark UITableViewDelegate optional row height

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
    {
        return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    else
    {
        return [self tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView
    estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)])
    {
        height = [self.delegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    else
    {
        height = 44.0;
        if ([_cellClass isSubclassOfClass:[UITableViewCell class]])
        {
            height = [_cellClass
                cellHeightForTableView_HDTableViewManager:tableView
                                                  content:[self itemAtIndexPath:indexPath]];
        }
    }
    return height;
}

#pragma mark
#pragma mark UITableViewDelegate optional Section height

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)])
    {
        return [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    else
    {
        return [self tableView:tableView estimatedHeightForHeaderInSection:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)])
    {
        height = [self.delegate tableView:tableView estimatedHeightForHeaderInSection:section];
    }
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sectionDatas[section];
        if ([tableView conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            height = [tableViewSection heightForHeader];
        }
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)])
    {
        return [self.delegate tableView:tableView heightForFooterInSection:section];
    }
    else
    {
        return [self tableView:tableView estimatedHeightForFooterInSection:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0;
    if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)])
    {
        height = [self.delegate tableView:tableView estimatedHeightForFooterInSection:section];
    }
    {
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sectionDatas[section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            height = [tableViewSection heightForFooter];
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
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sectionDatas[section];
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
        NSObject<HDTableViewSectionProtocol> *tableViewSection = _sectionDatas[section];
        if ([tableViewSection conformsToProtocol:@protocol(HDTableViewSectionProtocol)])
        {
            view = [tableViewSection viewForFooter];
        }
    }
    return view;
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
#pragma mark Delete Action

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

@end

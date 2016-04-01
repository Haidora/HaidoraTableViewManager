//
//  HDTableViewManager+UITableViewDelegate.m
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

#import "HDTableViewManager+UITableViewDelegate.h"

#import "HDTableViewManager+HDPrivateUtils.h"

@implementation HDTableViewManager (UITableViewDelegate)

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
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[section];
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
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[section];
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
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[section];
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
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[section];
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
            NSObject<HDTableViewSectionProtocol> *tableViewSection =
                self.sections[indexPath.section];
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

@end

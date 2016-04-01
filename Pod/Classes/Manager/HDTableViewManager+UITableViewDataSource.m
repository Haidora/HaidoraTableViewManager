//
//  HDTableViewManager+UITableViewDataSource.m
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

#import "HDTableViewManager+UITableViewDataSource.h"

#import "HDTableViewManager+HDPrivateUtils.h"

@implementation HDTableViewManager (UITableViewDataSource)

#pragma mark
#pragma mark UITableViewDataSource

#pragma mark UITableViewDataSource required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[section];
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
    NSInteger item = self.sections.count;
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
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[section];
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
        NSObject<HDTableViewSectionProtocol> *tableViewSection = self.sections[section];
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

@end

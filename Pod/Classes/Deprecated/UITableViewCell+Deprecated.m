//
//  UITableViewCell+Deprecated.m
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

#import "UITableViewCell+Deprecated.h"
#import "UITableViewCell+HDTableViewManager.h"
#import <objc/runtime.h>

static char *kHD_item = "kHD_item";

@implementation UITableViewCell (HDTableViewManager_Deprecated)

+ (NSString *)hd_cellIdentifier
{
    return nil;
}

- (void)setHd_item:(id)hd_item
{
    objc_setAssociatedObject(self, &kHD_item, hd_item, OBJC_ASSOCIATION_ASSIGN);
}

- (id)hd_item
{
    return objc_getAssociatedObject(self, &kHD_item);
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
{
    return [self hd_cellForTableView:tableView
                           withStyle:style
                          identifier:identifier
                           indexPath:indexPath
                                item:item
                      didLoadHandler:nil
                   willAppearHandler:nil];
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[self class] alloc] initWithStyle:style reuseIdentifier:identifier];
        [cell hd_cellDidLoad];
        if (didLoadHandler)
        {
            didLoadHandler(tableView, cell, indexPath);
        }
    }
    cell.hd_tableView = tableView;
    cell.hd_indexPath = indexPath;
    cell.hd_item = item;
    [cell hd_cellWillAppear];
    if (willAppearHandler)
    {
        willAppearHandler(tableView, cell, indexPath);
    }
    return cell;
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
{
    return [self hd_cellForTableView:tableView
                             fromNib:nib
                          identifier:identifier
                           indexPath:indexPath
                                item:item
                      didLoadHandler:nil
                   willAppearHandler:nil];
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        NSArray *nibObjects = [nib instantiateWithOwner:nil options:nil];
        for (UITableViewCell *nibCell in nibObjects)
        {
            if ([[nibCell class] isSubclassOfClass:[UITableViewCell class]])
            {
                if ([nibCell.reuseIdentifier isEqualToString:identifier])
                {
                    cell = nibCell;
                    [cell hd_cellDidLoad];
                    if (didLoadHandler)
                    {
                        didLoadHandler(tableView, cell, indexPath);
                    }
                    break;
                }
            }
        }
        if (nil == cell)
        {
            NSAssert(false, @"xib(%@) not set reuseIdentifier for cellClass(%@)", [self hd_nibName],
                     [nib class]);
        }
    }
    cell.hd_tableView = tableView;
    cell.hd_indexPath = indexPath;
    cell.hd_item = item;
    [cell hd_cellWillAppear];
    if (willAppearHandler)
    {
        willAppearHandler(tableView, cell, indexPath);
    }
    return cell;
}
@end

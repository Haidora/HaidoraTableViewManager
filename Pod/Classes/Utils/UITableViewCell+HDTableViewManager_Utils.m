//
//  UITableViewCell+HDTableViewManager_Utils.m
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

#import "UITableViewCell+HDTableViewManager_Utils.h"
#import <objc/runtime.h>

@implementation UITableViewCell (HDTableViewManager_Utils)

+ (NSString *)hd_ReusableCellIdentifier
{
    return NSStringFromClass([self class]);
}

#pragma mark
#pragma mark Load Cell

#pragma mark Load Cell By code

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                          indexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"HABTableViewCellSystem";
    switch (style)
    {
    case UITableViewCellStyleDefault:
        cellIdentifier = @"HABTableViewCellStyleDefault";
        break;
    case UITableViewCellStyleValue1:
        cellIdentifier = @"HABTableViewCellStyleValue1";
        break;
    case UITableViewCellStyleValue2:
        cellIdentifier = @"HABTableViewCellStyleValue2";
        break;
    case UITableViewCellStyleSubtitle:
        cellIdentifier = @"HABTableViewCellStyleSubtitle";
        break;
    default:
        break;
    }
    return [self hd_cellForTableView:tableView
                           withStyle:style
                          identifier:cellIdentifier
                           indexPath:indexPath];
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
{
    return [self hd_cellForTableView:tableView
                           withStyle:style
                          identifier:identifier
                           indexPath:indexPath
                      didLoadHandler:nil
                   willAppearHandler:nil];
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler
{
    NSParameterAssert(tableView);
    NSParameterAssert(identifier);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[self class] alloc] initWithStyle:style reuseIdentifier:identifier];
        if (didLoadHandler)
        {
            didLoadHandler(tableView, cell, indexPath);
        }
        [cell hd_cellDidLoad];
    }
    cell.hd_tableView = tableView;
    cell.hd_indexPath = indexPath;
    if (willAppearHandler)
    {
        willAppearHandler(tableView, cell, indexPath);
    }
    [cell hd_cellWillAppear];
    return cell;
}

#pragma mark Load Cell By nib

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                          indexPath:(NSIndexPath *)indexPath
{
    return [self hd_cellForTableView:tableView
                             fromNib:nib
                          identifier:[self hd_ReusableCellIdentifier]
                           indexPath:indexPath];
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
{
    return [self hd_cellForTableView:tableView
                             fromNib:nib
                          identifier:identifier
                           indexPath:indexPath
                      didLoadHandler:nil
                   willAppearHandler:nil];
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler
{
    NSParameterAssert(tableView);
    NSParameterAssert(nib);
    NSParameterAssert(identifier);
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
                    if (didLoadHandler)
                    {
                        didLoadHandler(tableView, cell, indexPath);
                    }
                    [cell hd_cellDidLoad];
                    break;
                }
            }
        }
        if (nil == cell)
        {
            NSAssert(false, @"xib(%@) not set reuseIdentifier(%@) for cellClass(%@)", nib,
                     identifier, [self class]);
        }
    }
    cell.hd_tableView = tableView;
    cell.hd_indexPath = indexPath;
    if (willAppearHandler)
    {
        willAppearHandler(tableView, cell, indexPath);
    }
    [cell hd_cellWillAppear];
    return cell;
}

#pragma mark
#pragma mark Life cycle

- (void)hd_cellDidLoad
{
}

- (void)hd_cellWillAppear
{
}

#pragma mark
#pragma mark Setter/Getter

- (void)setHd_tableView:(UITableView *)hd_tableView
{
    objc_setAssociatedObject(self, @selector(hd_tableView), hd_tableView, OBJC_ASSOCIATION_ASSIGN);
}

- (UITableView *)hd_tableView
{
    return objc_getAssociatedObject(self, @selector(hd_tableView));
}

- (void)setHd_indexPath:(NSIndexPath *)hd_indexPath
{
    objc_setAssociatedObject(self, @selector(hd_indexPath), hd_indexPath,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)hd_indexPath
{
    return objc_getAssociatedObject(self, @selector(hd_indexPath));
}

@end
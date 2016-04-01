//
//  UITableViewCell+HDTableViewManager.m
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

#import "UITableViewCell+HDTableViewManager.h"

#import "UITableViewCell+Deprecated.h"
#import <objc/runtime.h>

static char *kHD_tableView = "kHD_tableView";
static char *kHD_indexPath = "kHD_indexPath";

@implementation UITableViewCell (HDTableViewManager)

#pragma mark
#pragma mark Cell Config

+ (NSString *)hd_ReusableCellIdentifier
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSString *hd_ReusableCellIdentifier = [self hd_cellIdentifier];
#pragma clang diagnostic pop
    if (hd_ReusableCellIdentifier.length <= 0)
    {
        hd_ReusableCellIdentifier = NSStringFromClass([self class]);
    }
    return hd_ReusableCellIdentifier;
}

+ (CGFloat)hd_cellHeight
{
    return 44;
}

+ (CGFloat)hd_cellHeightForTableView:(UITableView *)tableView content:(id)content
{
    return [self hd_cellHeight];
}

- (void)hd_setContent:(id)content
{
}

#pragma mark Cell Config nib

+ (NSString *)hd_nibName
{
    return NSStringFromClass([self class]);
}

+ (UINib *)hd_nib
{
    NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
    if ([classBundle pathForResource:[self hd_nibName] ofType:@"nib"])
    {
        return [UINib nibWithNibName:[self hd_nibName] bundle:classBundle];
    }
    else
    {
        return nil;
    }
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
    [cell hd_cellWillAppear];
    if (willAppearHandler)
    {
        willAppearHandler(tableView, cell, indexPath);
    }
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
    [cell hd_cellWillAppear];
    if (willAppearHandler)
    {
        willAppearHandler(tableView, cell, indexPath);
    }
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
    objc_setAssociatedObject(self, &kHD_tableView, hd_tableView, OBJC_ASSOCIATION_ASSIGN);
}

- (UITableView *)hd_tableView
{
    return objc_getAssociatedObject(self, &kHD_tableView);
}

- (void)setHd_indexPath:(NSIndexPath *)hd_indexPath
{
    objc_setAssociatedObject(self, &kHD_indexPath, hd_indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)hd_indexPath
{
    return objc_getAssociatedObject(self, &kHD_indexPath);
}

@end

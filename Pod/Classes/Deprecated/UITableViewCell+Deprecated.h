//
//  UITableViewCell+Deprecated.h
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

#import <UIKit/UIKit.h>

@interface UITableViewCell (HDTableViewManager_Deprecated)

@property (nonatomic, weak, readwrite) id hd_item DEPRECATED_ATTRIBUTE;

/**
 *  配置cell复用identifier
 *
 */
+ (NSString *)hd_cellIdentifier DEPRECATED_ATTRIBUTE;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item DEPRECATED_ATTRIBUTE;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler
    DEPRECATED_ATTRIBUTE;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item DEPRECATED_ATTRIBUTE;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler
    DEPRECATED_ATTRIBUTE;

@end
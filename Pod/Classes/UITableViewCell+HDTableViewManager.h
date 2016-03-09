//
//  UITableViewCell+HDTableViewManager.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableViewCell (HDTableViewManager)

@property (nonatomic, weak, readwrite) UITableView *hd_tableView;
@property (nonatomic, strong, readwrite) NSIndexPath *hd_indexPath;
@property (nonatomic, weak, readwrite) id hd_item;

#pragma mark
#pragma mark Cell Config

/**
 *  指定Cell的ReusableIdentifier
 *
 *  @return 默认返回 NSStringFromClass([self class])
 */
+ (NSString *)hd_ReusableCellIdentifier;

/**
 *  指定Cell需要加载nib的名称
 */
+ (NSString *)hd_nibName;

/**
 *  创建nib
 */
+ (UINib *)hd_nib;

/**
 *  配置cell高度
 */
+ (CGFloat)hd_cellHeight;

/**
 *  根据内容配置高度
 */
+ (CGFloat)hd_cellHeightForTableView:(UITableView *)tableView content:(id)content;

/**
 *  用数据配置Cell的UI
 */
- (void)hd_setContent:(id)content;

#pragma mark
#pragma mark Load Cell

/**
 *  根据style创建cell
 */
+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                          indexPath:(NSIndexPath *)indexPath;

/**
 *  根据style和创建cell
 */
+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler;

/**
 *  根据nib创建cell
 */
+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                          indexPath:(NSIndexPath *)indexPath;

/**
 *  根据nib和identifier创建cell
 */
+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler;

#pragma mark
#pragma mark Life Cycle

/**
 *  cell创建以后调用
 */
- (void)hd_cellDidLoad __attribute__((objc_requires_super));

/**
 *  cell显示时调用
 */
- (void)hd_cellWillAppear __attribute__((objc_requires_super));

@end

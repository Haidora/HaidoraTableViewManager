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

/**
 UITableViewCell的扩展,方便UITableViewCell的使用
 */
@interface UITableViewCell (HDTableViewManager)

/**
 Cell对应的tableView
 */
@property (nonatomic, weak, readwrite) UITableView *hd_tableView;

/**
 Cell对应的indexPath
 */
@property (nonatomic, strong, readwrite) NSIndexPath *hd_indexPath;

#pragma mark
#pragma mark Cell Config

/**
 指定Cell的ReusableIdentifier

 @return 默认返回 NSStringFromClass([self class])
 */
+ (NSString *)hd_ReusableCellIdentifier;

/**
 配置cell高度

 @return 默认44
 */
+ (CGFloat)hd_cellHeight;

/**
 根据内容配置高度

 @return 默认返回hd_cellHeight
 */
+ (CGFloat)hd_cellHeightForTableView:(UITableView *)tableView content:(id)content;

/**
 用数据配置Cell的UI,可自由发挥
 */
- (void)hd_setContent:(id)content;

#pragma mark Cell Config nib

/**
 指定Cell需要加载nib的名称

 @return 默认返回 NSStringFromClass([self class])
 */
+ (NSString *)hd_nibName;

/**
 创建nib

 @return 默认通过hd_nibName加载
 */
+ (UINib *)hd_nib;

#pragma mark
#pragma mark Load Cell

#pragma mark Load Cell By code

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                          indexPath:(NSIndexPath *)indexPath;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler;

#pragma mark Load Cell By nib

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                          indexPath:(NSIndexPath *)indexPath;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler;

#pragma mark
#pragma mark Life Cycle

/**
 cell创建以后调用
 */
- (void)hd_cellDidLoad __attribute__((objc_requires_super));

/**
 cell显示时调用(cellForRowAtIndexPath)
 */
- (void)hd_cellWillAppear __attribute__((objc_requires_super));

/**
 *  tableView:willDisplayCell:forRowAtIndexPath:
 */
- (void)hd_cellWillDisplay __attribute__((objc_requires_super));

@end

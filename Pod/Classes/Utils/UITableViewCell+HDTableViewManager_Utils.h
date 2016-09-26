//
//  UITableViewCell+HDTableViewManager_Utils.h
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

/**
 *  UITableViewCell工具类(主要用于UITableViewCell的创建)
 */
@interface UITableViewCell (HDTableViewManager_Utils)

/**
 UITableViewCell对应的UITableView,通过工具方法创建Cell时会绑定
 */
@property (nonatomic, weak, readonly) UITableView *hd_tableView;

/**
 UITableViewCell对应的indexPath,通过工具方法创建Cell时会绑定
 */
@property (nonatomic, strong, readonly) NSIndexPath *hd_indexPath;

#pragma mark
#pragma mark Cell Config

/**
 指定UITableViewCell的ReusableIdentifier

 @return 默认返回 NSStringFromClass([self class])
 */
+ (NSString *)hd_ReusableCellIdentifier;

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

/**
 *  工具方法:用于创建UITableViewCell
 *
 *  @param tableView
 *  @param style
 *  @param identifier
 *  @param indexPath
 *  @param didLoadHandler 会在hd_cellDidLoad之前调用
 *  @param willAppearHandler 会在hd_cellWillAppear之前调用
 */
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

/**
 *  工具方法:用于创建UITableViewCell
 *
 *  @param tableView
 *  @param nib
 *  @param identifier
 *  @param indexPath
 *  @param didLoadHandler 会在hd_cellDidLoad之前调用
 *  @param willAppearHandler 会在hd_cellWillAppear之前调用
 */
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
 UITableViewCell创建以后调用,通过工具方法创建Cell时会调用

 @see (instantiateWithOwner:options:或initWithStyle:reuseIdentifier:)后调用
 */
- (void)hd_cellDidLoad __attribute__((objc_requires_super));

/**
 UITableViewCell复用时调用,通过工具方法创建Cell时会调用

 @see (dequeueReusableCellWithIdentifier:)后调用
 */
- (void)hd_cellWillAppear __attribute__((objc_requires_super));

@end

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

#import "UITableViewCell+HDTableViewManager_Utils.h"

/**
 UITableViewCell的扩展,方便UITableViewCell的使用
 */
@interface UITableViewCell (HDTableViewManager)

#pragma mark
#pragma mark Cell Config
/**
 配置UITableViewCell高度

 @return 默认44
 */
+ (CGFloat)hd_cellHeight;

/**
 根据内容配置高度

 @return 默认返回hd_cellHeight
 */
+ (CGFloat)hd_cellHeightForTableView:(UITableView *)tableView content:(id)content;

/**
 用数据配置Cell的UI,可自由发挥(该方法需要手动调用),写在这里的目的只是为Cell提供一个set方法
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
#pragma mark Life Cycle

/**
 *  @see tableView:willDisplayCell:forRowAtIndexPath:后调用
 */
- (void)hd_cellWillDisplay __attribute__((objc_requires_super));

@end

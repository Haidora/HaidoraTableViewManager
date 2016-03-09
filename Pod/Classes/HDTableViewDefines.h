//
//  HDTableViewDefines.h
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

#ifndef Pods_HDTableViewDefines_h
#define Pods_HDTableViewDefines_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * @brief
 *如果HDTableViewManagerDelegate中cell高度返回为HDTableViewManagerAutomaticDimension,则根据配置加载UITableViewCell(配置优先级item>section>manager>cell)的高度.
 *
 * @see - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath
 **)indexPath
 * @see - (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath
 **)indexPath
 */
extern const CGFloat HDTableViewManagerAutomaticDimension;

extern const UITableViewCellStyle UITableViewCellStyleUnknow;
extern const CGFloat HDTableViewManagerCellHeightUnknow;

#pragma mark
#pragma mark HDTableViewConfigureProtocol

@protocol HDTableViewConfigureProtocol <NSObject>

@optional
/**
 * tableViewDidSelectRowAtIndexPath(item>section>manager)
 *
 *  @see - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 */
@property (nonatomic, copy, readwrite) void (^tableViewDidSelectRowAtIndexPath)
    (UITableView *tableView, NSIndexPath *indexPath);

@end

#pragma mark
#pragma mark HDTableViewCellConfigureProtocol
/**
 *  用于配置TableView Cell相关属性
 */
@protocol HDTableViewCellConfigureProtocol <NSObject>

@required

/**
 *  指定Cell实例化的Class.(item>section>manager)
 */
@property (nonatomic, assign, readwrite) Class cellClass;

/**
 *  指定Cell的reusableIdentifier.(item>section>manager>[cell hd_ReusableCellIdentifier])
 */
@property (nonatomic, copy, readwrite) NSString *cellIdentifier;

/**
 *  指定Cell的style(通过代码创建Cell时有效,默认是UITableViewCellStyleUnknow)(item>section>manager)
 *
 *  @see UITableViewCellStyle
 */
@property (nonatomic, assign, readwrite) UITableViewCellStyle cellStyle;

/**
 *  指定Cell的高度(默认是HDTableViewManagerCellHeightUnknow)(item>section>manager>[cell
 * hd_cellHeightForTableView]>[cell hd_cellHeight])
 *
 *  @see HDTableViewManagerCellHeightUnknow
 */
@property (nonatomic, assign, readwrite) CGFloat cellHeight;

/**
 *  Cell数据配置回调(item>section>manager)
 *
 *  @param cell
 *  @param itemData     cell对应的数据
 *  @param indexPath    cell对应的indexPath
 */
@property (nonatomic, copy, readwrite) void (^cellConfigure)
    (__kindof UITableViewCell *cell, id itemData, NSIndexPath *indexPath);

/**
 *  Cell创建后回调,用于给cell配置其他参数(类似Cell的hd_cellDidLoad,可同时存在)(item>section>manager)
 */
@property (nonatomic, copy, readwrite) void (^cellDidLoadHandler)
    (__kindof UITableView *tableView, __kindof UITableViewCell *cell, NSIndexPath *indexPath);

/**
 *  Cell创建后回调,用于给cell配置其他参数(类似Cell的hd_cellWillAppear,可同时存在)(item>section>manager)
 */
@property (nonatomic, copy, readwrite) void (^cellWillAppearHandler)
    (__kindof UITableView *tableView, __kindof UITableViewCell *cell, NSIndexPath *indexPath);

@end

#pragma mark
#pragma mark HDTableViewSectionProtocol
/**
 *  用于配置TableView Section相关属性
 */
@protocol HDTableViewSectionProtocol

@required
#pragma mark Cells
/**
 *  Section下面的cell数据(实现HDTableViewItemProtocol协议的数据或者一个普通的数据)
 */
@property (nonatomic, strong, readonly) NSMutableArray *items;

@optional
#pragma mark Header
/**
 *  指定Section的Header title(如果实现了titleForHeaderInSection则无效)
 *
 *  @see - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 */
@property (nonatomic, copy, readwrite) NSString *titleForHeader;

/**
 *  指定Section的Header的高度(viewForHeader不为空时有效)(如果实现了heightForHeaderInSection则无效)
 *
 *  @see - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
 */
@property (nonatomic, assign, readwrite) CGFloat heightForHeader;

/**
 *  指定Section的Header view(如果实现了viewForHeaderInSection则无效)
 *
 *  @see - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 */
@property (nonatomic, strong, readwrite) UIView *viewForHeader;

#pragma mark Footer
/**
 *  指定Section的Footer title如果实现了titleForFooterInSection则无效)
 *
 *  @see - (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
 */
@property (nonatomic, copy, readwrite) NSString *titleForFooter;

/**
 *  指定Section的Footer的高度(viewForFooter不为空时有效)如果实现了heightForFooterInSection则无效)
 *
 *  @see - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
 */
@property (nonatomic, assign, readwrite) CGFloat heightForFooter;

/**
 *  指定Section的Footer view如果实现了viewForFooterInSection则无效)
 *
 *  @see - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
 */
@property (nonatomic, strong, readwrite) UIView *viewForFooter;

@end

#pragma mark
#pragma mark HDTableViewItemProtocol
/**
 *  用于配置TableView Cell相关属性
 */
@protocol HDTableViewItemProtocol

@required
/**
 *  cell对应的数据
 */
@property (nonatomic, strong, readwrite) id itemData;

@optional
@property (nonatomic, strong, readwrite) id item DEPRECATED_ATTRIBUTE;

@end

#pragma mark
#pragma mark HDTableViewManagerDelegate

@protocol HDTableViewManagerDataSource <UITableViewDataSource>

@end

@protocol HDTableViewManagerDelegate <UITableViewDelegate>

@end

#endif

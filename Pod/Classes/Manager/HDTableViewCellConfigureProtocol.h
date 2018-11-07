//
//  HDTableViewCellConfigureProtocol.h
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

#pragma mark
#pragma mark HDTableViewCellConfigureProtocol
/**
 *  HDTableViewManager配置UITableViewCell相关属性
 */
@protocol HDTableViewCellConfigureProtocol <NSObject>

@required

/**
 实例化UITableViewCell的Class(subClassOf UITableViewCell)

 配置加载顺序:
 1. item
 2. section
 3. manager

 应用场景:假如一个tableview中各行的cell不一样,可针对每一行配置cell的Class
 */
@property (nonatomic, assign, readwrite) Class cellClass;

/**
 UITableViewCell的reusableIdentifier

 配置加载顺序:
 1. item
 2. section
 3. manager
 4. [cell hd_ReusableCellIdentifier]

 应用场景:与cellClass配置使用
 */
@property (nonatomic, copy, readwrite) NSString *cellIdentifier;

@optional
/**
 TableViewCell的Style,默认是UITableViewCellStyleUnknow

 配置加载顺序:
 1. item
 2. section
 3. manager

 @see UITableViewCellStyle
 @warning 通过代码创建Cell时有效
 */
@property (nonatomic, assign, readwrite) UITableViewCellStyle cellStyle;

/**
 TableViewCell的Height,默认是HDTableViewManagerCellHeightUnknow

 配置加载顺序 item>section>manager>[cell hd_cellHeightForTableView]>[cell hd_cellHeight]

 @see -tableView:heightForRowAtIndexPath:
 @see -tableView:estimatedHeightForRowAtIndexPath:
 */
@property (nonatomic, assign, readwrite) CGFloat cellHeight;

/**
 用于配置TableViewCell的数据

 配置加载顺序 item>section>manager

 @param cell         对应的cell
 @param itemData     cell对应的数据
 @param indexPath    cell对应的indexPath

 @see -tableView:cellForRowAtIndexPath:
 */
@property (nonatomic, copy, readwrite) void (^cellConfigure)
    (__kindof UITableViewCell *cell, id itemData, NSIndexPath *indexPath);

/**
 TableViewCell创建后回调

 配置加载顺序 item>section>manager

 @param tableView    cell所在的tableView
 @param cell         对应的cell
 @param indexPath    cell对应的indexPath

 @see -tableView:cellForRowAtIndexPath:
 @warning (类似Cell的hd_cellDidLoad,可同时存在)
 */
@property (nonatomic, copy, readwrite) void (^cellDidLoadHandler)
    (__kindof UITableView *tableView, __kindof UITableViewCell *cell, NSIndexPath *indexPath);

/**
 TableViewCell创建后回调

 配置加载顺序 item>section>manager>hd_cellWillDisplay

 @param tableView    cell所在的tableView
 @param cell         对应的cell
 @param indexPath    cell对应的indexPath

 @see -tableView:cellForRowAtIndexPath:
 @warning (类似Cell的hd_cellWillAppear,可同时存在)
 */
@property (nonatomic, copy, readwrite) void (^cellWillAppearHandler)
    (__kindof UITableView *tableView, __kindof UITableViewCell *cell, NSIndexPath *indexPath);

@end

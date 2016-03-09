//
//  HDTableViewManager.m
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
#import "HDTableViewDefines.h"

/**
 *  UITableVieDataSource 和 UITableViewDelegate的封装.
 */
@interface HDTableViewManager
    : NSObject <HDTableViewConfigureProtocol, HDTableViewCellConfigureProtocol,
                UITableViewDataSource, UITableViewDelegate>

/**
 *  对应UITableView中的sections.(元素需要实现<HDTableViewConfigureProtocol,
 HDTableViewCellConfigureProtocol,
 HDTableViewItemProtocol>),auto create
 */
@property (nonatomic, strong, readwrite) NSMutableArray *sections;

/**
 *  <UITableViewDataSource>,默认为nil
 */
@property (nonatomic, weak, readwrite) id<HDTableViewManagerDataSource> dataSource;

/**
 *  <UITableViewDelegate>,默认为nil
 */
@property (nonatomic, weak, readwrite) id<HDTableViewManagerDelegate> delegate;

- (instancetype)initWithSections:(NSMutableArray *)sections
                       cellClass:(Class)cellClass
                       cellStyle:(UITableViewCellStyle)cellStyle
              configureCellBlock:(void (^)(id cell, id itemData,
                                           NSIndexPath *indexPath))cellConfigure
                        delegate:(id<HDTableViewManagerDelegate>)delegate;

/**
*  创建manager
*
*  @param sections
*  @param cellClass     默认为UITableViewCell
*  @param cellStyle     默认为UITableViewCellStyleDefault
*  @param cellConfigure 默认为[tableViewCell hd_setContent:xxx]
*  @param delegate      默认为nil
*
*  @return
*/
+ (instancetype)manager;

@end

@interface HDTableViewManager (HDTableViewManager_Utils)

/**
 *  获取指定indexPath的item
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  获取指定indexPath的数据模型
 *
 */
- (id)itemDataAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  计算Cell高度,如果计算高度不对,请配合使用https://github.com/forkingdog/UITableView-FDTemplateLayoutCell
 */
- (CGFloat)hd_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

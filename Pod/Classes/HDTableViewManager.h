//
//  HDTableViewManager.h
//  Pods
//
//  Created by Dailingchi on 15/7/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HDTableViewDefines.h"
#import "UITableViewCell+HDTableViewManager.h"

/**
 *  UITableVieDataSource 和 UITableViewDelegate的封装.
 */
@interface HDTableViewManager : NSObject <UITableViewDataSource, UITableViewDelegate>

/**
 *  对应UITableView中的sections.(元素需要实现<HDTableViewSectionProtocol>),auto create
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

#pragma mark Cell

/**
 *  UITableViewCell加载的类型
 */
@property (nonatomic, assign, readwrite) Class cellClass;

/**
 *  UITableViewCell的style(当通过代码创建系统Cell时有效)
 */
@property (nonatomic, assign, readwrite) UITableViewCellStyle cellStyle;

/**
 *  UITableViewCell数据配置回调
 */
@property (nonatomic, copy, readwrite) HDTableViewManagerCellConfigure cellConfigure;

- (id)initWithSections:(NSMutableArray *)sections
             cellClass:(Class)cellClass
             cellStyle:(UITableViewCellStyle)cellStyle
    configureCellBlock:(HDTableViewManagerCellConfigure)cellConfigure
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
+ (id)manager;

/**
 *  获取指定indexPath的item
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  获取指定indexPath的数据模型
 *
 */
- (id)itemDataAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)hd_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HDTableViewManager (Deprecated)

/**
 *  manager or
 *
 - (id)initWithSections:(NSMutableArray *)sections

 cellClass:(Class)cellClass

 cellStyle:(UITableViewCellStyle)cellStyle

 configureCellBlock:(HDTableViewManagerCellConfigure)cellConfigure

 delegate:(id<HDTableViewManagerDelegate>)delegate

 */
- (id)initWithSections:(NSMutableArray *)sections
             cellClass:(Class)cellClass
    configureCellBlock:(HDTableViewManagerCellConfigure)cellConfigure DEPRECATED_ATTRIBUTE;

@end

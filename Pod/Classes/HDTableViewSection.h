//
//  HDTableViewSection.h
//  Pods
//
//  Created by Dailingchi on 15/7/15.
//
//

#import <Foundation/Foundation.h>
#import "HDTableViewDefines.h"

@interface HDTableViewSection : NSObject <HDTableViewSectionProtocol>

#pragma mark Header

/**
 *  tableView section header title
 */
@property (nonatomic, copy, readwrite) NSString *titleForHeader;

/**
 *  tableView section header height.(viewForHeader不为空时有效)
 */
@property (nonatomic, assign, readwrite) CGFloat heightForHeader;

/**
 *  tableView section custom header view.
 */
@property (nonatomic, strong, readwrite) UIView *viewForHeader;

#pragma mark Footer

/**
 *  tableView section footer title
 */
@property (nonatomic, copy, readwrite) NSString *titleForFooter;

/**
 *  tableView section footer height.(viewForFooter不为空时有效)
 */
@property (nonatomic, assign, readwrite) CGFloat heightForFooter;

/**
 *  tableView section custom footer view.
 */
@property (nonatomic, strong, readwrite) UIView *viewForFooter;

#pragma mark Cells

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

/**
 *  section下面的cell数据模型
 */
@property (nonatomic, strong, readonly) NSMutableArray *items;

+ (id)section;

@end

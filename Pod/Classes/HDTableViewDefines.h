//
//  HDTableViewDefines.h
//  Pods
//
//  Created by Dailingchi on 15/7/15.
//
//

#ifndef Pods_HDTableViewDefines_h
#define Pods_HDTableViewDefines_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 * @brief
 *如果HDTableViewManagerDelegate中cell高度返回为HDTableViewManagerAutomaticDimension,则根据配置加载UITableViewCell(item>section>manager>cell)中的高度.
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
 *  @see - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 */
@property (nonatomic, copy, readwrite) void (^tableViewDidSelectRowAtIndexPath)
    (UITableView *tableView, NSIndexPath *indexPath);

@end

#pragma mark
#pragma mark HDTableViewCellConfigureProtocol

@protocol HDTableViewCellConfigureProtocol <NSObject>

@required

/**
 *  UITableViewCell加载的类型
 */
@property (nonatomic, assign, readwrite) Class cellClass;

/**
 *  创建cell时reusableIdentifier
 */
@property (nonatomic, copy, readwrite) NSString *cellIdentifier;

/**
 *  UITableViewCell的style(当通过代码创建系统Cell时有效)
 *  @see UITableViewCellStyle
 */
@property (nonatomic, assign, readwrite) UITableViewCellStyle cellStyle;

/**
 *  UITableViewCell的高度(默认是HDTableViewManagerCellHeightUnknow)
 */
@property (nonatomic, assign, readwrite) CGFloat cellHeight;

/**
 *  UITableViewCell 数据配置回调
 *
 *  @param cell
 *  @param itemData     cell对应的数据
 *  @param indexPath    cell对应的indexPath
 */
@property (nonatomic, copy, readwrite) void (^cellConfigure)
    (UITableViewCell *cell, id itemData, NSIndexPath *indexPath);

/**
 *  UITableViewCell创建后回调,用于给cell配置其他参数(类似UITableViewCell的hd_cellDidLoad,可同时存在)
 */
@property (nonatomic, copy, readwrite) void (^cellDidLoadHandler)
    (UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);

/**
 *  UITableViewCell创建后回调,用于给cell配置其他参数(类似UITableViewCell的hd_cellWillAppear,可同时存在)
 */
@property (nonatomic, copy, readwrite) void (^cellWillAppearHandler)
    (UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);

@end

#pragma mark
#pragma mark HDTableViewSectionProtocol
/**
 *  用于配置TableView Section相关属性
 */
@protocol
    HDTableViewSectionProtocol <HDTableViewConfigureProtocol, HDTableViewCellConfigureProtocol>

@required

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
 *  section下面的cell数据模型
 */
@property (nonatomic, strong, readonly) NSMutableArray *items;

@end

#pragma mark
#pragma mark HDTableViewItemProtocol

/**
 *  用于配置TableView Cell相关属性
 */
@protocol HDTableViewItemProtocol <HDTableViewConfigureProtocol, HDTableViewCellConfigureProtocol>

@required

/**
 *  cell对应的数据
 */
@property (nonatomic, strong, readwrite) id item;

@end

#pragma mark
#pragma mark HDTableViewManagerDelegate

@protocol HDTableViewManagerDataSource <UITableViewDataSource>

@end

@protocol HDTableViewManagerDelegate <UITableViewDelegate>

@end

#endif

#pragma mark
#pragma mark DEPRECATED

typedef void (^HDTableViewManagerCellConfigure)(id cell, id itemData,
                                                NSIndexPath *indexPath) DEPRECATED_ATTRIBUTE;

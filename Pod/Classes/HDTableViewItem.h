//
//  HDTableViewItem.h
//  Pods
//
//  Created by Dailingchi on 15/7/15.
//
//

#import <Foundation/Foundation.h>
#import "HDTableViewDefines.h"

@interface HDTableViewItem : NSObject <HDTableViewItemProtocol>

#pragma mark
#pragma mark HDTableViewConfigureProtocol
/**
 *  @see - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 */
@property (nonatomic, copy, readwrite) void (^tableViewDidSelectRowAtIndexPath)
    (UITableView *tableView, NSIndexPath *indexPath);

#pragma mark
#pragma mark HDTableViewCellConfigureProtocol

/**
 *  UITableViewCell加载的类型
 */
@property (nonatomic, assign, readwrite) Class cellClass;

/**
 *  创建cell时reusableIdentifier
 */
@property (nonatomic, copy, readwrite) NSString *cellIdentifier;

/**
 *  UITableViewCell的style(当通过代码创建系统Cell时有效默认是UITableViewCellStyleUnknow)
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

#pragma mark
#pragma mark HDTableViewItemProtocol
/**
 *  cell对应的数据
 */
@property (nonatomic, strong, readwrite) id item;

/**
 *  内部有初始化
 *
 */
+ (instancetype)item __attribute__((objc_requires_super));

@end

//
//  HDTableViewDefines.h
//  Pods
//
//  Created by Dailingchi on 15/7/15.
//
//

#ifndef Pods_HDTableViewDefines_h
#define Pods_HDTableViewDefines_h

#pragma mark
#pragma mark Config

typedef void (^HDTableViewManagerCellConfigure)(id cell, id itemData, NSIndexPath *indexPath);

#pragma mark
#pragma mark HDTableViewSectionProtocol
/**
 *  用于配置TableView Section相关属性
 */
@protocol HDTableViewSectionProtocol <NSObject>

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

@end

#pragma mark
#pragma mark HDTableViewItemProtocol

/**
 *  用于配置TableView Cell相关属性
 */
@protocol HDTableViewItemProtocol <NSObject>

@required

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
 *  创建cell时reusableIdentifier
 */
@property (nonatomic, copy, readwrite) NSString *cellIdentifier;

/**
 *  cell数据模型
 */
@property (nonatomic, strong, readwrite) id item;

@end

#pragma mark
#pragma mark HDTableViewManagerDelegate

@protocol HDTableViewManagerDelegate <UITableViewDataSource, UITableViewDelegate>

@optional

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#endif

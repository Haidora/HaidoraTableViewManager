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

+ (instancetype)item;

@end

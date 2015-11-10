//
//  UITableViewCell+HDTableViewManager.h
//  Pods
//
//  Created by Dailingchi on 15/7/15.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UITableViewCell (HDTableViewManager)

@property (nonatomic, weak, readwrite) UITableView *hd_tableView;
@property (nonatomic, strong, readwrite) NSIndexPath *hd_indexPath;
@property (nonatomic, weak, readwrite) id hd_item;

#pragma mark
#pragma mark Cell Config

/**
 *  配置cell复用identifier
 *
 */
+ (NSString *)hd_cellIdentifier;

/**
 *  配置nib的名称
 *
 */
+ (NSString *)hd_nibName;

/**
 *  创建nib
 *
 */
+ (UINib *)hd_nib;

/**
 *  配置cell高度
 *
 */
+ (CGFloat)hd_cellHeight;

/**
 *  根据内容配置高度
 *
 */
+ (CGFloat)hd_cellHeightForTableView:(UITableView *)tableView content:(id)content;

/**
 *  配置cell内容
 *
 */
- (void)hd_setContent:(id)content;

#pragma mark
#pragma mark Load Cell

/**
 *  根据style创建cell
 */
+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                          indexPath:(NSIndexPath *)indexPath;

/**
 *  根据style和创建cell
 */
+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler;

/**
 *  根据nib创建cell
 */
+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                          indexPath:(NSIndexPath *)indexPath;

/**
 *  根据nib和identifier创建cell
 */
+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item;

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler;

#pragma mark
#pragma mark Life Cycle

/**
 *  cell创建以后调用
 */
- (void)hd_cellDidLoad __attribute__((objc_requires_super));

/**
 *  cell显示时调用
 */
- (void)hd_cellWillAppear __attribute__((objc_requires_super));

@end

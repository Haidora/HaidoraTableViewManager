//
//  UITableViewCell+HDTableViewManager.h
//  HaidoraTableViewManager
//
//  Created by DaiLingchi on 15-1-20.
//  Copyright (c) 2015年 Haidora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UITableViewCell (HDTableViewManager)

// for tableView
@property (nonatomic, weak, readonly) UITableView *tableView_HDTableViewManager;

// for tableViewCell
@property (nonatomic, strong, readonly) NSIndexPath *indexPath_HDTableViewManager;

#pragma mark
#pragma mark Cell Config

/**
 *  cellIdentifier default is class name.
 *
 *  @return cellIdentifier
 */
+ (NSString *)cellIdentifier_HDTableViewManager;

/**
 *  nibName is cellIdentifier
 *
 *  @return nibName
 */
+ (NSString *)nibName_HDTableViewManager;

/**
 *  load nib with nibName
 *
 *  @return nib
 */
+ (UINib *)nib_HDTableViewManager;

/**
 *  Cell Height
 *
 *  @return default 44.
 */
+ (CGFloat)cellHeight_HDTableViewManager;

+ (CGFloat)cellHeightForTableView_HDTableViewManager:(UITableView *)tableView content:(id)content;

#pragma mark
#pragma mark Load Cell

/**
 *  load uitableviewcell with UITableViewCellStyle
 *
 *  @param tableView
 *  @param style
 *  @param indexPath
 *
 *  @return
 */
+ (id)cellForTableView_HDTableViewManager:(UITableView *)tableView
                                withStyle:(UITableViewCellStyle)style
                                indexPath:(NSIndexPath *)indexPath;

/**
 *  load uitableviewcell from nib
 *
 *  @param tableView
 *  @param nib
 *  @param indexPath
 *
 *  @return
 */
+ (id)cellForTableView_HDTableViewManager:(UITableView *)tableView
                                  fromNib:(UINib *)nib
                                indexPath:(NSIndexPath *)indexPath;

/**
 *  load uitableviewcell from nib with cellIdentifier
 *
 *  @param tableView
 *  @param nib
 *  @param cellIdentifier
 *  @param indexPath
 *
 *  @return
 */
+ (id)cellForTableView_HDTableViewManager:(UITableView *)tableView
                                  fromNib:(UINib *)nib
                       withCellIdentifier:(NSString *)cellIdentifier
                                indexPath:(NSIndexPath *)indexPath;

/**
 *  Set cell content
 *
 *  @param content
 */
- (void)setContent_HDTableViewManager:(id)content;

#pragma mark
#pragma mark cell Life cycles

/**
 *  when cell load
 */
- (void)cellDidLoad_HDTableViewManager __attribute__((objc_requires_super));

/**
 *  when cell will appear
 */
- (void)cellWillAppear_HDTableViewManager __attribute__((objc_requires_super));

@end

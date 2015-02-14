//
//  HDTableViewManagerProtocol.h
//  HaidoraTableViewManager
//
//  Created by DaiLingchi on 15-2-6.
//  Copyright (c) 2015年 Haidora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark
#pragma mark Config

typedef void (^HDTableViewManagerCellConfigureBlock)(id cell, id item, NSIndexPath *index);

#pragma mark
#pragma mark HDTableViewSectionProtocol

@protocol HDTableViewSectionProtocol <NSObject>

@optional

/**
 *  The tableView section header title
 *
 */
- (NSString *)titleForHeader;

/**
 *  The tableView section header Height
 *
 */
- (CGFloat)heightForHeader;

/**
 *  The tableView section header view
 *
 */
- (UIView *)viewForHeader;

/**
 *  The tableView section footer title
 *
 */
- (NSString *)titleForFooter;

/**
 *  The tableView section footer Height
 *
 */
- (CGFloat)heightForFooter;

/**
 *  The tableView section footer view
 *
 */
- (UIView *)viewForFooter;

/**
 *  The tableView section rows
 *
 */
- (NSMutableArray *)sectionRows;

@end

#pragma mark
#pragma mark HDTableViewManagerDataSource

@protocol HDTableViewManagerDataSource <NSObject>

@optional

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
     forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark
#pragma mark HDTableViewManagerDelegate

@protocol HDTableViewManagerDelegate <UITableViewDelegate>

@end

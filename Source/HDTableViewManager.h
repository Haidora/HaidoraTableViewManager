//
//  HDTableViewManager.h
//  HaidoraTableViewManager
//
//  Created by DaiLingchi on 15-1-20.
//  Copyright (c) 2015年 Haidora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^HDTableViewManagerCellConfigureBlock)(id cell, id item, NSIndexPath *index);

@protocol HDTableViewManagerDataSource;
@protocol HDTableViewManagerDelegate;

@interface HDTableViewManager : NSObject <UITableViewDataSource, UITableViewDelegate>

/**
 *  cellDatas struct need @[@[],@[]]
 */
@property (nonatomic, strong) NSMutableArray *cellDatas;
@property (nonatomic, copy) HDTableViewManagerCellConfigureBlock cellConfigureBlock;
@property (nonatomic, weak) id<HDTableViewManagerDataSource> dataSource;
@property (nonatomic, weak) id<HDTableViewManagerDelegate> delegate;

/**
 *  Alloc HDTableViewManager
 *
 *  @param items
 *  @param cellClass
 *  @param cellConfigureBlock
 *
 *  @return
 */
- (id)initWithItems:(NSMutableArray *)items
             cellClass:(Class)cellClass
    configureCellBlock:(HDTableViewManagerCellConfigureBlock)cellConfigureBlock;

/**
 *  Get item data at indexPath
 *
 *  @param indexPath
 *
 *  @return
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark
#pragma mark HDTableViewManagerDataSource

@protocol HDTableViewManagerDataSource <UITableViewDataSource>

@end

#pragma mark
#pragma mark HDTableViewManagerDelegate

@protocol HDTableViewManagerDelegate <UITableViewDelegate>

@end

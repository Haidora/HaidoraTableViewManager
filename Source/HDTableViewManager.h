//
//  HDTableViewManager.h
//  HaidoraTableViewManager
//
//  Created by DaiLingchi on 15-1-20.
//  Copyright (c) 2015年 Haidora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HDTableViewManagerProtocol.h"

/**
 *  HDTableViewManager
 */

@interface HDTableViewManager : NSObject <UITableViewDataSource, UITableViewDelegate>

/**
 *  sectionDatas is a array containt object with HDTableViewSectionProtocol
 */
@property (nonatomic, strong) NSMutableArray *sectionDatas;

// config
@property (nonatomic, strong) Class cellClass;
@property (nonatomic, copy) HDTableViewManagerCellConfigureBlock cellConfigureBlock;
@property (nonatomic, weak) id<HDTableViewManagerDataSource> dataSource;
@property (nonatomic, weak) id<HDTableViewManagerDelegate> delegate;

/**
 *  Alloc HDTableViewManager
 *
 *  @param sections
 *  @param cellClass
 *  @param cellConfigureBlock
 *
 *  @return
 */
- (id)initWithSections:(NSMutableArray *)sections
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

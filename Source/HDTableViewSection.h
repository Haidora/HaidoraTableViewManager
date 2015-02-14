//
//  HDTableViewSection.h
//  HaidoraTableViewManager
//
//  Created by DaiLingchi on 15-2-6.
//  Copyright (c) 2015年 Haidora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDTableViewManagerProtocol.h"

#pragma mark
#pragma mark HDTableViewSection

/**
 *  The Data for TableViewSection
 */
@interface HDTableViewSection : NSObject <HDTableViewSectionProtocol>

// header
@property (nonatomic, strong) NSString *titleForHeader;
@property (nonatomic, assign) CGFloat heightForHeader;
@property (nonatomic, strong) UIView *viewForHeader;
// footer
@property (nonatomic, strong) NSString *titleForFooter;
@property (nonatomic, assign) CGFloat heightForFooter;
@property (nonatomic, strong) UIView *viewForFooter;

// lazy auto alloc
@property (nonatomic, strong) NSMutableArray *sectionRows;

@end

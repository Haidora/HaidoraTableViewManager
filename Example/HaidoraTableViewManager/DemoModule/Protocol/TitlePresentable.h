//
//  TitlePresentable.h
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 16/2/23.
//  Copyright © 2016年 mrdaios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TitlePresentable <NSObject>

@property (nonatomic, strong, readwrite) NSString *title;

@optional
@property (nonatomic, strong, readonly) UIColor *titleColor;
@property (nonatomic, strong, readonly) UIFont *titleFont;
@property (nonatomic, copy, readonly) void (^updateTitleLabel)(UILabel *label);

@end

/**
 *  默认实现,optional
 */
@interface NSObject (TitlePresentable) <TitlePresentable>

@end

//
//  UITableViewCell+HDTableViewManager.m
//  HaidoraTableViewManager
//
//  Created by DaiLingchi on 15-1-20.
//  Copyright (c) 2015年 Haidora. All rights reserved.
//

#import "UITableViewCell+HDTableViewManager.h"
#import <objc/runtime.h>

static const NSString *kTableView_HDTableViewManager = @"kTableView_HDTableViewManager";
static const NSString *kIndexPath_HDTableViewManager = @"kIndexPath_HDTableViewManager";

@interface UITableViewCell ()

@property (nonatomic, weak, readwrite) UITableView *tableView_HDTableViewManager;
@property (nonatomic, strong, readwrite) NSIndexPath *indexPath_HDTableViewManager;

@end

@implementation UITableViewCell (HDTableViewManager)

@dynamic tableView_HDTableViewManager;
@dynamic indexPath_HDTableViewManager;

#pragma mark
#pragma mark Getter/Setter

- (void)setTableView_HDTableViewManager:(UITableView *)tableView_HDTableViewManager
{
    objc_setAssociatedObject(self, &kTableView_HDTableViewManager, tableView_HDTableViewManager,
                             OBJC_ASSOCIATION_ASSIGN);
}

- (UITableView *)tableView_HDTableViewManager
{
    return objc_getAssociatedObject(self, &kTableView_HDTableViewManager);
}

- (void)setIndexPath_HDTableViewManager:(NSIndexPath *)indexPath_HDTableViewManager
{
    objc_setAssociatedObject(self, &kIndexPath_HDTableViewManager, indexPath_HDTableViewManager,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)indexPath_HDTableViewManager
{
    return objc_getAssociatedObject(self, &kIndexPath_HDTableViewManager);
}

#pragma mark
#pragma mark Cell Config

+ (NSString *)cellIdentifier_HDTableViewManager
{
    return NSStringFromClass([self class]);
}

+ (NSString *)nibName_HDTableViewManager
{
    return [self cellIdentifier_HDTableViewManager];
}

+ (UINib *)nib_HDTableViewManager
{
    NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
    return [UINib nibWithNibName:[self nibName_HDTableViewManager] bundle:classBundle];
}

+ (CGFloat)cellHeight_HDTableViewManager
{
    return 44.0;
}

+ (CGFloat)cellHeightForTableView_HDTableViewManager:(UITableView *)tableView content:(id)content
{
    return [self cellHeight_HDTableViewManager];
}

+ (id)cellForTableView_HDTableViewManager:(UITableView *)tableView
                                withStyle:(UITableViewCellStyle)style
                                indexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = nil;
    if (style == UITableViewCellStyleDefault)
        cellID = @"HABTableViewCellStyleDefault";
    else if (style == UITableViewCellStyleValue1)
        cellID = @"HABTableViewCellStyleValue1";
    else if (style == UITableViewCellStyleValue2)
        cellID = @"HABTableViewCellStyleValue2";
    else if (style == UITableViewCellStyleSubtitle)
        cellID = @"HABTableViewCellStyleSubtitle";
    else
        cellID = @"HABTableViewCellSystem";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[[self class] alloc] initWithStyle:style reuseIdentifier:cellID];
        [cell cellDidLoad_HDTableViewManager];
    }
    cell.tableView_HDTableViewManager = tableView;
    cell.indexPath_HDTableViewManager = indexPath;
    [cell cellWillAppear_HDTableViewManager];

    return cell;
}

+ (id)cellForTableView_HDTableViewManager:(UITableView *)tableView
                                  fromNib:(UINib *)nib
                                indexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [self cellIdentifier_HDTableViewManager];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        NSArray *nibObjects = [nib instantiateWithOwner:nil options:nil];
        cell = [nibObjects firstObject];
        [cell cellDidLoad_HDTableViewManager];
    }
    cell.tableView_HDTableViewManager = tableView;
    cell.indexPath_HDTableViewManager = indexPath;
    [cell cellWillAppear_HDTableViewManager];

    return cell;
}

+ (id)cellForTableView_HDTableViewManager:(UITableView *)tableView
                                  fromNib:(UINib *)nib
                       withCellIdentifier:(NSString *)cellIdentifier
                                indexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nibObjects = [nib instantiateWithOwner:nil options:nil];
        for (UITableViewCell *nibCell in nibObjects)
        {
            if ([nibCell.reuseIdentifier isEqualToString:cellIdentifier])
            {
                cell = nibCell;
                [cell cellDidLoad_HDTableViewManager];
                break;
            }
        }
    }
    cell.tableView_HDTableViewManager = tableView;
    cell.indexPath_HDTableViewManager = indexPath;
    [cell cellWillAppear_HDTableViewManager];

    return cell;
}

- (void)setContent_HDTableViewManager:(id)content
{
}

#pragma mark
#pragma mark cell Life cycles

- (void)cellDidLoad_HDTableViewManager
{
}

- (void)cellWillAppear_HDTableViewManager
{
}

@end

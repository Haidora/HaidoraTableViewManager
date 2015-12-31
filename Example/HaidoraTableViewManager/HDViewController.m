//
//  HDViewController.m
//  HaidoraTableViewManager
//
//  Created by mrdaios on 07/15/2015.
//  Copyright (c) 2015 mrdaios. All rights reserved.
//

#import "HDViewController.h"
#import <HaidoraTableViewManager.h>
#import "HDViewControllerCell.h"
#import "HDModel.h"

@interface HDViewController ()

@property (nonatomic, strong) HDTableViewManager *manager;
@property (nonatomic, strong) HDTableViewSection *baseSection;
@property (nonatomic, strong) HDTableViewSection *systemCellSection;
@property (nonatomic, strong) HDTableViewSection *customCellSection;
@property (nonatomic, strong) HDTableViewSection *tapCellSection;

@end

@implementation HDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //组织结构
    [self.manager.sections addObject:self.baseSection];
    [self.manager.sections addObject:self.systemCellSection];
    [self.manager.sections addObject:self.customCellSection];
    [self.manager.sections addObject:self.tapCellSection];

    // datasource
    self.tableView.dataSource = _manager;
    self.tableView.delegate = _manager;
}

- (HDTableViewManager *)manager
{
    if (nil == _manager)
    {
        _manager = [HDTableViewManager manager];
    }
    return _manager;
}

- (HDTableViewSection *)baseSection
{
    if (nil == _baseSection)
    {
        _baseSection = [HDTableViewSection section];
        _baseSection.titleForHeader = @"基础使用";
        //配置cell的显示
        _baseSection.cellConfigure =
            ^(UITableViewCell *cell, NSString *itemData, NSIndexPath *indexPath) {
              cell.textLabel.text = itemData;
            };
        //配置cell显示的数据
        for (NSInteger index = 0; index < 3; index++)
        {
            [_baseSection.items addObject:[NSString stringWithFormat:@"cell-%@", @(index)]];
        }
    }
    return _baseSection;
}

- (HDTableViewSection *)systemCellSection
{
    if (nil == _systemCellSection)
    {
        _systemCellSection = [HDTableViewSection section];
        _systemCellSection.titleForHeader = @"自带cell";
        HDTableViewItem *item;

        item = [HDTableViewItem item];
        item.cellStyle = UITableViewCellStyleDefault;
        item.cellConfigure = ^(UITableViewCell *cell, id itemData, NSIndexPath *indexPath) {
          cell.textLabel.text = @"UITableViewCellStyleDefault";
          cell.accessoryType = UITableViewCellAccessoryCheckmark;
        };
        [_systemCellSection.items addObject:item];

        item = [HDTableViewItem item];
        item.cellStyle = UITableViewCellStyleSubtitle;
        item.cellConfigure = ^(UITableViewCell *cell, id itemData, NSIndexPath *indexPath) {
          cell.textLabel.text = @"UITableViewCellStyleSubtitle";
          cell.detailTextLabel.text = @"UITableViewCellStyleSubtitle-detailTextLabel";
        };
        [_systemCellSection.items addObject:item];

        item = [HDTableViewItem item];
        item.cellStyle = UITableViewCellStyleValue1;
        item.cellConfigure = ^(UITableViewCell *cell, id itemData, NSIndexPath *indexPath) {
          cell.textLabel.text = @"UITableViewCellStyleValue1";
          cell.detailTextLabel.text = @"detail";
        };
        [_systemCellSection.items addObject:item];

        item = [HDTableViewItem item];
        item.cellStyle = UITableViewCellStyleValue2;
        item.cellConfigure = ^(UITableViewCell *cell, id itemData, NSIndexPath *indexPath) {
          cell.textLabel.text = @"style";
          cell.detailTextLabel.text = @"UITableViewCellStyleValue2";
        };
        [_systemCellSection.items addObject:item];
    }
    return _systemCellSection;
}

- (HDTableViewSection *)customCellSection
{
    if (nil == _customCellSection)
    {
        _customCellSection = [HDTableViewSection section];
        _customCellSection.titleForHeader = @"自定义cell";
        HDTableViewItem *item;

        item = [HDTableViewItem item];
        item.cellClass = [HDViewControllerCell class];
        [_customCellSection.items addObject:item];

        item = [HDTableViewItem item];
        item.cellClass = [HDViewControllerCell1 class];
        [_customCellSection.items addObject:item];

        item = [HDTableViewItem item];
        item.cellClass = [HDViewControllerCell1 class];
        item.cellDidLoadHandler =
            ^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
              cell.selectionStyle = UITableViewCellSelectionStyleNone;
            };
        item.cellHeight = 80;
        HDModel *model;
        model = [[HDModel alloc] init];
        model.userInfo = @"custom Height 80.";
        item.item = model;
        [_customCellSection.items addObject:item];
    }
    return _customCellSection;
}

- (HDTableViewSection *)tapCellSection
{
    if (nil == _tapCellSection)
    {
        _tapCellSection = [HDTableViewSection section];
        _tapCellSection.titleForHeader = @"点击事件";
        _tapCellSection.tableViewDidSelectRowAtIndexPath =
            ^(UITableView *tableView, NSIndexPath *indexPath) {
              [[[UIAlertView alloc] initWithTitle:@"Title"
                                          message:@"Tap Section"
                                         delegate:nil
                                cancelButtonTitle:@"ok"
                                otherButtonTitles:nil] show];
            };
        _tapCellSection.cellConfigure =
            ^(UITableViewCell *cell, id itemData, NSIndexPath *indexPath) {
              cell.textLabel.text = itemData;
            };
        [_tapCellSection.items addObject:@"Cell"];

        HDTableViewItem *item;

        item = [HDTableViewItem item];
        item.cellConfigure = ^(UITableViewCell *cell, id itemData, NSIndexPath *indexPath) {
          cell.textLabel.text = @"Tap Cell";
        };
        item.tableViewDidSelectRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
          [[[UIAlertView alloc] initWithTitle:@"Title"
                                      message:@"Tap Cell"
                                     delegate:nil
                            cancelButtonTitle:@"ok"
                            otherButtonTitles:nil] show];
        };

        [_tapCellSection.items addObject:item];
    }
    return _tapCellSection;
}

@end

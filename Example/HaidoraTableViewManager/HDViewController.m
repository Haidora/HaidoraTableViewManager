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

@interface HDViewController () <HDTableViewManagerDelegate>

@property (nonatomic, strong) HDTableViewManager *manager;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
    _manager = [HDTableViewManager manager];
    _manager.delegate = self;
    //普通cell
    HDTableViewManagerCellConfigure cellConSection =
        ^(UITableViewCell *cell, id itemData, NSIndexPath *indexPath) {
          cell.textLabel.text =
              [NSString stringWithFormat:@"index-%@-%@", @(indexPath.section), @(indexPath.row)];
          cell.detailTextLabel.text =
              [NSString stringWithFormat:@"subIndex-%@-%@", @(indexPath.section), @(indexPath.row)];
        };

    HDTableViewSection *section1 = [HDTableViewSection section];
    section1.titleForHeader = @"系统自带的cell";
    HDTableViewItem *item1 = [HDTableViewItem item];
    item1.cellConfigure = cellConSection;
    [section1.items addObject:item1];
    HDTableViewItem *item2 = [HDTableViewItem item];
    item2.cellStyle = UITableViewCellStyleValue1;
    item2.cellConfigure = cellConSection;
    [section1.items addObject:item2];
    HDTableViewItem *item3 = [HDTableViewItem item];
    item3.cellStyle = UITableViewCellStyleValue2;
    item3.cellConfigure = cellConSection;
    [section1.items addObject:item3];
    HDTableViewItem *item4 = [HDTableViewItem item];
    item4.cellStyle = UITableViewCellStyleSubtitle;
    item4.cellConfigure = cellConSection;
    [section1.items addObject:item4];
    [_manager.sections addObject:section1];
    //自定义cell
    HDTableViewSection *section2 = [HDTableViewSection section];
    section2.titleForHeader = @"自定义cell";
    HDTableViewItem *item21 = [HDTableViewItem item];
    item21.cellClass = [HDViewControllerCell1 class];
    [section2.items addObject:item21];
    HDTableViewItem *item22 = [HDTableViewItem item];
    item22.cellClass = [HDViewControllerCell class];
    [section2.items addObject:item22];
    HDTableViewItem *item23 = [HDTableViewItem item];
    item23.cellClass = [HDViewControllerCell class];
    item23.cellIdentifier = @"HDViewControllerCell1";
    [section2.items addObject:item23];

    [_manager.sections addObject:section2];
    // datasource
    self.tableView.dataSource = _manager;
    self.tableView.delegate = _manager;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (CGFloat)tableView:(UITableView *)tableView
    estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return HDTableViewManagerAutomaticDimension;
    }
    else
    {
        return 100;
    }
}

@end

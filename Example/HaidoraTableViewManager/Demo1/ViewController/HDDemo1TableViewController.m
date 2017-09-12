//
//  HDDemo1TableViewController.m
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 16/3/8.
//  Copyright © 2016年 mrdaios. All rights reserved.
//

#import "HDDemo1Model.h"
#import "HDDemo1TableViewCell.h"
#import "HDDemo1TableViewController.h"

@interface HDDemo1TableViewController ()

@property (nonatomic, strong) HDTableViewManager *manager;
@property (nonatomic, strong) HDTableViewSection *section;

@end

@implementation HDDemo1TableViewController

#pragma mark
#pragma mark Init

#pragma mark
#pragma mark Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareForData];
    [self prepareForView];
    [self prepareForAction];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark
#pragma mark PrepareConfig

- (void)prepareForData
{
    //根据需求配置相关属性
    self.manager.cellClass = [HDDemo1TableViewCell class];

    [self.manager.sections addObject:self.section];
}

- (void)prepareForView
{
    // TableView的配置交给manager,ViewController减少dataSource和delegate
    self.tableView.dataSource = self.manager;
    self.tableView.delegate = self.manager;
}

- (void)prepareForAction
{
    UIBarButtonItem *barItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                      target:self
                                                      action:@selector(demo:)];
    self.navigationItem.rightBarButtonItem = barItem;
}

#pragma mark
#pragma mark XXXDelegate

#pragma mark
#pragma mark Event Response

- (void)demo:(id)sender
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

      sleep(1);
      //模拟网络,数据库等取数据
      [weakSelf.section.items removeAllObjects];
      for (NSInteger index = 0; index < 10; index++)
      {
          HDDemo1Model *model =
              [[HDDemo1Model alloc] initWith:[NSString stringWithFormat:@"info1-%@", @(index)]
                                       info2:[NSString stringWithFormat:@"info2-%@", @(index)]];
          //添加数据
          [weakSelf.section.items addObject:model];
      }
      dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
      });
    });
}

#pragma mark
#pragma mark Getter/Setter

- (HDTableViewManager *)manager
{
    if (nil == _manager)
    {
        _manager = [HDTableViewManager manager];
    }
    return _manager;
}

- (HDTableViewSection *)section
{
    if (nil == _section)
    {
        _section = [[HDTableViewSection alloc] init];
    }
    return _section;
}

@end

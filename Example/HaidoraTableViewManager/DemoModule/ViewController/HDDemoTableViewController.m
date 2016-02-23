//
//  HDDemoTableViewController.m
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 16/2/23.
//  Copyright © 2016年 mrdaios. All rights reserved.
//

#import "HDDemoTableViewCell.h"
#import "HDDemoTableViewCell.h"
#import "HDDemoTableViewController.h"
#import "HDDemoViewModel.h"

@interface HDDemoTableViewController ()

@property (nonatomic, strong) HDTableViewManager *manager;

@end

@implementation HDDemoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [HDTableViewManager manager];
    _manager.cellClass = [HDDemoTableViewCell class];
    HDTableViewSection *section = [HDTableViewSection section];

    void (^tapBlock)(NSString *title) = ^(NSString *title) {
      NSLog(@"tap Action-%@", title);
    };

    HDDemoViewModel *viewModel = [[HDDemoViewModel alloc] init];
    viewModel.title = @"123";
    viewModel.tapAction = tapBlock;
    [section.items addObject:viewModel];

    viewModel = [[HDDemoViewModel alloc] init];
    viewModel.title = @"456";
    viewModel.tapAction = tapBlock;
    [section.items addObject:viewModel];

    viewModel = [[HDDemoViewModel alloc] init];
    viewModel.title = @"789";
    viewModel.tapAction = tapBlock;
    [section.items addObject:viewModel];

    [_manager.sections addObject:section];

    self.tableView.dataSource = _manager;
    self.tableView.delegate = _manager;
}

@end

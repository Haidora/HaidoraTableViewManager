//
//  ViewController.m
//  HaidoraTableViewManager
//
//  Created by DaiLingchi on 15-1-20.
//  Copyright (c) 2015年 Haidora. All rights reserved.
//

#import "ViewController.h"
#import "HaidoraTableViewManager.h"
#import "TestTableViewCell.h"

@interface ViewController () <HDTableViewManagerDataSource, HDTableViewManagerDelegate>

@property (nonatomic, strong) HDTableViewManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *datas = [NSMutableArray new];
    HDTableViewSection *section = [[HDTableViewSection alloc] init];
    for (int i = 0; i < 1000; i++)
    {
        [section.sectionRows addObject:@(i)];
    }
    _manager = [[HDTableViewManager alloc] initWithSections:datas
                                                  cellClass:[TestTableViewCell class]
                                         configureCellBlock:^(id cell, id item, NSIndexPath *index){

                                         }];
    _manager.dataSource = self;
    _manager.delegate = self;

    self.tableView.dataSource = _manager;
    self.tableView.delegate = _manager;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

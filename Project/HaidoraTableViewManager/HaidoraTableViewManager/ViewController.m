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

@interface ViewController ()

@property (nonatomic, strong) HDTableViewManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *datas = [NSMutableArray new];
    NSMutableArray *cells = [NSMutableArray new];
    [datas addObject:cells];
    for (int i = 0; i < 1000; i++)
    {
        [cells addObject:@(i)];
    }

    _manager = [[HDTableViewManager alloc] initWithItems:datas
                                               cellClass:[TestTableViewCell class]
                                      configureCellBlock:^(id cell, id item, NSIndexPath *index){

                                      }];
    self.tableView.dataSource = _manager;
    self.tableView.delegate = _manager;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

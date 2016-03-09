// HDDemo2TableViewController.m
//
// Copyright (c) 2016年 mrdaios
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "HDDemo2Item1.h"
#import "HDDemo2Item2.h"
#import "HDDemo2TableViewController.h"

@interface HDDemo2TableViewController ()

@property (nonatomic, strong) HDTableViewManager *manager;
@property (nonatomic, strong) HDTableViewSection *section;

@end

@implementation HDDemo2TableViewController

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

    [self.tableView reloadData];
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
    [self.manager.sections addObject:self.section];

    HDDemo2Item1 *item1 = [HDDemo2Item1 item];
    [self.section.items addObject:item1];

    HDDemo2Item2 *item2 = [HDDemo2Item2 item];
    [self.section.items addObject:item2];
}

- (void)prepareForView
{
    // TableView的配置交给manager,ViewController减少dataSource和delegate
    self.tableView.dataSource = self.manager;
    self.tableView.delegate = self.manager;
}

- (void)prepareForAction
{
}

#pragma mark
#pragma mark XXXDelegate

#pragma mark
#pragma mark Event Response

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

//
//  HDTableViewItem.m
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

#import "HDTableViewItem.h"

@implementation HDTableViewItem

#pragma mark
#pragma mark HDTableViewConfigureProtocol

@synthesize tableViewDidSelectRowAtIndexPath = _tableViewDidSelectRowAtIndexPath;
@synthesize tableViewWillDisplayCellAtIndexPath = _tableViewWillDisplayCellAtIndexPath;

#pragma mark
#pragma mark HDTableViewCellConfigureProtocol

@synthesize cellClass = _cellClass;
@synthesize cellIdentifier = _cellIdentifier;
@synthesize cellStyle = _cellStyle;
@synthesize cellHeight = _cellHeight;
@synthesize cellConfigure = _cellConfigure;
@synthesize cellDidLoadHandler = _cellDidLoadHandler;
@synthesize cellWillAppearHandler = _cellWillAppearHandler;

#pragma mark
#pragma mark HDTableViewItemProtocol

@synthesize itemData = _itemData;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.cellStyle = UITableViewCellStyleUnknow;
        self.cellHeight = HDTableViewManagerCellHeightUnknow;
    }
    return self;
}

+ (instancetype)item
{
    HDTableViewItem *item = [[self alloc] init];
    return item;
}

@end


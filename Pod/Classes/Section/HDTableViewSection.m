//
//  HDTableViewSection.m
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

#import "HDTableViewSection.h"

@implementation HDTableViewSection

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
#pragma mark HDTableViewSectionProtocol

@synthesize titleForHeader = _titleForHeader;
@synthesize heightForHeader = _heightForHeader;
@synthesize viewForHeader = _viewForHeader;
@synthesize titleForFooter = _titleForFooter;
@synthesize heightForFooter = _heightForFooter;
@synthesize viewForFooter = _viewForFooter;

@synthesize items = _items;

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

+ (instancetype)section
{
    HDTableViewSection *section = [[self alloc] init];
    return section;
}

#pragma mark
#pragma mark Getter

- (NSMutableArray *)items
{
    if (nil == _items)
    {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end

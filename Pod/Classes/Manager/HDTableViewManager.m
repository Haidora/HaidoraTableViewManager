//
//  HDTableViewManager.m
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

#import "HDTableViewManager+HDPrivateUtils.h"
#import "HDTableViewManager.h"
#import "UITableViewCell+HDTableViewManager.h"

const CGFloat HDTableViewManagerAutomaticDimension = -7;
const UITableViewCellStyle UITableViewCellStyleUnknow = -7;
const CGFloat HDTableViewManagerCellHeightUnknow = NSIntegerMax;

@interface HDTableViewManager ()

@property (nonatomic, strong, readwrite) NSMutableArray *sections;

@end

@implementation HDTableViewManager

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
#pragma mark Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.cellHeight = HDTableViewManagerCellHeightUnknow;
        self.cellStyle = UITableViewCellStyleUnknow;
    }
    return self;
}

- (instancetype)initWithSections:(NSMutableArray *)sections
                       cellClass:(Class)cellClass
                       cellStyle:(UITableViewCellStyle)cellStyle
              configureCellBlock:(void (^)(id cell, id itemData,
                                           NSIndexPath *indexPath))cellConfigure
                        delegate:(id<HDTableViewManagerDelegate>)delegate
{
    self = [self init];
    if (self)
    {
        //        self.sections = sections;
        self.cellClass = cellClass;
        self.cellStyle = cellStyle;
        self.cellConfigure = [cellConfigure copy];
        self.delegate = delegate;
    }
    return self;
}

+ (instancetype)manager
{
    HDTableViewManager *manager =
        [[HDTableViewManager alloc] initWithSections:[NSMutableArray array]
                                           cellClass:[UITableViewCell class]
                                           cellStyle:UITableViewCellStyleDefault
                                  configureCellBlock:^(id cell, id item, NSIndexPath *indexPath) {
                                    UITableViewCell *mCell = cell;
                                    [mCell hd_setContent:item];
                                  }
                                            delegate:nil];
    return manager;
}

#pragma mark
#pragma mark Forwarding to DataSource / Delegate
//@link http://blog.scottlogic.com/2012/11/19/a-multicast-delegate-pattern-for-ios-controls.html

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector])
    {
        return YES;
    }
    else if (((id)self != (id)self.dataSource) && [self.dataSource respondsToSelector:aSelector])
    {
        return YES;
    }
    else if (((id)self != (id)self.delegate) && [self.delegate respondsToSelector:aSelector])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (((id)self != (id)self.dataSource) && [self.dataSource respondsToSelector:aSelector])
    {
        return self.dataSource;
    }
    else if (((id)self != (id)self.delegate) && [self.delegate respondsToSelector:aSelector])
    {
        return self.delegate;
    }
    else
    {
        // never call
        return nil;
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    // never call
    NSLog(@"%@_doesNotRecognizeSelector:%@", NSStringFromClass([self class]),
          NSStringFromSelector(aSelector));
}

#pragma mark
#pragma mark Getter

- (NSMutableArray *)sections
{
    if (nil == _sections)
    {
        _sections = [[NSMutableArray alloc] init];
    }
    return _sections;
}

@end

@implementation HDTableViewManager (HDTableViewManager_Utils)

#pragma mark
#pragma mark public method

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<HDTableViewSectionProtocol> *tableViewSection = _sections[indexPath.section];
    NSMutableArray *rows = tableViewSection.items;
    return rows[indexPath.row];
}

- (id)itemDataAtIndexPath:(NSIndexPath *)indexPath
{
    return [self loadItemDataWith:indexPath];
}

- (CGFloat)hd_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;

    UITableViewCell *cell = [self loadCellWith:tableView indexPath:indexPath];
    void (^cellConfigure)(id cell, id itemData, NSIndexPath *indexPath) =
        [self loadCellConfigureWith:indexPath];
    if (cellConfigure)
    {
        cellConfigure(cell, [self loadItemDataWith:indexPath], indexPath);
    }
    [cell layoutIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    // fix contenView height +1
    // for uilabel you need set preferredMaxLayoutWidth
    height = size.height + 1;
    return height;
}
@end

#pragma mark HDTableViewManager-HDTableViewSection
@implementation HDTableViewManager (HDTableViewSection)

- (void)addSection:(HDTableViewSection *)section
{
    [self.sections addObject:section];
}

- (void)addSectionsFromArray:(NSArray *)array
{
    [self.sections addObjectsFromArray:array];
}

- (void)insertSection:(HDTableViewSection *)section atIndex:(NSUInteger)index
{
    [self.sections insertObject:section atIndex:index];
}

- (void)insertSections:(NSArray *)sections atIndexes:(NSIndexSet *)indexes
{
    [self.sections insertObjects:sections atIndexes:indexes];
}

- (void)removeSection:(HDTableViewSection *)section
{
    [self.sections removeObject:section];
}

- (void)removeAllSections
{
    [self.sections removeAllObjects];
}

- (void)removeSectionIdenticalTo:(HDTableViewSection *)section inRange:(NSRange)range
{
    [self.sections removeObjectIdenticalTo:section inRange:range];
}

- (void)removeSectionIdenticalTo:(HDTableViewSection *)section
{
    [self.sections removeObjectIdenticalTo:section];
}

- (void)removeSectionsInArray:(NSArray *)otherArray
{
    [self.sections removeObjectsInArray:otherArray];
}

- (void)removeSectionsInRange:(NSRange)range
{
    [self.sections removeObjectsInRange:range];
}

- (void)removeSection:(HDTableViewSection *)section inRange:(NSRange)range
{
    [self.sections removeObject:section inRange:range];
}

- (void)removeLastSection
{
    [self.sections removeLastObject];
}

- (void)removeSectionAtIndex:(NSUInteger)index
{
    [self.sections removeObjectAtIndex:index];
}

- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes
{
    [self.sections removeObjectsAtIndexes:indexes];
}

- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(HDTableViewSection *)section
{
    [self.sections replaceObjectAtIndex:index withObject:section];
}

- (void)replaceSectionsWithSectionsFromArray:(NSArray *)otherArray
{
    [self removeAllSections];
    [self addSectionsFromArray:otherArray];
}

- (void)replaceSectionsAtIndexes:(NSIndexSet *)indexes withSections:(NSArray *)sections
{
    [self.sections replaceObjectsAtIndexes:indexes withObjects:sections];
}

- (void)replaceSectionsInRange:(NSRange)range
         withSectionsFromArray:(NSArray *)otherArray
                         range:(NSRange)otherRange
{
    [self.sections replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
}

- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray
{
    [self.sections replaceObjectsInRange:range withObjectsFromArray:otherArray];
}

- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2
{
    [self.sections exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (void)sortSectionsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context
{
    [self.sections sortUsingFunction:compare context:context];
}

- (void)sortSectionsUsingSelector:(SEL)comparator
{
    [self.sections sortUsingSelector:comparator];
}

@end
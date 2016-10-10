//
//  HDTableViewManager.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "HDTableViewCellConfigureProtocol.h"
#import "HDTableViewConfigureProtocol.h"
#import "HDTableViewItemProtocol.h"
#import "HDTableViewSectionProtocol.h"

@protocol HDTableViewManagerDataSource;
@protocol HDTableViewManagerDelegate;
@class HDTableViewSection;

/**
 如果HDTableViewManagerDelegate中cell高度返回为HDTableViewManagerAutomaticDimension,则根据配置加载UITableViewCell(配置优先级item>section>manager>cell)的高度

 @see -tableView:heightForRowAtIndexPath:
 @see -tableView:estimatedHeightForRowAtIndexPath:
 */
extern const CGFloat HDTableViewManagerAutomaticDimension;

extern const UITableViewCellStyle UITableViewCellStyleUnknow;
extern const CGFloat HDTableViewManagerCellHeightUnknow;

#pragma mark
#pragma mark HDTableViewManager
/**
 `HDTableViewManager`用于接管`UITableView`的DataSource和Delegate
 */
@interface HDTableViewManager
    : NSObject <HDTableViewConfigureProtocol, HDTableViewCellConfigureProtocol>

/**
 The array of sections. See HDTableViewSectionProtocol reference for details.
 */
@property (nonatomic, strong, readonly) NSMutableArray *sections;

/**
 *  <UITableViewDataSource>,默认为nil
 */
@property (nonatomic, weak, readwrite) id<HDTableViewManagerDataSource> dataSource;

/**
 *  <UITableViewDelegate>,默认为nil
 */
@property (nonatomic, weak, readwrite) id<HDTableViewManagerDelegate> delegate;


+ (instancetype)manager;
- (instancetype)initWithSections:(NSMutableArray *)sections
                       cellClass:(Class)cellClass
                       cellStyle:(UITableViewCellStyle)cellStyle
              configureCellBlock:(void (^)(id cell, id itemData,
                                           NSIndexPath *indexPath))cellConfigure
                        delegate:(id<HDTableViewManagerDelegate>)delegate;

@end

#pragma mark HDTableViewManager-HDTableViewSection
@interface HDTableViewManager (HDTableViewSection)

/**
 Inserts a given section at the end of the table view.

 @param section The section to add to the end of the table view. This value must not be `nil`.
 */
- (void)addSection:(HDTableViewSection *)section;

/**
 Adds the sections contained in another given sections array to the end of the table view.

 @param array An array of sections to add to the end of the table view.
 */
- (void)addSectionsFromArray:(NSArray *)array;

/**
 Inserts a given section into the table view at a given index.

 @param section The section to add to the table view. This value must not be nil.
 @param index The index in the sections array at which to insert section. This value must not be
 greater than the count of sections in the table view.
 */
- (void)insertSection:(HDTableViewSection *)section atIndex:(NSUInteger)index;

/**
 Inserts the sections in the provided array into the table view at the specified indexes.

 @param sections An array of sections to insert into the table view.
 @param indexes The indexes at which the sections in sections should be inserted. The count of
 locations in indexes must equal the count of sections.
 */
- (void)insertSections:(NSArray *)sections atIndexes:(NSIndexSet *)indexes;

/**
 Removes all occurrences in the table view of a given section.

 @param section The section to remove from the table view.
 */
- (void)removeSection:(HDTableViewSection *)section;

/**
 Empties the table view of all its sections.

 */
- (void)removeAllSections;

/**
 Removes all occurrences of section within the specified range in the table view.

 @param section The section to remove from the table view within range.
 @param range The range in the table view from which to remove section.
 */
- (void)removeSectionIdenticalTo:(HDTableViewSection *)section inRange:(NSRange)range;

/**
 Removes all occurrences of a given section in the sections array.

 @param section The section to remove from the sections array.
 */
- (void)removeSectionIdenticalTo:(HDTableViewSection *)section;

/**
 Removes from the table view the sections in another given array.

 @param otherArray An array containing the sections to be removed from the table view.
 */
- (void)removeSectionsInArray:(NSArray *)otherArray;

/**
 Removes from the table view each of the sections within a given range.

 @param range The range of the sections to remove from the table view.
 */
- (void)removeSectionsInRange:(NSRange)range;

/**
 Removes all occurrences within a specified range in the table view of a given section.

 @param section The section to remove from the table view.
 @param range The range from which to remove section.
 */
- (void)removeSection:(HDTableViewSection *)section inRange:(NSRange)range;

/**
 Removes the section with the highest-valued index in the table view.

 */
- (void)removeLastSection;

/**
 Removes the section at index.

 @param index The index from which to remove the section in the table view. The value must not
 exceed the bounds of the table view sections.
 */
- (void)removeSectionAtIndex:(NSUInteger)index;

/**
 Removes the sections at the specified indexes from the table view.

 @param indexes The indexes of the sections to remove from the table view. The locations specified
 by indexes must lie within the bounds of the table view sections.
 */
- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes;

/**
 Replaces the section at index with `section`.

 @param index The index of the section to be replaced. This value must not exceed the bounds of the
 table view sections.
 @param section The section with which to replace the section at index `index` in the sections
 array. This value must not be `nil`.
 */
- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(HDTableViewSection *)section;

/**
 Replaces the sections in the table view with all of the sections from a given array.

 @param otherArray The array of sections from which to select replacements for the sections.
 */
- (void)replaceSectionsWithSectionsFromArray:(NSArray *)otherArray;

/**
 Replaces the sections in the table view at specified locations specified with the sections from a
 given array.

 @param indexes The indexes of the sections to be replaced.
 @param sections The sections with which to replace the sections in the table view at the indexes
 specified by indexes. The count of locations in indexes must equal the count of sections.
 */
- (void)replaceSectionsAtIndexes:(NSIndexSet *)indexes withSections:(NSArray *)sections;

/**
 Replaces the sections in the table view by one given range with the sections in another array
 specified by another range.

 @param range The range of sections to replace in (or remove from) the table view.
 @param otherArray The array of sections from which to select replacements for the sections in
 range.
 @param otherRange The range of sections to select from otherArray as replacements for the sections
 in range.
 */
- (void)replaceSectionsInRange:(NSRange)range
         withSectionsFromArray:(NSArray *)otherArray
                         range:(NSRange)otherRange;

/**
 Replaces the sections in the table view specified by a given range with all of the sections from a
 given array.

 @param range The range of sections to replace in (or remove from) the table view.
 @param otherArray The array of sections from which to select replacements for the sections in
 range.
 */
- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray;

/**
 Exchanges the sections in the table view at given indices.

 @param idx1 The index of the section with which to replace the section at index idx2.
 @param idx2 The index of the section with which to replace the section at index idx1.
 */
- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2;

/**
 Sorts the sections in ascending order as defined by the comparison function compare.

 @param compare The comparison function to use to compare two sections at a time.
 @param context The context argument to pass to the compare function.
 */
- (void)sortSectionsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;

/**
 Sorts the sections in ascending order, as determined by the comparison method specified by a given
 selector.

 @param comparator A selector that specifies the comparison method to use to compare sections in the
 table view.
 */
- (void)sortSectionsUsingSelector:(SEL)comparator;

@end

#pragma mark HDTableViewManager-UITableViewDataSource
@interface HDTableViewManager (UITableViewDataSource) <UITableViewDataSource>

@end
#pragma mark HDTableViewManager- UITableViewDelegate
@interface HDTableViewManager (UITableViewDelegate) <UITableViewDelegate>

@end

@interface HDTableViewManager (HDTableViewManager_Utils)

/**
 *  获取指定indexPath的item
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  获取指定indexPath的数据模型
 *
 */
- (id)itemDataAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  计算Cell高度,如果计算高度不对,请配合使用https://github.com/forkingdog/UITableView-FDTemplateLayoutCell
 */
- (CGFloat)hd_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark
#pragma mark HDTableViewManagerDelegate

@protocol HDTableViewManagerDataSource <UITableViewDataSource>

@end

@protocol HDTableViewManagerDelegate <UITableViewDelegate>

@end

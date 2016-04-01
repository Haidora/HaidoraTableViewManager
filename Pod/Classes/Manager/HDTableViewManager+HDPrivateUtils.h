//
//  HDTableViewManager+HDPrivateUtils.h
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

#import "HaidoraTableViewManager.h"
/**
 *  加载Cell的相关配置(优先级可查看源码)
 */
@interface HDTableViewManager (HDPrivateUtils)

@property (nonatomic, strong) NSMutableDictionary *nibCache;

#pragma mark
#pragma mark HDTableViewConfigureProtocol

- (void (^)(UITableView *tableView, NSIndexPath *indexPath))
loadTableViewDidSelectRowAtIndexPathWith:(NSIndexPath *)indexPath;

- (Class)loadClassWith:(NSIndexPath *)indexPath;

- (NSString *)loadCellIdentifierWith:(NSIndexPath *)indexPath;

- (UITableViewCellStyle)loadCellStyleWith:(NSIndexPath *)indexPath;

- (CGFloat)loadCellHeightWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (void (^)(id cell, id itemData,
            NSIndexPath *indexPath))loadCellConfigureWith:(NSIndexPath *)indexPath;

- (void (^)(UITableView *tableView, id cell,
            NSIndexPath *indexPath))loadCellDidLoadHandlerWith:(NSIndexPath *)indexPath;

- (void (^)(UITableView *tableView, id cell,
            NSIndexPath *indexPath))loadCellWillAppearHandlerWith:(NSIndexPath *)indexPath;

- (UITableViewCell *)loadCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (UINib *)loadNibCacheWith:(Class)cellClass;

- (id)loadItemDataWith:(NSIndexPath *)indexPath;

@end

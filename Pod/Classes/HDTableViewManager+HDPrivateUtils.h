//
//  HDTableViewManager+HDPrivateUtils.h
//  Pods
//
//  Created by Dailingchi on 15/12/30.
//
//

#import "HaidoraTableViewManager.h"

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

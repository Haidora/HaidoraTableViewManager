//
//  UITableViewCell+HDTableViewManager.m
//  Pods
//
//  Created by Dailingchi on 15/7/15.
//
//

#import "UITableViewCell+HDTableViewManager.h"
#import <objc/runtime.h>

static char *kHD_tableView = "kHD_tableView";
static char *kHD_indexPath = "kHD_indexPath";
static char *kHD_item = "kHD_item";

@interface UITableViewCell (HDTableViewManagerPrivate)

@property (nonatomic, weak, readwrite) UITableView *hd_tableView;
@property (nonatomic, strong, readwrite) NSIndexPath *hd_indexPath;

@end

@implementation UITableViewCell (HDTableViewManager)

@dynamic hd_tableView;
@dynamic hd_indexPath;
@dynamic hd_item;

#pragma mark
#pragma mark Cell Config

+ (NSString *)hd_cellIdentifier
{
    return NSStringFromClass([self class]);
}

+ (NSString *)hd_nibName
{
    return [self hd_cellIdentifier];
}

+ (UINib *)hd_nib
{
    NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
    if ([classBundle pathForResource:[self hd_nibName] ofType:@"nib"])
    {
        return [UINib nibWithNibName:[self hd_nibName] bundle:classBundle];
    }
    else
    {
        return nil;
    }
}

+ (CGFloat)hd_cellHeight
{
    return 44;
}

+ (CGFloat)hd_cellHeightForTableView:(UITableView *)tableView content:(id)content
{
    return [self hd_cellHeight];
}

- (void)hd_setContent:(id)content
{
}

#pragma mark
#pragma mark Load Cell

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                          indexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"HABTableViewCellSystem";
    switch (style)
    {
    case UITableViewCellStyleDefault:
        cellIdentifier = @"HABTableViewCellStyleDefault";
        break;
    case UITableViewCellStyleValue1:
        cellIdentifier = @"HABTableViewCellStyleValue1";
        break;
    case UITableViewCellStyleValue2:
        cellIdentifier = @"HABTableViewCellStyleValue2";
        break;
    case UITableViewCellStyleSubtitle:
        cellIdentifier = @"HABTableViewCellStyleSubtitle";
        break;
    default:
        break;
    }
    return [self hd_cellForTableView:tableView
                           withStyle:style
                          identifier:cellIdentifier
                           indexPath:indexPath];
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
{
    return [self hd_cellForTableView:tableView
                           withStyle:style
                          identifier:identifier
                           indexPath:indexPath
                                item:nil];
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
{
    return [self hd_cellForTableView:tableView
                           withStyle:style
                          identifier:identifier
                           indexPath:indexPath
                                item:item
                      didLoadHandler:nil
                   willAppearHandler:nil];
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                          withStyle:(UITableViewCellStyle)style
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[self class] alloc] initWithStyle:style reuseIdentifier:identifier];
        [cell hd_cellDidLoad];
        if (didLoadHandler)
        {
            didLoadHandler(tableView, cell, indexPath);
        }
    }
    cell.hd_tableView = tableView;
    cell.hd_indexPath = indexPath;
    cell.hd_item = item;
    [cell hd_cellWillAppear];
    if (willAppearHandler)
    {
        willAppearHandler(tableView, cell, indexPath);
    }
    return cell;
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                          indexPath:(NSIndexPath *)indexPath
{
    return [self hd_cellForTableView:tableView
                             fromNib:nib
                          identifier:[self hd_cellIdentifier]
                           indexPath:indexPath];
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
{
    return [self hd_cellForTableView:tableView
                             fromNib:nib
                          identifier:identifier
                           indexPath:indexPath
                                item:nil];
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
{
    return [self hd_cellForTableView:tableView
                             fromNib:nib
                          identifier:identifier
                           indexPath:indexPath
                                item:item
                      didLoadHandler:nil
                   willAppearHandler:nil];
}

+ (instancetype)hd_cellForTableView:(UITableView *)tableView
                            fromNib:(UINib *)nib
                         identifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                               item:(id)item
                     didLoadHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))didLoadHandler
                  willAppearHandler:(void (^)(UITableView *tableView, id cell,
                                              NSIndexPath *indexPath))willAppearHandler
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        NSArray *nibObjects = [nib instantiateWithOwner:nil options:nil];
        for (UITableViewCell *nibCell in nibObjects)
        {
            if ([nibCell.reuseIdentifier isEqualToString:identifier])
            {
                cell = nibCell;
                [cell hd_cellDidLoad];
                if (didLoadHandler)
                {
                    didLoadHandler(tableView, cell, indexPath);
                }
                break;
            }
        }
    }
    cell.hd_tableView = tableView;
    cell.hd_indexPath = indexPath;
    cell.hd_item = item;
    [cell hd_cellWillAppear];
    if (willAppearHandler)
    {
        willAppearHandler(tableView, cell, indexPath);
    }
    return cell;
}

#pragma mark
#pragma mark Life cycle

- (void)hd_cellDidLoad
{
}

- (void)hd_cellWillAppear
{
}

#pragma mark
#pragma mark Setter/Getter

- (void)setHd_tableView:(UITableView *)hd_tableView
{
    objc_setAssociatedObject(self, &kHD_tableView, hd_tableView, OBJC_ASSOCIATION_ASSIGN);
}

- (UITableView *)hd_tableView
{
    return objc_getAssociatedObject(self, &kHD_tableView);
}

- (void)setHd_indexPath:(NSIndexPath *)hd_indexPath
{
    objc_setAssociatedObject(self, &kHD_indexPath, hd_indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)hd_indexPath
{
    return objc_getAssociatedObject(self, &kHD_indexPath);
}

- (void)setHd_item:(id)hd_item
{
    objc_setAssociatedObject(self, &kHD_item, hd_item, OBJC_ASSOCIATION_ASSIGN);
}

- (id)hd_item
{
    return objc_getAssociatedObject(self, &kHD_item);
}

@end

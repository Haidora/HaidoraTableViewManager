//
//  HDViewControllerCell.h
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 15/7/16.
//  Copyright (c) 2015年 mrdaios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HDCellModelProtcol <NSObject>

@property (nonatomic, strong, readonly) NSString *title;

@end

@interface HDViewControllerCell : UITableViewCell

@end

@interface HDViewControllerCell1 : UITableViewCell

@end
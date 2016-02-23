//
//  ButtonPresentable.h
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 16/2/23.
//  Copyright © 2016年 mrdaios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ButtonPresentable <NSObject>

@property (nonatomic, copy) void (^tapAction)(NSString *title);

@end

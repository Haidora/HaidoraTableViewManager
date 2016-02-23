//
//  HDDemoViewModel.h
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 16/2/23.
//  Copyright © 2016年 mrdaios. All rights reserved.
//

#import "ButtonPresentable.h"
#import "TitlePresentable.h"

@interface HDDemoViewModel : NSObject <TitlePresentable, ButtonPresentable>

@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, copy) void (^tapAction)(NSString *title);

@end

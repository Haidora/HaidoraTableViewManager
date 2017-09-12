//
//  HDDemo1Model.m
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 16/3/8.
//  Copyright © 2016年 mrdaios. All rights reserved.
//

#import "HDDemo1Model.h"

@implementation HDDemo1Model

- (id)initWith:(NSString *)info1 info2:(NSString *)info2
{
    self = [self init];
    if (self)
    {
        self.info1 = info1;
        self.info2 = info2;
    }
    return self;
}

@end

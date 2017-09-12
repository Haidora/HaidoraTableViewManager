//
//  HDDemo1TableViewCell.m
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 16/3/8.
//  Copyright © 2016年 mrdaios. All rights reserved.
//

#import "HDDemo1Model.h"
#import "HDDemo1TableViewCell.h"

@interface HDDemo1TableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation HDDemo1TableViewCell

- (void)hd_setContent:(HDDemo1Model *)content
{
//    _label1.text = content.info1;
//    _label2.text = content.info2;
}

@end

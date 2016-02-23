//
//  HDDemoTableViewCell.m
//  HaidoraTableViewManager
//
//  Created by Dailingchi on 16/2/23.
//  Copyright © 2016年 mrdaios. All rights reserved.
//

#import "ButtonPresentable.h"
#import "HDDemoTableViewCell.h"
#import "TitlePresentable.h"

@interface HDDemoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, weak) id<TitlePresentable, ButtonPresentable> content;

@end

@implementation HDDemoTableViewCell

- (void)hd_setContent:(id<TitlePresentable, ButtonPresentable>)content
{
    self.content = content;
    [content updateTitleLabel](_label);
}

- (IBAction)tapAction:(id)sender
{
    [self.content tapAction]([self.content title]);
}

@end

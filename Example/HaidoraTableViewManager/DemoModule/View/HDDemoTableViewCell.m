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


/**
 *  配置cell内容
 *  content推荐用Protcol抽象Cell需要显示的数据,对Model做一次抽象,这样以后就做到了一个Cell对应多个Model。
 *      1.Protocol的声明暂时写在Cell的头部.
 */
- (void)hd_setContent:(id<TitlePresentable, ButtonPresentable>)content
{
    self.content = content;
    if ([self.content conformsToProtocol:@protocol(TitlePresentable)] &&
        [self.content conformsToProtocol:@protocol(ButtonPresentable)])
    {
        [content updateTitleLabel](_label);
    }
}

- (IBAction)tapAction:(id)sender
{
    [self.content tapAction]([self.content title]);
}

@end

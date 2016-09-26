//
//  UITableViewCell+HDTableViewManager.m
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

#import "UITableViewCell+HDTableViewManager.h"

@implementation UITableViewCell (HDTableViewManager)

#pragma mark
#pragma mark Cell Config

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

#pragma mark Cell Config nib

+ (NSString *)hd_nibName
{
    return NSStringFromClass([self class]);
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
#pragma mark
#pragma mark Life cycle

- (void)hd_cellWillDisplay
{
}

@end

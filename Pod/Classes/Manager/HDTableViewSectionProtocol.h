//
//  HDTableViewSectionProtocol.h
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

#import <Foundation/Foundation.h>

#import "HDTableViewCellConfigureProtocol.h"
#import "HDTableViewConfigureProtocol.h"

#pragma mark
#pragma mark HDTableViewSectionProtocol
/**
 *  用于配置TableViewSection相关属性
 */
@protocol
    HDTableViewSectionProtocol <HDTableViewConfigureProtocol, HDTableViewCellConfigureProtocol>

@required
#pragma mark Cells
/**
 Section下面的cell数据(实现HDTableViewItemProtocol协议的数据或者普通的数据)
 */
@property (nonatomic, strong, readonly) NSMutableArray *items;

@optional
#pragma mark Header
/**
 指定Section的Header title(如果实现了titleForHeaderInSection则无效)

 @see -tableView:titleForHeaderInSection:
 */
@property (nonatomic, copy, readwrite) NSString *titleForHeader;

/**
 指定Section的Header的高度(viewForHeader不为空时有效)(如果实现了heightForHeaderInSection则无效)

 @see -tableView:heightForHeaderInSection:
 */
@property (nonatomic, assign, readwrite) CGFloat heightForHeader;

/**
 指定Section的Header view(如果实现了viewForHeaderInSection则无效)

 @see -tableView:viewForHeaderInSection:
 */
@property (nonatomic, strong, readwrite) UIView *viewForHeader;

#pragma mark Footer
/**
 指定Section的Footer title如果实现了titleForFooterInSection则无效)

 @see -tableView:titleForFooterInSection:
 */
@property (nonatomic, copy, readwrite) NSString *titleForFooter;

/**
 指定Section的Footer的高度(viewForFooter不为空时有效)如果实现了heightForFooterInSection则无效)

 @see -tableView:heightForFooterInSection:
 */
@property (nonatomic, assign, readwrite) CGFloat heightForFooter;

/**
 指定Section的Footer view如果实现了viewForFooterInSection则无效)

 @see -tableView:viewForFooterInSection:
 */
@property (nonatomic, strong, readwrite) UIView *viewForFooter;

@end

//
//  HDTableViewConfigureProtocol.h
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

#pragma mark
#pragma mark HDTableViewConfigureProtocol

/**
 *  HDTableViewManager配置UITableView相关属性
 */
@protocol HDTableViewConfigureProtocol <NSObject>

@optional
/**
 TableView的tableView:heightForRowAtIndexPath:回调配置加载顺序
 
 item>section>manager
 
 @see tableView:heightForRowAtIndexPath:
 */
@property (nonatomic, copy, readwrite) CGFloat (^tableViewHeightForRowAtIndexPath)
(UITableView *tableView, NSIndexPath *indexPath);

/**
 TableView的tableView:didSelectRowAtIndexPath:回调配置加载顺序

 item>section>manager

 @see tableView:didSelectRowAtIndexPath:
 */
@property (nonatomic, copy, readwrite) void (^tableViewDidSelectRowAtIndexPath)
    (UITableView *tableView, NSIndexPath *indexPath);

/**
 TableView的tableView:willDisplayCell:forRowAtIndexPath:回调配置加载顺序

 item>section>manager

 @see tableView:willDisplayCell:forRowAtIndexPath::
 */
@property (nonatomic, copy, readwrite) void (^tableViewWillDisplayCellAtIndexPath)
    (UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);

@end

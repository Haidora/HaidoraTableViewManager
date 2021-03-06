# HaidoraTableViewManager

[![Version](https://img.shields.io/cocoapods/v/HaidoraTableViewManager.svg?style=flat)](http://cocoapods.org/pods/HaidoraTableViewManager)
[![License](https://img.shields.io/cocoapods/l/HaidoraTableViewManager.svg?style=flat)](http://cocoapods.org/pods/HaidoraTableViewManager)
[![Platform](https://img.shields.io/cocoapods/p/HaidoraTableViewManager.svg?style=flat)](http://cocoapods.org/pods/HaidoraTableViewManager)

UITableViewDataSource UITableViewDelegate的封装.

###UITableView

```
//1.创建TableView和数据
UITableView *tableView = [[UITableView alloc]init];
tableView.dataSource = self;
tableView.delegate = self;
NSArray *datas = @[@"1",@"2",@"3"];

//2.实现相关协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = ...;
    cell.textLabel.text = datas[indexPath.row];
    return cell;
}

```

###HaidoraTableViewManager

Objc

```
//1.创建TableView和数据
UITableView *tableView = [[UITableView alloc]init];
NSArray *datas = @[@"1",@"2",@"3"];

//2.创建manager
HDTableViewManager *manager = [HDTableViewManager manager];
//配置cell，类似tableView:numberOfRowsInSection:
manager.cellConfigure = ^(UITableViewCell *cell, id itemData, NSIndexPath *indexPath) {
          cell.textLabel.text =
              [NSString stringWithFormat:@"index-%@-%@", @(indexPath.section), @(indexPath.row)];
          cell.detailTextLabel.text =
              [NSString stringWithFormat:@"subIndex-%@-%@", @(indexPath.section), @(indexPath.row)];
        };
HDTableViewSection *section = [HDTableViewSection section];
[section.items addObjectsFromArray:datas];

tableView.dataSource = manager;
tableView.delegate = manager;

```
Swift

```
//Swift和OC版本差异性不大,唯一需要注意的是,OC中通过NSStringFromClass([self class])获取类名然后去加载相关的nib。由于在Swift中获取类名会不一样,所以需要手动指定资源
class ViewControllerCell: UITableViewCell {
    override class func hd_nibName() -> String {
    //nib文件的名称
        return "ViewControllerCell"
    }
    
    override class func hd_cellIdentifier() -> String {
    //cell复用id
    return "ViewControllerCell"
    }
}
```

## Installation

HaidoraTableViewManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "HaidoraTableViewManager"
```
* iOS 7.0+
* Objc/Swift

## Inspired by these projects:
* [RetableViewManager](https://github.com/romaonthego/RETableViewManager)

## Author

mrdaios, mrdaios@gmail.com

## License

HaidoraTableViewManager is available under the MIT license. See the LICENSE file for more info.

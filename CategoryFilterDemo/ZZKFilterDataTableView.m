//
//  QZFilterDataTableView.m
//  QZConditionFilterViewDemo
//
//  Created by Lee on 16/9/21.
//  Copyright © 2016年 ZZK. All rights reserved.
//

#import "ZZKFilterDataTableView.h"
#import "ZZKSortCell.h"
#import "UIView+Extension.h"

@interface ZZKFilterDataTableView()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _selectedIndex;   // 记录被选中的cell
}
@end

@implementation ZZKFilterDataTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _dateArray = [[NSMutableArray alloc] init];
        self.backgroundColor=[UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ZZKSortCell class] forCellReuseIdentifier:@"cell"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

//选中数据放入数据源并传递给上层
-(void)bindChoseArraySort:(NSArray *)sortAry
{
    [self.sortArr removeAllObjects];
    [self.sortArr addObjectsFromArray:sortAry];
    if (self.sortDelegate && [self.sortDelegate respondsToSelector:@selector(choseSort:)]) {
        [self.sortDelegate choseSort:self.sortArr];
    }
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dateArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ZZKSortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [ZZKSortCell sortCell];
    }
    if (indexPath.row == _selectedIndex) {
        cell.markView.hidden = NO;
        cell.textLabel.textColor = UIColorFromRGB(0x00a0ff);
    }else{
        cell.markView.hidden = YES;
        cell.textLabel.textColor = UIColorFromRGB(0x333333);
    }
    cell.textLabel.text = _dateArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 重置所有cell颜色
    for (NSInteger i = 0; i < _dateArray.count; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        ZZKSortCell *cell = [tableView cellForRowAtIndexPath:path];
        cell.markView.hidden = YES;
        cell.textLabel.textColor = UIColorFromRGB(0x333333);
    }
    //显示图片
    ZZKSortCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.markView.hidden = NO;
    cell.textLabel.textColor = UIColorFromRGB(0x00a0ff);
    NSArray *arr = @[_dateArray[indexPath.row]];  //取出数据
    [self bindChoseArraySort:arr];
    _selectedIndex = indexPath.row;
}

-(void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.height=0;
    }];
}

#pragma mark - lazyLoad
//sortArr选中的数据
- (NSMutableArray*)sortArr
{
    if (!_sortArr) {
        _sortArr = [NSMutableArray array];
    }
    return _sortArr;
}

#pragma mark - 设置默认显示
- (void)setSelectedCell:(NSString *)selectedCell
{
    // 显示View之前会给sortView.selectedCell赋值 继而处理选中cell reload
    _selectedCell = selectedCell;
    // 处理默认显示
    
    _selectedIndex = [self.dateArray indexOfObject:_selectedCell];
    if ([_selectedCell isEqualToString:@""] || _selectedCell == nil){
        _selectedIndex = 0;
    }
    
    [self reloadData];
}

- (void)setDateArray:(NSArray *)dateArray
{
    _dateArray = dateArray;
    self.height = MIN(_dateArray.count, 8) * 44;
}

@end

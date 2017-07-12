//
//  ViewController.m
//  CategoryFilterDemo
//
//  Created by lee on 2017/7/13.
//  Copyright © 2017年 zzk. All rights reserved.
//

#import "ViewController.h"
#import "ViewController.h"
#import "ZZKConditionFilterView.h"
#import "UIView+Extension.h"

@interface ViewController ()
{
    // *存储* 网络请求url中的筛选项 数据来源：View中_dataSource1或者一开始手动的初值
    NSArray *_selectedDataSource1Ary;
    NSArray *_selectedDataSource2Ary;
    
    ZZKConditionFilterView *_conditionFilterView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"筛选";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置初次加载显示的默认数据
    _selectedDataSource1Ary = @[@"全部分类"];
    _selectedDataSource2Ary = @[@"智能排序"];
    
    
    _conditionFilterView = [ZZKConditionFilterView conditionFilterViewWithFilterBlock:^(BOOL isFilter, NSArray *dataSource1Ary, NSArray *dataSource2Ary) {
        if (isFilter) {
            //网络加载请求 存储请求参数
            _selectedDataSource1Ary = dataSource1Ary;
            _selectedDataSource2Ary = dataSource2Ary;
        }else{
            // 不是筛选，全部赋初值（在这个工程其实是没用的，因为tableView是选中后必选的，即一旦选中就没有空的情况，但是如果可以清空筛选条件的时候就有必要 *重新* reset data）
            _selectedDataSource1Ary = @[@"全部分类"];
            _selectedDataSource2Ary = @[@"智能排序"];
        }
        [self startRequest];
    }];
    _conditionFilterView.y += 64;
    // 传入数据源，对应三个tableView顺序
    _conditionFilterView.dataAry1 = @[];
    _conditionFilterView.dataAry2 = @[@"全部",@"离我最近",@"赚钱最多"];
    
    // 初次设置默认显示数据，内部会调用block 进行第一次数据加载
    [_conditionFilterView bindChoseArrayDataSource1:_selectedDataSource1Ary DataSource2:_selectedDataSource2Ary];
    
    [self.view addSubview:_conditionFilterView];
}

- (void)startRequest
{
    
    NSString *source1 = [NSString stringWithFormat:@"%@",_selectedDataSource1Ary.firstObject];
    NSString *source2 = [NSString stringWithFormat:@"%@",_selectedDataSource2Ary.firstObject];
    
    NSDictionary *dic = [_conditionFilterView keyValueDic];
    // 可以用字符串在dic换成对应英文key
    
    NSLog(@"\n第一个条件:%@\n  第二个条件:%@\n  ",source1,source2);
    
}

@end

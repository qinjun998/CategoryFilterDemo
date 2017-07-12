//
//  QZConditionFilterView.h
//  QZConditionFilterViewDemo
//
//  Created by Lee on 16/9/21.
//  Copyright © 2016年 ZZK. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 三个tableView cell 类型的筛选*/

typedef void (^FilterBlock)(BOOL isFilter, NSArray *dataSource1Ary,NSArray *dataSource2Ary);

@interface ZZKConditionFilterView : UIView

/** 原本用于内部设置createSubView时设置显示默认数据，现在通过外部设置默认，如果有需要可以在内部设置，暂时为无用变量*/
@property (nonatomic,strong) NSArray *sortTitleAry;
/** 对应三个下拉tableView的数据源*/
@property (nonatomic,strong) NSArray *dataAry1;
@property (nonatomic,strong) NSArray *dataAry2;

/**是否展示*/
@property (nonatomic,readonly,assign)BOOL isShow;

/** 创建实例 with block*/
+(instancetype)conditionFilterViewWithFilterBlock:(FilterBlock)filterBlock;

/** 刷新标题字*/
-(void)bindChoseArrayDataSource1:(NSArray *)dataSource1Ary DataSource2:(NSArray *)dataSource2Ary ;

/** 外部手动筛选加载*/
-(void)choseSortFromOutsideWithFirstSort:(NSArray *)firstAry WithSecondSort:(NSArray *)secondAry WithThirdSort:(NSArray *)thirdAry;

/** 消失*/
-(void)dismiss;

/** 网络请求key value从这取*/
@property (nonatomic,strong) NSDictionary *keyValueDic;

@end


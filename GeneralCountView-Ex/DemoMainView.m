//
//  DemoMainView.m
//  GeneralCountView
//
//  Created by xush on 2018/7/31.
//  Copyright © 2018年 Xush. All rights reserved.
//

#import "DemoMainView.h"
#define UIColorFromHex(hexValue)        [UIColor colorWithRed:(((hexValue & 0xFF0000) >> 16))/255.0f green:(((hexValue & 0xFF00) >> 8))/255.0f blue:((hexValue & 0xFF))/255.0f alpha:1.0f]

@interface DemoMainView () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation DemoMainView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromHex(0xf1f1f1);
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.countV];
    [self addSubview:self.tableV];
}

#pragma mark - lazyload

- (CountUnitView *)countV {
    if (!_countV) {
        _countV = [[CountUnitView alloc] initWithFrame:(CGRectMake(0, 0, 100, 25))];
        _countV.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 50);
    }
    return _countV;
}

- (UITableView *)tableV {
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:(CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, self.frame.size.height-100)) style:(UITableViewStylePlain)];
        _tableV.dataSource = self;
        _tableV.delegate = self;
    }
    return _tableV;
}

- (NSArray *)cellDataArr {
    if (!_cellDataArr) {
        _cellDataArr = @[@"maxNum", @"view size"];
    }
    return _cellDataArr;
}

#pragma mark - action



#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *HomeMapIdentifier = @"mainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeMapIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:HomeMapIdentifier];
    }
    return cell;
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 5))];
    view.backgroundColor = UIColorFromHex(0xf1f1f1);
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - other



#pragma mark - data set


@end

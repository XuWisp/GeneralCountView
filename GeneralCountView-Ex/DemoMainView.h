//
//  DemoMainView.h
//  GeneralCountView
//
//  Created by xush on 2018/7/31.
//  Copyright © 2018年 Xush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountUnitView.h"

@interface DemoMainView : UIView

@property (nonatomic, strong) CountUnitView *countV;
@property (nonatomic, strong) UITableView *tableV;

@property (nonatomic, copy) NSArray cellDataArr;

@end

//
//  CountUnitView.m
//  CASAMIEL
//
//  Created by 徐沙洪 on 2018/3/29.
//  Copyright © 2018年 徐沙洪. All rights reserved.
//

#import "CountUnitView.h"

@implementation CountUnitView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.maxNum = 1000;
        [self addSubview:self.subBtn];
        [self addSubview:self.addBtn];
        [self addSubview:self.amountTF];
    }
    return self;
}

#pragma mark - Lazy load

- (UIButton *)subBtn {
    if (!_subBtn) {
        _subBtn = [UIButton commonBtnWithType:(UIButtonTypeCustom)
                                        Frame:(CGRectMake(0, 0, self.height, self.height))
                                         text:@""
                                       TColor:nil
                                         font:nil
                                         NImg:[UIImage imageNamed:@"icon_minus_nomal"]
                                         SImg:[UIImage imageNamed:@"icon_minus_disable"]
                                        BNImg:nil
                                        BSImg:nil
                                        color:nil];
        _subBtn.tag = 1991; // 可短时间重复点击 Runtime
        [_subBtn addTarget:self action:@selector(subBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _subBtn;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton commonBtnWithType:(UIButtonTypeCustom)
                                        Frame:(CGRectMake(self.width-self.height, 0, self.height, self.height))
                                         text:@""
                                       TColor:nil
                                         font:nil
                                         NImg:[UIImage imageNamed:@"add_icon_nomal"]
                                         SImg:[UIImage imageNamed:@"add_icon_disable"]
                                        BNImg:nil
                                        BSImg:nil
                                        color:nil];
        _addBtn.tag = 1991; // 可短时间重复点击 Runtime
        [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}

- (UITextField *)amountTF {
    if (!_amountTF) {
        _amountTF = [[UITextField alloc] initWithFrame:(CGRectMake(self.height, 0, self.width-self.height*2, self.height))];
        _amountTF.font = [UIFont systemFontOfSize:kImgFit(40)];
        _amountTF.text = @"1";
        _amountTF.textAlignment = NSTextAlignmentCenter; //水平居中
        _amountTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
        _amountTF.keyboardType = UIKeyboardTypeNumberPad;
        [_amountTF addTarget:self action:@selector(changeTFValue) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _amountTF;
}

#pragma mark - active

- (void)addBtnClick {
    self.subBtn.selected = NO;
    self.subBtn.userInteractionEnabled = YES;
    NSUInteger index = [self.amountTF.text integerValue];
    index++;
    [self checkValueForBtnWith:index];
}

- (void)subBtnClick {
    self.addBtn.selected = NO;
    self.addBtn.userInteractionEnabled = YES;
    NSUInteger index = [self.amountTF.text integerValue];
    index--;
    [self checkValueForBtnWith:index];
}

- (void)changeTFValue {
    self.subBtn.userInteractionEnabled = YES;
    self.subBtn.selected = NO;
    self.addBtn.userInteractionEnabled = YES;
    self.addBtn.selected = NO;
    if (![NSString isNumberString:self.amountTF.text]) {
        NSLog(@"请输入数字");
        self.amountTF.text = @"1";
        self.subBtn.userInteractionEnabled = NO;
        self.subBtn.selected = YES;
        return;
    }
    NSUInteger index = [self.amountTF.text integerValue];
    [self checkValueForBtnWith:index];
}

- (void)checkValueForBtnWith:(NSUInteger)index {
    if (index <= 1) {
        self.subBtn.selected = YES;
        self.subBtn.userInteractionEnabled = NO;
        index = 1;
    }else {
        self.subBtn.selected = NO;
        self.subBtn.userInteractionEnabled = YES;
    }
    if (index >= self.maxNum) {
        self.addBtn.selected = YES;
        self.addBtn.userInteractionEnabled = NO;
        index = self.maxNum;
    }else {
        self.addBtn.selected = NO;
        self.addBtn.userInteractionEnabled = YES;
    }
    self.amountTF.text = [NSString stringWithFormat:@"%lu", (unsigned long)index];
}

- (void)setAllBtnUserInteractionEnabled:(BOOL)isEnable {
    self.addBtn.selected = !isEnable;
    self.addBtn.userInteractionEnabled = isEnable;
    self.subBtn.selected = !isEnable;
    self.subBtn.userInteractionEnabled = isEnable;
    if (isEnable) {
        self.amountTF.text = @"1";
    }
}

@end

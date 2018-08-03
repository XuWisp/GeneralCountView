//
//  CountUnitView.m
//  CASAMIEL
//
//  Created by 徐沙洪 on 2018/3/29.
//  Copyright © 2018年 徐沙洪. All rights reserved.
//

#import "CountUnitView.h"

@interface CountUnitView () <UITextFieldDelegate>
@end

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
        _subBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _subBtn.frame = (CGRectMake(0, 0, self.frame.size.height, self.frame.size.height));
        [_subBtn setTitle:@"-" forState:(UIControlStateNormal)];
        [_subBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_subBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateSelected)];

        [_subBtn setImage:[UIImage imageNamed:@"icon_minus_nomal"] forState:(UIControlStateNormal)];
        [_subBtn setImage:[UIImage imageNamed:@"icon_minus_disable"] forState:(UIControlStateSelected)];
        _subBtn.selected = true;
        [_subBtn addTarget:self action:@selector(subBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _subBtn;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _addBtn.frame = (CGRectMake(self.frame.size.width-self.frame.size.height, 0, self.frame.size.height, self.frame.size.height));
        [_addBtn setTitle:@"+" forState:(UIControlStateNormal)];
        [_addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_addBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateSelected)];

        [_addBtn setImage:[UIImage imageNamed:@"add_icon_nomal"] forState:(UIControlStateNormal)];
        [_addBtn setImage:[UIImage imageNamed:@"add_icon_disable"] forState:(UIControlStateSelected)];
        [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}

- (UITextField *)amountTF {
    if (!_amountTF) {
        _amountTF = [[UITextField alloc] initWithFrame:(CGRectMake(self.frame.size.height, 0, self.frame.size.width-self.frame.size.height*2, self.frame.size.height))];
        _amountTF.text = @"1";
        _amountTF.textAlignment = NSTextAlignmentCenter; //水平居中
        _amountTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
        _amountTF.keyboardType = UIKeyboardTypeNumberPad;
        _amountTF.delegate = self;
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
    if (![self isNumberString:self.amountTF.text]) {
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

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField performSelector:@selector(selectAll:) withObject:nil afterDelay:0.0];
}

#pragma mark - other
// 判断字符串是否纯数字 0-9
- (BOOL)isNumberString:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


@end

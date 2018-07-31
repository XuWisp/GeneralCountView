//
//  CountUnitView.h
//  CASAMIEL
//
//  Created by 徐沙洪 on 2018/3/29.
//  Copyright © 2018年 徐沙洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountUnitView : UIView

@property (nonatomic, strong) UITextField *amountTF;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *subBtn;
@property (nonatomic, assign) NSInteger maxNum;

- (void)setAllBtnUserInteractionEnabled:(BOOL)isEnable;

@end

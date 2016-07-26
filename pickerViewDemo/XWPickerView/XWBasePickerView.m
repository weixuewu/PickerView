//
//  XWBasePickerView.m
//  MumFans
//
//  Created by weixuewu on 16/7/21.
//  Copyright © 2016年 weixuewu. All rights reserved.
//

#import "XWBasePickerView.h"

@interface XWBasePickerView ()

@property (nonatomic, strong) UIControl *controlForDismiss;                     //背景触摸控件
@property (nonatomic, assign) BOOL topTop;

@end

@implementation XWBasePickerView

-(instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        [self setupViewWithTitle:title];
    }
    return self;
}

-(void)setupViewWithTitle:(NSString *)title{
    
    self.backgroundColor = [UIColor whiteColor];
    self.topTop = YES;
    
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:self.controlForDismiss];
    [self.controlForDismiss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(keywindow);
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [keywindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(keywindow.mas_bottom).mas_offset(250);
        make.left.equalTo(keywindow.mas_left);
        make.right.equalTo(keywindow.mas_right);
        make.height.mas_equalTo(250);
        
    }];
    
    //头部
    UIView *headerView = [[UIView alloc]init];
    [self addSubview:headerView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:kColor_Dark_Grey forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 10.0;
    cancelBtn.layer.borderColor = kColor_Dark_Grey.CGColor;
    cancelBtn.layer.borderWidth = 0.5;
    cancelBtn.titleLabel.font = kFontSizeC;
    [cancelBtn addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:cancelBtn];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn.backgroundColor = kColor_Pink;
    okBtn.layer.cornerRadius = 10.0;
    okBtn.titleLabel.font = kFontSizeC;
    [okBtn addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:okBtn];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = kColor_Pink;
    label.font = kFontSizeC;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    [headerView addSubview:label];
    
    UILabel *line1 = [[UILabel alloc]init];
    line1.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:line1];
    
    self.contentView = [[UIView alloc]init];
    [self addSubview:self.contentView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_offset(@44);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(headerView.mas_bottom);
        make.bottom.equalTo(self);
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(headerView);
        make.right.equalTo(headerView);
        make.bottom.equalTo(headerView);
        make.height.mas_offset(@0.5);
    }];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(headerView.mas_left).offset(15);
        make.top.equalTo(headerView.mas_top).offset(7);
        make.bottom.equalTo(line1.mas_bottom).offset(-7);
        make.width.mas_offset(@60);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top);
        make.bottom.equalTo(line1.mas_bottom);
        make.left.equalTo(cancelBtn.mas_right).offset(10);
    }];
    
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(label.mas_right).offset(10);
        make.right.equalTo(headerView.mas_right).offset(-15);
        make.top.equalTo(headerView.mas_top).offset(7);
        make.bottom.equalTo(line1.mas_bottom).offset(-7);
        make.width.mas_offset(@60);
        
    }];
}

-(UIControl *)controlForDismiss{
    
    if (nil == _controlForDismiss)
    {
        _controlForDismiss = [[UIControl alloc] init];
        _controlForDismiss.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [_controlForDismiss addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
    }
    return _controlForDismiss;
}

- (void)disappear
{
    [self animatedOut];
}

-(void)complete{
    
}

- (void)animatedOut
{
    self.topTop = NO;

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.35 animations:^{
        
        [self layoutIfNeeded];

    } completion:^(BOOL finished) {
        if (finished) {
            if (self.controlForDismiss)
            {
                [self.controlForDismiss removeFromSuperview];
            }
            [self removeFromSuperview];
        }
    }];
}

//- (void)animatedIn{
//    [UIView animateWithDuration:0.35 animations:^{
//        
//        self.transform = CGAffineTransformMakeTranslation(0, 250);
//        
//    } completion:nil];
//}

-(void)showWithCompleted:(CompletedBlock)block{
    self.dateBlock = block;
}

-(void)updateConstraints{

    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.topTop) {
            make.bottom.equalTo(keywindow.mas_bottom).mas_offset(0);
        }else{
            make.bottom.equalTo(keywindow.mas_bottom).mas_offset(250);
        }
    }];
    
    [super updateConstraints];

}

+(BOOL)requiresConstraintBasedLayout{
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  XWDatePickView.m
//  MumFans
//
//  Created by weixuewu on 16/7/22.
//  Copyright © 2016年 weixuewu. All rights reserved.
//

#import "XWDatePickView.h"

@interface XWDatePickView ()

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation XWDatePickView

-(void)initView{
    
    self.datePicker = [[UIDatePicker alloc]init];
    self.datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.maximumDate = [NSDate date];
    NSDate *minDate = [NSDate dateWithTimeInterval:-60 *3600 *24 sinceDate:[NSDate date]];
    self.datePicker.minimumDate = minDate;
    [self.datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.datePicker];
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        
    }];

//    unsigned int outCount;
//    int i;
//    objc_property_t *pProperty = class_copyPropertyList([UIDatePicker class], &outCount);
//    for (i = outCount -1; i >= 0; i--)
//    {
//        // 循环获取属性的名字   property_getName函数返回一个属性的名称
//        NSString *getPropertyName = [NSString stringWithCString:property_getName(pProperty[i]) encoding:NSUTF8StringEncoding];
//        NSString *getPropertyNameString = [NSString stringWithCString:property_getAttributes(pProperty[i]) encoding:NSUTF8StringEncoding];
//        if([getPropertyName isEqualToString:@"highlightColor"])
//        {
//            [self.datePicker setValue:kColor_Pink forKey:@"highlightColor"];
//        }
//        
//        NSLog(@"%@====%@",getPropertyNameString,getPropertyName);
//    }
}

-(void)datePickerValueChanged:(UIDatePicker *)picker{
    
}

-(void)showWithCompleted:(CompletedBlock)block{
    self.dateBlock = block;
    [self initView];
    
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
//    [UIView animateWithDuration:1.4 animations:^{
//        [self layoutIfNeeded];
//    }];
}

-(void)complete{
    self.dateBlock(self.datePicker.date);
    [self disappear];
}

@end

//
//  XWGeneralPickerView.m
//  MumFans
//
//  Created by weixuewu on 16/7/22.
//  Copyright © 2016年 weixuewu. All rights reserved.
//

#import "XWGeneralPickerView.h"

@interface XWGeneralPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger _row;
}

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, copy) FinishBlock finish_block;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSArray *lists;

@end

@implementation XWGeneralPickerView

-(void)initView{
    
    self.picker = [[UIPickerView alloc]init];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    self.picker.showsSelectionIndicator = YES;
    [self.picker reloadAllComponents];
    [self.contentView addSubview:self.picker];
    
    [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        
    }];
}

-(void)showWithArray:(NSArray *)array finish:(FinishBlock)block{
    self.finish_block = block;
    
    self.data = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        [self.data addObject:[array[i] firstObject]];
    }
    
    self.lists = array;
    [self initView];
}

-(void)complete{
    self.finish_block(self.data);
    [self disappear];
}

#pragma mark - pickerview
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return self.lists.count;
}
- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger count = [self.lists[component] count];
    return count;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}

#pragma mark 实现协议UIPickerViewDelegate方法

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *string  = [self.lists[component] objectAtIndex:row];
    return string;
}

-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSAttributedString *string  = [[NSAttributedString alloc]initWithString:[self.lists[component] objectAtIndex:row] attributes:@{NSFontAttributeName:kFontSizeDPlus,NSForegroundColorAttributeName:kColor_Dark_Grey}];
    if (_row == row) {
        string  = [[NSAttributedString alloc]initWithString:[self.lists[component] objectAtIndex:row] attributes:@{NSFontAttributeName:kFontSizeDPlus,NSForegroundColorAttributeName:kColor_Pink}];
    }
    return string;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _row = row;
    [pickerView reloadComponent:component];
    
    NSString *string  = [self.lists[component] objectAtIndex:row];
    [self.data replaceObjectAtIndex:component withObject:string];
}

@end

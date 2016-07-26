//
//  XWMainViewController.m
//  pickerViewDemo
//
//  Created by weixuewu on 16/7/25.
//  Copyright © 2016年 weixuewu. All rights reserved.
//

#import "XWMainViewController.h"
#import "XWDatePickView.h"
#import "XWGeneralPickerView.h"

@interface XWMainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *lists;
@property (nonatomic, strong) NSMutableArray *menstruationArray;

@end

@implementation XWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.lists = @[@"datePicker",@"otherPicker"];
    
    NSMutableArray *array1 = [NSMutableArray array];
    NSMutableArray *array2 = [NSMutableArray array];
    for (int i = 1; i <= 7; i++) {
        NSString *str = [NSString stringWithFormat:@"经期%d天",i];
        [array1 addObject:str];
    }
    for (int i = 1; i <= 28; i++) {
        NSString *str = [NSString stringWithFormat:@"周期%d天",i];
        [array2 addObject:str];
    }
    self.menstruationArray = [NSMutableArray arrayWithObjects:array1,array2, nil];
}

#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lists.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.textLabel.text = self.lists[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        XWDatePickView *picker = [[XWDatePickView alloc]initWithTitle:@"最近一次月经开始日"];
        [picker showWithCompleted:^(NSDate *date) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *strDate = [dateFormatter stringFromDate:date];
            NSLog(@"date: %@",strDate);
        }];
    }else if (indexPath.row == 1){
        XWGeneralPickerView *picker = [[XWGeneralPickerView alloc]initWithTitle:@"设置经期和周期"];
        [picker showWithArray:self.menstruationArray finish:^(NSArray *array) {
            NSString *string = [NSString stringWithFormat:@"%@ %@",array[0],array[1]];
            
            NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
            int jingqi =[[array[0] stringByTrimmingCharactersInSet:nonDigits] intValue];
            int zhouqi =[[array[1] stringByTrimmingCharactersInSet:nonDigits] intValue];
            
            NSLog(@"输出字符串：%@， 获取经期整数：%d，周期整数：%d",string,jingqi,zhouqi);
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

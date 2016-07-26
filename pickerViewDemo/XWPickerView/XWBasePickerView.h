//
//  XWBasePickerView.h
//  MumFans
//
//  Created by weixuewu on 16/7/21.
//  Copyright © 2016年 weixuewu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

#import "HexColor.h"

#define kColor_Dark_Grey   [UIColor colorWithHexString:@"#999999"]              //浅灰
#define kColor_Pink        [UIColor colorWithHexString:@"#ff6478"]              //粉色
#define kFontSizeDPlus [UIFont systemFontOfSize:14.0f]
#define kFontSizeC [UIFont systemFontOfSize:16.0f]

typedef void(^CompletedBlock)(NSDate *date);

@interface XWBasePickerView : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, copy)   CompletedBlock dateBlock;

-(instancetype)initWithTitle:(NSString *)title;

-(void)showWithCompleted:(CompletedBlock)block;

-(void)disappear;
-(void)complete;

@end

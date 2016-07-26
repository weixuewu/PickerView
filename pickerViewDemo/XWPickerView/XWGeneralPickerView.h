//
//  XWGeneralPickerView.h
//  MumFans
//
//  Created by weixuewu on 16/7/22.
//  Copyright © 2016年 weixuewu. All rights reserved.
//

#import "XWBasePickerView.h"

typedef void(^FinishBlock)(NSArray *array);

@interface XWGeneralPickerView : XWBasePickerView

-(void)showWithArray:(NSArray *)array finish:(FinishBlock)block;

@end

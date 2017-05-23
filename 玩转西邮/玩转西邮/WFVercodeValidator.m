//
//  WFVercodeValidator.m
//  玩转西邮
//
//  Created by fly on 2017/5/23.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "WFVercodeValidator.h"

@implementation WFVercodeValidator

- (BOOL)validatoInput:(NSString *)input {
    
    BOOL isLegal = input.length < 1 ? NO : YES;
    if (!isLegal) {
        self.errorMessage = @"验证码为空";
    }
    return isLegal;
    
}

@end

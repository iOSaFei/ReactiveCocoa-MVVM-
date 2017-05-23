//
//  WFPasswordValidator.m
//  玩转西邮
//
//  Created by fly on 2017/5/21.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "WFPasswordValidator.h"

@implementation WFPasswordValidator

- (BOOL)validatoInput:(NSString *)input {
    
    BOOL isLegal = input.length < 1 ? NO : YES;
    if (!isLegal) {
        self.errorMessage = @"密码为空";
    }
    return isLegal;
    
}

@end

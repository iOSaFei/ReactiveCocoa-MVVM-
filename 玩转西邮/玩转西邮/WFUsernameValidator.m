//
//  WFUsernameValidator.m
//  玩转西邮
//
//  Created by fly on 2017/5/21.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "WFUsernameValidator.h"

@implementation WFUsernameValidator

- (BOOL)validatoInput:(NSString *)input {
    
    NSString *regex = @"^[0-9]{8}$";
    NSPredicate *predicater = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isLegal = [predicater evaluateWithObject:input];
    if (!isLegal) {
        self.errorMessage = @"学号输入有误";
    }
    return isLegal;
    
}

@end

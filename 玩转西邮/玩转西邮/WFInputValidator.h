//
//  WFInputValidator.h
//  玩转西邮
//
//  Created by fly on 2017/5/21.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFInputValidator : NSObject

@property (nonatomic, strong) NSString *errorMessage;  // 错误的原因

/*
 抽象的策略类，根据需要验证的内容在子类中重写方法
 */

- (BOOL)validatoInput:(NSString *)input;

@end

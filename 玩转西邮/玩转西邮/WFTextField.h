//
//  WFTextField.h
//  玩转西邮
//
//  Created by fly on 2017/5/21.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFInputValidator.h"

@interface WFTextField : UITextField

@property (nonatomic, strong) NSString *illegalMessage;

@property (nonatomic, strong) NSString *inputLegal;

- (void)placeholder:(NSString *)placeholder
    inputValidatror:(WFInputValidator *)validator;

@end

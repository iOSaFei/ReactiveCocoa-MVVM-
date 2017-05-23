//
//  WFLoginViewModel.m
//  玩转西邮
//
//  Created by fly on 2017/5/21.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "WFLoginViewModel.h"
#import "WFLoginModel.h"
#import "WZXYHeader.h"

@interface WFLoginViewModel ()

@property (nonatomic, strong) WFLoginModel *loginModel;

@end

@implementation WFLoginViewModel

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _loginModel = [[WFLoginModel alloc] init];
        [[_loginModel rac_valuesAndChangesForKeyPath:@"loginModel"
                                             options:NSKeyValueObservingOptionNew
                                            observer:self] subscribeNext:^(id x) {
            NSDictionary *dictionary =  [x[1] valueForKey:NSKeyValueChangeNewKey];
            NSDictionary *result = dictionary[@"result"];
            NSString *string = result[@"verCode"];
            NSArray *strArray = [string componentsSeparatedByString:@","];
            if (strArray.count) {
                self.URLstring = strArray[1];
            }
        }];
        [[_loginModel rac_valuesAndChangesForKeyPath:@"requestError"
                                             options:NSKeyValueObservingOptionNew
                                            observer:self] subscribeNext:^(id x) {
            self.getError =  [x[1] valueForKey:NSKeyValueChangeNewKey];
        }];
    }
    return self;
    
}

- (void)getVercode {
    [_loginModel requestVercode];
}

@end

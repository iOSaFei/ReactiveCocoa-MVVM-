//
//  WFLoginModel.m
//  玩转西邮
//
//  Created by fly on 2017/5/23.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "WFLoginModel.h"
#import "WZXYHeader.h"

@implementation WFLoginModel

- (void)requestVercode {
    
    NSString *URL = @"http://scoreapi.xiyoumobile.com/users/verCode";
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    [sessionManager POST:URL
              parameters:nil
                progress:^(NSProgress * _Nonnull uploadProgress) {}
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     self.loginModel = responseObject;                     
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     self.requestError = @"请求验证码出错";
                     
                 }];

}

@end

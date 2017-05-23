//
//  WFLoginModel.h
//  玩转西邮
//
//  Created by fly on 2017/5/23.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFLoginModel : NSObject

@property (nonatomic, strong) NSDictionary *loginModel;
@property (nonatomic, strong) NSString *requestError;

- (void)requestVercode;

@end

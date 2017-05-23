//
//  WFLoginViewModel.h
//  玩转西邮
//
//  Created by fly on 2017/5/21.
//  Copyright © 2017年 fly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFLoginViewModel : NSObject

@property (nonatomic, strong) NSString *URLstring;
@property (nonatomic, strong) NSString *getError;

- (void)getVercode;

@end

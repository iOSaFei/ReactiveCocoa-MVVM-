//
//  WZXYHeader.h
//  玩转西邮
//
//  Created by fly on 2017/5/17.
//  Copyright © 2017年 fly. All rights reserved.
//

#ifndef WZXYHeader_h
#define WZXYHeader_h

#import <SVProgressHUD/SVProgressHUD.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>

#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define kWindowWidth ([[UIScreen mainScreen] bounds].size.width)
#define kWindowHeight ([[UIScreen mainScreen] bounds].size.height)

#define MainColor ([UIColor colorWithRed:61/255.0 green:137/255.0 blue:222/255.0 alpha:1.0])

#endif /* WZXYHeader_h */

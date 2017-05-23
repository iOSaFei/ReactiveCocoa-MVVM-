//
//  WFBackGifView.m
//  玩转西邮
//
//  Created by fly on 2017/5/19.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "WFBackGifView.h"
#import "WZXYHeader.h"

@implementation WFBackGifView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self wf_setUpViews];
    }
    return self;
}

- (void)wf_setUpViews {
    YYImage *image = [YYImage imageNamed:@"backGif"];
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    imageView.frame = self.frame;
    [self addSubview:imageView];
}

@end

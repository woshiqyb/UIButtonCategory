//
//  UIButton+Badge.h
//  TestBadgeButton
//
//  Created by qianyb on 16/4/8.
//  Copyright © 2016年 qianyb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BadgeLayout) {
    BadgeLayoutOnTitle = 0,
    BadgeLayoutOnImage
};

@interface UIButton (Badge)

- (void)setBadge:(NSString *)badge layoutOnImageOrTitleTopLeft:(BadgeLayout)layoutOn;
@end

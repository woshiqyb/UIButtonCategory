//
//  UIButton+Badge.m
//  TestBadgeButton
//
//  Created by qianyb on 16/4/8.
//  Copyright © 2016年 qianyb. All rights reserved.
//

#import "UIButton+Badge.h"
#import <objc/runtime.h>

#define BADGE_LABEL_TAG     10202010
#define BADGE_FONT          [UIFont systemFontOfSize:12]

@implementation UIButton (Badge)
+ (void)load {
    Method badgeLayoutMethod = class_getInstanceMethod(self, @selector(qyb_badgeButtonLayoutSubviews));
    Method originLayoutMethod = class_getInstanceMethod(self, @selector(layoutSubviews));
    method_exchangeImplementations(badgeLayoutMethod, originLayoutMethod);
}

- (void)qyb_badgeButtonLayoutSubviews {
    [self qyb_badgeButtonLayoutSubviews];
    
    UILabel *badgeLabel = [self viewWithTag:BADGE_LABEL_TAG];
    if (badgeLabel) {
        BadgeLayout layout = [self badgeLayout];
        UIView *layoutView;
        if (layout == BadgeLayoutOnImage) {
            layoutView = self.imageView;
        }else if (layout == BadgeLayoutOnTitle) {
            layoutView = self.titleLabel;
        }
        
        if (layoutView && !CGRectEqualToRect(layoutView.frame, CGRectZero)) {
            CGSize badgeSize = [self badgeSize];
            badgeLabel.frame = CGRectMake(CGRectGetMaxX(layoutView.frame), CGRectGetMinY(layoutView.frame) - badgeSize.height/2, badgeSize.width, badgeSize.height);
           
            //设置圆角
            badgeLabel.layer.masksToBounds = YES;
            badgeLabel.layer.cornerRadius = badgeSize.height / 2;
        }
    }
}

#pragma mark - Public Method
- (void)setBadge:(NSString *)badge layoutOnImageOrTitleTopLeft:(BadgeLayout)layoutOn {
    UILabel *badgeLabel = [self viewWithTag:BADGE_LABEL_TAG];
    if (!badgeLabel) {
        badgeLabel = [UILabel new];
        badgeLabel.tag = BADGE_LABEL_TAG;
        badgeLabel.textAlignment = NSTextAlignmentCenter;
        badgeLabel.backgroundColor = [UIColor redColor];
        badgeLabel.textColor = [UIColor whiteColor];
        badgeLabel.font = BADGE_FONT;
        
        [self addSubview:badgeLabel];
    }
    
    [self setBadgeLayout:layoutOn];
    badgeLabel.text = badge;
}

#pragma mark - Getter And Setter Method
- (void)setBadgeLayout:(BadgeLayout)layoutOn {
    objc_setAssociatedObject(self, @"layout", @(layoutOn), OBJC_ASSOCIATION_ASSIGN);
}

- (BadgeLayout)badgeLayout {
    return (BadgeLayout)[(NSNumber *)objc_getAssociatedObject(self, @"layout") intValue];
}


#pragma mark - Private Method
- (CGSize)badgeSize {
    UILabel *badgeLabel = [self viewWithTag:BADGE_LABEL_TAG];
    CGRect originRect = CGRectZero;
    
    if (badgeLabel) {
        originRect = [badgeLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:BADGE_FONT} context:nil];
        CGFloat badgeHeight = CGRectGetHeight(originRect);
        NSString *badge = badgeLabel.text;
        if ([badge stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
            originRect.size = CGSizeMake(10, 10);
            
        }else if (badge.length == 1) {
            originRect.size = CGSizeMake(badgeHeight, badgeHeight);
            
        }else if (badge.length >= 2) {
            originRect.size = CGSizeMake(MAX(originRect.size.width + badgeHeight/2 , badgeHeight), badgeHeight);
        }
    }
    
    return originRect.size;
}
@end

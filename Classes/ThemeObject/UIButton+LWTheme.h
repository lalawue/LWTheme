//
//  UIButton+LWTheme.h
//  LWTheme
//
//  Created by lalawue on 2019/12/11.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LWTheme)

- (void)lw_setTitleColor:(NSString *)color forState:(UIControlState)state;

- (NSString *)lw_titleColorForState:(UIControlState)state;

- (void)lw_setImage:(UIImage *)image withTintColor:(NSString *)tintColor forState:(UIControlState)state;

- (void)lw_setBackgroundImage:(UIImage *)image withTintColor:(NSString *)tintColor forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END

//
//  NSObject+LWTheme.h
//  LWTheme
//
//  Created by lalawue on 2019/12/8.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LWThemeObjectNotify <NSObject>

- (void)lw_callSetterWithValue; ///< call when theme changed

@end

/** Store and Notification level
 */
@interface NSObject (LWTheme) <LWThemeObjectNotify>

// store
- (void)lw_storeValue:(id)value forSetter:(SEL)setter;

- (id)lw_valueForSetter:(SEL)setter;

// color
- (UIColor *)lw_colorForPattern:(NSString *)colorPattern;

+ (UIColor *)lw_colorForPattern:(NSString *)colorPattern;

// font
- (UIFont *)lw_fontForPattern:(NSString *)fontPattern;

// image
- (UIImage *)lw_imageNamed:(NSString *)imagePattern;

@end

NS_ASSUME_NONNULL_END

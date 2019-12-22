//
//  LWThemeManager.h
//  LWTheme
//
//  Created by lalawue on 2019/12/8.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kLWThemeModeUpdateNotification; ///< theme mode update notification

typedef enum : NSUInteger {
    LWThemeMode_Light = 0,
    LWThemeMode_Dark,
} LWThemeMode;

/** LWThemeMode Manager
 */
@interface LWThemeManager : NSObject

@property (nonatomic, readonly) LWThemeMode themeMode;

@property (nonatomic, readonly) BOOL isDarkMode;

+ (instancetype)sharedInstance;

- (void)useThemeMode:(LWThemeMode)themeMode withThemeMap:(NSDictionary *)themeMap; ///< change theme

#pragma mark - Helper

- (UIColor *)colorForPattern:(NSString *)colorPattern; ///< UIColor from colorPattern

- (NSString *)colorStringForPattern:(NSString *)colorPattern; ///< colorString from colorPattrn

- (UIFont *)fontForPattern:(NSString *)fontPattern;

- (UIImage *)imageNamed:(NSString *)imagePattern;

@end

NS_ASSUME_NONNULL_END

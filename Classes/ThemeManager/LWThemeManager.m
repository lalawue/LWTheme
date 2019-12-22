//
//  LWThemeManager.m
//  LWTheme
//
//  Created by lalawue on 2019/12/8.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import "LWThemeManager_Private.h"
#import "UIColor+HexString.h"

NSString *const kLWThemeModeUpdateNotification = @"kLWThemeModeUpdateNotification";

@interface LWThemeManager ()
@property (nonatomic, strong) NSDictionary *colorMap;
@property (nonatomic, strong) NSDictionary *fontMap;
@property (nonatomic, strong) NSDictionary *imageMap;
@property (nonatomic, strong) NSHashTable *themeObjects; ///< object applly theme color
@end

@implementation LWThemeManager

+ (instancetype)sharedInstance
{
    static LWThemeManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LWThemeManager alloc] init];
        manager.themeObjects = [NSHashTable weakObjectsHashTable];
    });
    return manager;
}

- (BOOL)isDarkMode
{
    return self.themeMode == LWThemeMode_Dark;
}

- (void)useThemeMode:(LWThemeMode)themeMode withThemeMap:(NSDictionary *)themeMap
{
    if ([themeMap isKindOfClass:[NSDictionary class]]) {
        _themeMode = themeMode;
        self.colorMap = themeMap[@"Color"];
        self.fontMap = themeMap[@"Font"];
        self.imageMap = themeMap[@"Image"];
        [self changeThemeForObjects];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLWThemeModeUpdateNotification object:@(themeMode)];
    }
}

- (void)changeThemeForObjects
{
    if (self.themeObjects.count) {
        NSArray *objects = [self.themeObjects.allObjects copy];
        for (id<LWThemeObjectNotify> obj in objects) {
            if ([obj respondsToSelector:@selector(lw_callSetterWithValue)]) {
                [obj lw_callSetterWithValue];
            }
        }
    }
}

- (UIColor *)colorForPattern:(NSString *)colorPattern
{
    if (colorPattern.length) {
        NSString *colorString = [self.colorMap objectForKey:colorPattern];
        UIColor *colorValue = [UIColor colorWithHexString:colorString.length ? colorString : colorPattern];
        return colorValue;
    }
    return nil;
}

- (NSString *)colorStringForPattern:(NSString *)colorPattern
{
    return self.colorMap[colorPattern];
}

- (UIFont *)fontForPattern:(NSString *)fontPattern
{
    NSString *fontDesc = self.fontMap[fontPattern];
    if (fontDesc.length) {
        NSRange r = [fontDesc rangeOfString:@":"];
        if (r.location != NSNotFound) {
            NSString *fontFamily = [fontDesc substringToIndex:r.location];
            CGFloat fontSize = [[fontDesc substringFromIndex:r.location + 1] floatValue];
            if (fontFamily.length<=0 || [fontFamily isEqualToString:@"_"]) {
                return [UIFont systemFontOfSize:fontSize];
            }
            if ([fontFamily.lowercaseString isEqualToString:@"bold"]) {
                return [UIFont boldSystemFontOfSize:fontSize];
            }
            if ([fontFamily.lowercaseString isEqualToString:@"italic"]) {
                return [UIFont italicSystemFontOfSize:fontSize];
            }
            return [UIFont fontWithName:fontFamily size:fontSize] ?: [UIFont systemFontOfSize:fontSize];
        }
    }
    return [UIFont systemFontOfSize:12];
}

- (UIImage *)imageNamed:(NSString *)imagePattern
{
    if (imagePattern.length) {
        NSString *imageName = self.imageMap[imagePattern];
        if (imageName) {
            return [UIImage imageNamed:imageName];
        } else {
            return [UIImage imageNamed:imagePattern];
        }
    }
    return nil;
}

@end

#pragma mark -

@implementation LWThemeManager (Notifier)

- (void)addThemeObject:(id<LWThemeObjectNotify>)object
{
    if ([object respondsToSelector:@selector(lw_callSetterWithValue)]) {
        [self.themeObjects addObject:object];
    }
}

- (void)removeThemeObject:(id)object
{
    [self.themeObjects removeObject:object];
}

@end

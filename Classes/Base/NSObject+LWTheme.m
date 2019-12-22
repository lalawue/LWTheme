//
//  NSObject+LWTheme.m
//  LWTheme
//
//  Created by lalawue on 2019/12/8.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import "NSObject+LWTheme.h"
#import "LWThemeManager_Private.h"
#import <objc/runtime.h>

static void const *kNSObjectLWThemeColorSetterKey = &kNSObjectLWThemeColorSetterKey;

@implementation NSObject (LWTheme)

- (void)lw_storeValue:(id)value forSetter:(SEL)setter
{
    if (!setter) {
        return;
    }
    NSString *setterKey = NSStringFromSelector(setter);

    NSMutableDictionary *dict = objc_getAssociatedObject(self, &kNSObjectLWThemeColorSetterKey);
    if (!dict) {
        dict = [NSMutableDictionary dictionaryWithCapacity:2];
        objc_setAssociatedObject(self, &kNSObjectLWThemeColorSetterKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    if (value) {
        [dict setObject:value forKey:setterKey];
    } else {
        [dict removeObjectForKey:setterKey];
    }
    
    if (dict.count) {
        [[LWThemeManager sharedInstance] addThemeObject:self];
    } else {
        [[LWThemeManager sharedInstance] removeThemeObject:self];
    }
}

- (id)lw_valueForSetter:(SEL)setter
{
    if (setter) {
        NSString *setterKey = NSStringFromSelector(setter);
        NSMutableDictionary *dict = objc_getAssociatedObject(self, &kNSObjectLWThemeColorSetterKey);
        return [dict objectForKey:setterKey];
    } else {
        return @"";
    }
}

- (void)lw_callSetterWithValue
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &kNSObjectLWThemeColorSetterKey);
    for (NSString *setterKey in dict.allKeys) {
        SEL setter = NSSelectorFromString(setterKey);
        if ([self respondsToSelector:setter]) {
            id value = [dict objectForKey:setterKey];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:setter withObject:value];
#pragma clang diagnostic pop
        }
    }
}

- (UIColor *)lw_colorForPattern:(NSString *)colorPattern
{
    return [[LWThemeManager sharedInstance] colorForPattern:colorPattern];
}

+ (UIColor *)lw_colorForPattern:(NSString *)colorPattern
{
    return [[LWThemeManager sharedInstance] colorForPattern:colorPattern];
}

- (UIFont *)lw_fontForPattern:(NSString *)fontPattern
{
    return [[LWThemeManager sharedInstance] fontForPattern:fontPattern];
}

- (UIImage *)lw_imageNamed:(NSString *)imagePattern
{
    return [[LWThemeManager sharedInstance] imageNamed:imagePattern];
}

@end

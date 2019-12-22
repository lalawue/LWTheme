//
//  UISwitch+LWTheme.m
//  LWThemeObjC
//
//  Created by lalawue on 2019/12/21.
//

#import "UISwitch+LWTheme.h"
#import "LWTheme_Tools.h"

@implementation UISwitch (LWTheme)

- (NSString *)lw_onTintColor
{
    return (NSString *)[self lw_valueForSetter:@selector(setLw_onTintColor:)];
}

- (void)setLw_onTintColor:(NSString *)lw_onTintColor
{
    self.onTintColor = [self lw_colorForPattern:lw_onTintColor];
    [self lw_storeValue:lw_onTintColor forSetter:@selector(setLw_onTintColor:)];
}

- (NSString *)lw_tintColor
{
    return (NSString *)[self lw_valueForSetter:@selector(setLw_tintColor:)];
}

- (void)setLw_tintColor:(NSString *)lw_tintColor
{
    self.tintColor = [self lw_colorForPattern:lw_tintColor];
    [self lw_storeValue:lw_tintColor forSetter:@selector(setLw_tintColor:)];
}

- (NSString *)lw_thumbTintColor
{
    return (NSString *)[self lw_valueForSetter:@selector(setLw_thumbTintColor:)];
}

- (void)setLw_thumbTintColor:(NSString *)lw_thumbTintColor
{
    self.thumbTintColor = [self lw_colorForPattern:lw_thumbTintColor];
    [self lw_storeValue:lw_thumbTintColor forSetter:@selector(setLw_thumbTintColor:)];
}

@end

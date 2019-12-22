//
//  CALayer+LWTheme.m
//  LWThemeObjC
//
//  Created by lalawue on 2019/12/21.
//

#import "CALayer+LWTheme.h"
#import "LWTheme_Tools.h"

@implementation CALayer (LWTheme)

- (NSString *)lw_backgroundColor
{
    return (NSString *)[self lw_valueForSetter:@selector(setLw_backgroundColor:)];
}

- (void)setLw_backgroundColor:(NSString *)lw_backgroundColor
{
    UIColor *colorValue = [self lw_colorForPattern:lw_backgroundColor];
    self.backgroundColor = colorValue.CGColor;
    [self lw_storeValue:lw_backgroundColor forSetter:@selector(setLw_backgroundColor:)];
}

- (NSString *)lw_borderColor
{
    return (NSString *)[self lw_valueForSetter:@selector(setLw_borderColor:)];
}

- (void)setLw_borderColor:(NSString *)lw_borderColor
{
    UIColor *colorValue = [self lw_colorForPattern:lw_borderColor];
    self.borderColor = colorValue.CGColor;
    [self lw_storeValue:lw_borderColor forSetter:@selector(setLw_borderColor:)];
}

- (NSString *)lw_shadowColor
{
    return (NSString *)[self lw_valueForSetter:@selector(setLw_shadowColor:)];
}

- (void)setLw_shadowColor:(NSString *)lw_shadowColor
{
    UIColor *colorValue = [self lw_colorForPattern:lw_shadowColor];
    self.shadowColor = colorValue.CGColor;
    [self lw_storeValue:lw_shadowColor forSetter:@selector(setLw_shadowColor:)];
}

@end

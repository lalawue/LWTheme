//
//  UINavigationBar+LWTheme.m
//  LWTheme
//
//  Created by lalawue on 2019/12/14.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import "UINavigationBar+LWTheme.h"
#import "LWTheme_Tools.h"

@implementation UINavigationBar (LWTheme)

- (void)setLw_tintColor:(NSString *)lw_tintColor
{
    UIColor *color = [self lw_colorForPattern:lw_tintColor];
    self.tintColor = color;
    [self lw_storeValue:lw_tintColor forSetter:_cmd];
}

- (NSString *)lw_tintColor
{
    return (NSString *)[self lw_valueForSetter:@selector(setLw_tintColor:)];
}

- (void)setLw_barTintColor:(NSString *)lw_barTintColor
{
    UIColor *color = [self lw_colorForPattern:lw_barTintColor];
    self.barTintColor = color;
    [self lw_storeValue:lw_barTintColor forSetter:_cmd];
}

- (NSString *)lw_barTintColor
{
    return (NSString *)[self lw_valueForSetter:@selector(setLw_barTintColor:)];
}

@end

//
//  UIView+LWTheme.m
//  LWTheme
//
//  Created by lalawue on 2019/12/8.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import "UIView+LWTheme.h"
#import "LWTheme_Tools.h"

@implementation UIView (LWTheme)

- (void)setLw_backgroundColor:(NSString *)lw_backgroundColor
{
    UIColor *color = [self lw_colorForPattern:lw_backgroundColor];
    if (color) {
        self.backgroundColor = color;
        [self lw_storeValue:lw_backgroundColor forSetter:_cmd];
    }
}

- (NSString *)lw_backgroundColor
{
    return [self lw_valueForSetter:@selector(setLw_backgroundColor:)];
}

@end

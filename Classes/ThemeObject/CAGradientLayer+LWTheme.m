//
//  CAGradientLayer+LWTheme.m
//  LWThemeObjC
//
//  Created by lalawue on 2019/12/22.
//

#import "CAGradientLayer+LWTheme.h"
#import "LWTheme_Tools.h"

@implementation CAGradientLayer (LWTheme)

- (NSArray<NSString *> *)lw_colors
{
    return (NSArray<NSString *> *)[self lw_valueForSetter:@selector(setLw_colors:)];
}

- (void)setLw_colors:(NSArray<NSString *> *)lw_colors
{
    if ([lw_colors isKindOfClass:[NSArray class]] && lw_colors.count) {
        NSMutableArray *array = [NSMutableArray new];
        for (NSString *colorPattern in lw_colors) {
            UIColor *colorValue = [self lw_colorForPattern:colorPattern];
            if (colorValue) {
                [array addObject:(id)colorValue.CGColor];
            }
        }
        self.colors = array;
        [self lw_storeValue:lw_colors forSetter:@selector(setLw_colors:)];
    }
}

@end

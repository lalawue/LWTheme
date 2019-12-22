//
//  CAGradientLayer+LWTheme.h
//  LWThemeObjC
//
//  Created by lalawue on 2019/12/22.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAGradientLayer (LWTheme)

@property(nullable, copy) NSArray<NSString *> *lw_colors;

@end

NS_ASSUME_NONNULL_END

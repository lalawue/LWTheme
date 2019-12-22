//
//  LWImageUtils.m
//  LWTheme
//
//  Created by lalawue on 2019/12/13.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import "LWImageUtils.h"

@implementation LWImageUtils

+ (UIImage *)fillImage:(UIImage *)image withColor:(UIColor *)color
{
    if ([image isKindOfClass:[UIImage class]] && [color isKindOfClass:[UIColor class]]) {
        UIImage *newImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
        [color set];
        [newImage drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return coloredImg;
    } else {
        return image;
    }
}

@end

//
//  UIImageView+LWTheme.m
//  LWTheme
//
//  Created by lalawue on 2019/12/13.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import "UIImageView+LWTheme.h"
#import "LWTheme_Tools.h"

@interface LWImageColorItem : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *tintColorKey;
@end

@implementation LWImageColorItem
@end

@implementation UIImageView (LWTheme)

- (NSString *)lw_imageName
{
    return (NSString *)[self lw_valueForSetter:@selector(setLw_imageName:)];
}

- (void)setLw_imageName:(NSString *)lw_imageName
{
    if (lw_imageName.length) {
        self.image = [self lw_imageNamed:lw_imageName];
        [self lw_storeValue:lw_imageName forSetter:@selector(setLw_imageName:)];
    }
}

- (void)lw_setImage:(UIImage *)image withTintColor:(NSString *)tintColor
{
    LWImageColorItem *item = [self lw_tintColorItem] ?: [LWImageColorItem new];
    item.image = image;
    item.tintColorKey = tintColor;
    if (tintColor.length) {
        UIColor *color = [self lw_colorForPattern:tintColor];
        self.image = [LWImageUtils fillImage:image withColor:color];
    } else {
        self.image = image;
    }
    [self lw_storeValue:item forSetter:@selector(lw_setTintColorItem:)];
}

#pragma mark - Apply

- (LWImageColorItem *)lw_tintColorItem
{
    return (LWImageColorItem *)[self lw_valueForSetter:@selector(lw_setTintColorItem:)];
}

- (void)lw_setTintColorItem:(LWImageColorItem *)item
{
    if (item.image && item.tintColorKey.length) {
        UIColor *color = [self lw_colorForPattern:item.tintColorKey];
        UIImage *image = [LWImageUtils fillImage:item.image withColor:color];
        [self setImage:image];
    }
}

@end

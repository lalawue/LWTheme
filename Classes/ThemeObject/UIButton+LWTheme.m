//
//  UIButton+LWTheme.m
//  LWTheme
//
//  Created by lalawue on 2019/12/11.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import "UIButton+LWTheme.h"
#import "LWTheme_Tools.h"

@interface LWButtonImageColorItem : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, copy) NSString *imageTintColorKey;
@property (nonatomic, copy) NSString *backgroundImageTintColorKey;
@end

@implementation LWButtonImageColorItem
@end

#pragma mark -

@implementation UIButton (LWTheme)

- (void)lw_setTitleColor:(NSString *)colorPattern forState:(UIControlState)state
{
    NSMutableDictionary *dict = [self lw_getTitleColorDict] ?: [NSMutableDictionary dictionaryWithCapacity:2];
    if (colorPattern) {
        [dict setObject:colorPattern forKey:@(state)];
    } else {
        [dict removeObjectForKey:@(state)];
    }
    UIColor *colorValue = [self lw_colorForPattern:colorPattern];
    if (colorValue) {
        [self setTitleColor:colorValue forState:state];
    }
    [self lw_storeValue:dict forSetter:@selector(lw_setTitleColorDict:)];
}

- (NSString *)lw_titleColorForState:(UIControlState)state
{
    NSDictionary *dict = [self lw_getTitleColorDict];
    return [dict objectForKey:@(state)];
}

- (void)lw_setImage:(UIImage *)image withTintColor:(NSString *)tintColor forState:(UIControlState)state
{
    NSNumber *stateKey = @(state);
    NSMutableDictionary *dict = [self lw_getImageStateDict] ?: [NSMutableDictionary dictionaryWithCapacity:2];
    LWButtonImageColorItem *item = dict[stateKey] ?: [LWButtonImageColorItem new];
    
    item.image = image;
    item.imageTintColorKey = tintColor;
    
    dict[stateKey] = item;
    
    if (image) {
        UIColor *color = [self lw_colorForPattern:tintColor];
        image = [LWImageUtils fillImage:image withColor:color];
    }
    [self setImage:image forState:state];
    [self lw_storeValue:dict forSetter:@selector(lw_setImageForStateDict:)];
}

- (void)lw_setBackgroundImage:(UIImage *)image withTintColor:(NSString *)tintColor forState:(UIControlState)state
{
    NSNumber *stateKey = @(state);
    NSMutableDictionary *dict = [self lw_getImageStateDict] ?: [NSMutableDictionary dictionaryWithCapacity:2];
    LWButtonImageColorItem *item = dict[stateKey] ?: [LWButtonImageColorItem new];
    
    item.backgroundImage = image;
    item.backgroundImageTintColorKey = tintColor;

    dict[stateKey] = item;

    if (image) {
        UIColor *color = [self lw_colorForPattern:tintColor];
        image = [LWImageUtils fillImage:image withColor:color];
    }
    [self setBackgroundImage:image forState:state];
    [self lw_storeValue:dict forSetter:@selector(lw_setImageForStateDict:)];
}

#pragma mark - Apply

// title color
- (void)lw_setTitleColorDict:(NSMutableDictionary *)dict
{
    NSArray *array = [dict.allKeys copy];
    for (NSNumber *stateKey in array) {
        NSString *colorPattern = dict[stateKey];
        UIColor *colorValue = [self lw_colorForPattern:colorPattern];
        if (colorValue) {
            UIControlState state = [stateKey unsignedIntegerValue];
            [self setTitleColor:colorValue forState:state];
        }
    }
}

- (NSMutableDictionary *)lw_getTitleColorDict
{
    return (NSMutableDictionary *)[self lw_valueForSetter:@selector(lw_setTitleColorDict:)];
}

// image tint color state
- (void)lw_setImageForStateDict:(NSDictionary *)dict
{
    NSArray *array = [dict.allKeys copy];
    for (NSNumber *stateKey in array) {
        UIControlState state = [stateKey unsignedIntegerValue];
        LWButtonImageColorItem *item = dict[stateKey];
        // set tint image
        if (item.image && item.imageTintColorKey.length) {
            UIColor *colorValue = [self lw_colorForPattern:item.imageTintColorKey];
            [self setImage:[LWImageUtils fillImage:item.image withColor:colorValue]
                  forState:state];
        }
        // set tint background image
        if (item.backgroundImage && item.backgroundImageTintColorKey.length) {
            UIColor *colorValue = [self lw_colorForPattern:item.backgroundImageTintColorKey];
            [self setBackgroundImage:[LWImageUtils fillImage:item.backgroundImage withColor:colorValue]
                            forState:state];
        }
    }
}

- (NSMutableDictionary *)lw_getImageStateDict
{
    return (NSMutableDictionary *)[self lw_valueForSetter:@selector(lw_setImageForStateDict:)];
}

@end

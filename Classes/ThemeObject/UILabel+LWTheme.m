//
//  UILabel+LWTheme.m
//  LWTheme
//
//  Created by lalawue on 2019/12/12.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import "UILabel+LWTheme.h"
#import "LWTheme_Tools.h"

@implementation UILabel (LWTheme)

- (void)setLw_textColor:(NSString *)lw_textColor
{
    UIColor *color = [self lw_colorForPattern:lw_textColor];
    if (color) {
        self.textColor = color;
        [self lw_storeValue:lw_textColor forSetter:_cmd];
    }
}

- (NSString *)lw_textColor
{
    return [self lw_valueForSetter:@selector(setLw_textColor:)];
}

- (void)setLw_font:(NSString *)lw_font
{
    self.font = [self lw_fontForPattern:lw_font];
    [self lw_storeValue:lw_font forSetter:@selector(setLw_font:)];
}

- (NSString *)lw_font
{
    return (NSString *)[self lw_valueForSetter:@selector(setLw_font:)];
}

- (void)lw_setAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range
{
    if (attrs.count <= 0) {
        return;
    }
    
    NSString *rangeKey = NSStringFromRange(range);
    
    NSMutableDictionary<NSString *, NSDictionary *> *lwAttrs = [self lw_getAttrs] ?: [NSMutableDictionary dictionaryWithCapacity:2];
    [lwAttrs setObject:attrs forKey:rangeKey];
    [self lw_storeValue:lwAttrs forSetter:@selector(lw_setAttrs:)];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attrString setAttributes:[LWAttributedStringUtils lw_mapAttrs:attrs] range:range];
    self.attributedText = attrString;
}

#pragma mark - Apply

- (void)lw_setAttrs:(NSMutableDictionary<NSString *, NSDictionary *> *)rangeAttrs
{
    if (rangeAttrs.count <= 0) {
        return;
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    for (NSString *rangeKey in rangeAttrs.allKeys) {
        NSDictionary *attrs = rangeAttrs[rangeKey];
        [attrString setAttributes:[LWAttributedStringUtils lw_mapAttrs:attrs] range:NSRangeFromString(rangeKey)];
    }
    self.attributedText = attrString;
}

- (NSMutableDictionary<NSAttributedStringKey, NSArray*> *)lw_getAttrs
{
    return [self lw_valueForSetter:@selector(lw_setAttrs:)];
}

@end

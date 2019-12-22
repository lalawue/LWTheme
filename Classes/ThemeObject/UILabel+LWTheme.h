//
//  UILabel+LWTheme.h
//  LWTheme
//
//  Created by lalawue on 2019/12/12.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LWTheme)

@property (nonatomic, copy) NSString *lw_textColor;

@property (nonatomic, copy) NSString *lw_font; ///< '[_|bold|italic|fontName]:fontSize'

// set attributes to self.attributedText
- (void)lw_setAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range;

@end

NS_ASSUME_NONNULL_END

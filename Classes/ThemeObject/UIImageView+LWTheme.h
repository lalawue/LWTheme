//
//  UIImageView+LWTheme.h
//  LWTheme
//
//  Created by lalawue on 2019/12/13.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (LWTheme)

@property (nonatomic, copy) NSString *lw_imageName;

- (void)lw_setImage:(UIImage *)image withTintColor:(NSString *)tintColor;

@end

NS_ASSUME_NONNULL_END

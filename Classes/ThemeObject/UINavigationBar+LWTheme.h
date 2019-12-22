//
//  UINavigationBar+LWTheme.h
//  LWTheme
//
//  Created by lalawue on 2019/12/14.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (LWTheme)

@property (null_resettable, nonatomic, copy) NSString *lw_tintColor;

@property (nullable, nonatomic, copy) NSString *lw_barTintColor NS_AVAILABLE_IOS(7_0);

@end

NS_ASSUME_NONNULL_END

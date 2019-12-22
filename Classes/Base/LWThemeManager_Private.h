//
//  LWThemeManager_Private.h
//  LWTheme
//
//  Created by lalawue on 2019/12/10.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import "LWThemeManager.h"
#import "NSObject+LWTheme.h"

@interface LWThemeManager (Notifier)

- (void)addThemeObject:(id<LWThemeObjectNotify>)object;

- (void)removeThemeObject:(id)object;

@end

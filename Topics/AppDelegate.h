//
//  AppDelegate.h
//  Topics
//
//  Created by Max Wang on 5/6/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunLoop/RunLoopSource.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)registerSource:(RunLoopContext*)sourceInfo;
- (void)removeSource:(RunLoopContext*)sourceInfo;

@end



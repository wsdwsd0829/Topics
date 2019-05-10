//
//  OrientationViewController.m
//  Topics
//
//  Created by Max Wang on 5/7/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "OrientationViewController.h"

#import "BaseWindow.h"

@interface OrientationViewController ()

@end

@implementation OrientationViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self start];

  [self setNeedsStatusBarAppearanceUpdate]; // Hide Status Bar: Step 1.
}

- (BOOL)prefersStatusBarHidden {
  return YES; // Hide Status Bar: Step 2.
}

- (void)start {
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(deviceOrientationChanged:)
                                               name:UIDeviceOrientationDidChangeNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(interfaceOrientationChanged:)
                                               name:UIApplicationDidChangeStatusBarOrientationNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(appDidBecomeActive:)
                                               name:UIApplicationDidBecomeActiveNotification
                                             object:nil];
  [self interfaceOrientationChanged:nil];
}

- (void)stop {
  [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)appDidBecomeActive:(NSNotification *)notification {
  if ([notification.object isKindOfClass:[UIApplication class]]) {

  }
}

- (void)dealloc {
  [self stop];
}

#pragma mark Private Methods

// This information about device *before* window frame is changed.
- (void)deviceOrientationChanged:(NSNotification *)notification {
  // The window size is not changed yet in current runloop
  // even though device orientation is changed;
  //NSLog(@"orientation Changed: %@", notification);
  UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
  switch (orientation) {
    case UIDeviceOrientationFaceUp: {
      NSLog(@"UIDeviceOrientationFaceUp");
      break;
    }
    case UIDeviceOrientationFaceDown: {
      NSLog(@"UIDeviceOrientationFaceDown");
      break;
    }
    case UIDeviceOrientationLandscapeLeft: {
      NSLog(@"UIDeviceOrientationLandscapeLeft");
      break;
    }
    case UIDeviceOrientationLandscapeRight: {
      NSLog(@"UIDeviceOrientationLandscapeRight");
      break;
    }
    case UIDeviceOrientationPortrait: {
      NSLog(@"UIDeviceOrientationPortrait");
      break;
    }
    case UIDeviceOrientationPortraitUpsideDown: {
      NSLog(@"UIDeviceOrientationPortraitUpsideDown");
      break;
    }
    case UIDeviceOrientationUnknown: {
      NSLog(@"UIDeviceOrientationUnknown");
      [self interfaceOrientationChanged:notification];
      break;
    }
  }
}

// This information is on the app *after* window frame is changed.
- (void)interfaceOrientationChanged:(NSNotification *)notification {
  UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
  switch (interfaceOrientation) {
    case UIInterfaceOrientationPortrait:
     NSLog(@"UIInterfaceOrientationPortrait");
      break;
    case UIInterfaceOrientationPortraitUpsideDown:
      NSLog(@"UIInterfaceOrientationPortraitUpsideDown");
      break;
    case UIInterfaceOrientationLandscapeLeft:
      NSLog(@"UIInterfaceOrientationLandscapeLeft");
      break;
    case UIInterfaceOrientationLandscapeRight:
      NSLog(@"UIInterfaceOrientationLandscapeRight");
      break;
    case UIInterfaceOrientationUnknown:
      NSLog(@"UIInterfaceOrientationLandscapeUnknown");
      break;
  }
}

@end

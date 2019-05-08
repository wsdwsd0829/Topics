//
//  RunLoopViewController.m
//  Topics
//
//  Created by Max Wang on 5/6/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()

@end

typedef void (* myRunLoopObserver)(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info);

/*
 Why this is called?
 myObserver 1
 myObserver 2
 myObserver 4
 myObserver 32
 myObserver 64
 myObserver 2
 myObserver 4
 myObserver 128
 myObserver 1
 myObserver 2
 myObserver 4
 myObserver 32
 myObserver 64
 myObserver 2
 myObserver 4
 myObserver 32
 myObserver 64
 myObserver 128
 */
void myObserver(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
  printf("myObserver %lu \n", activity);
}

@implementation RunLoopViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self createRunLoopObserver];
  [self runRunLoop];
}

// TODO: use this in background thread and add timer on it.
- (void)createRunLoopObserver {
  NSRunLoop *runloop = [NSRunLoop currentRunLoop];
  CFRunLoopObserverContext context = { 0, (__bridge void *)(self), NULL, NULL, NULL };
  CFRunLoopObserverRef observer =  CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &myObserver, &context);
  if (observer)
  {
    CFRunLoopRef cfLoop = [runloop getCFRunLoop];
    CFRunLoopAddObserver(cfLoop, observer, kCFRunLoopDefaultMode);
    [self runRunLoop];
    CFRunLoopRemoveObserver(cfLoop, observer, kCFRunLoopDefaultMode);
  }
}

- (void)runRunLoop {
  NSInteger loopCount = 1;
  do
  {
    // Run the run loop: This is blocking the RunLoopViewController from being pushed for 1 second.
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    loopCount--;
  }
  while (loopCount);
}

@end

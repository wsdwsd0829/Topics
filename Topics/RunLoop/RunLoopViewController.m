//
//  RunLoopViewController.m
//  Topics
//
//  Created by Max Wang on 5/6/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "RunLoopViewController.h"
#import "RunLoopSource.h"

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
//  [self runRunLoop];
//  [self runRunLoop2];
  [self runLoopSource];
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
  NSLog(@"runRunLoop");
  NSInteger loopCount = 1;
  do
  {
    // Run the run loop: This is blocking the RunLoopViewController from being pushed for 1 second.
    // Then runloop that run here will exit.
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    loopCount--;
  }
  while (loopCount);
}

// 05.08
- (void)runRunLoop2 {
  NSLog(@"runRunLoop2");
  BOOL done = NO;
  do {
    // Start the run loop but return after each source is handled.
    // This is blocking.
    SInt32 result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 2, YES);

    // If a source explicitly stopped the run loop, or if there are no
    // sources or timers, go ahead and exit.
    if ((result == kCFRunLoopRunStopped) || (result == kCFRunLoopRunFinished)) {
      done = YES;
    } else {

    }
  }
  while (!done);
}

#pragma mark RunLoopSource

- (void)runLoopSource {
  RunLoopSource *source = [[RunLoopSource alloc] init];
  //This will work!
  [source addToCurrentRunLoop];
  [source addCommand:1 withData:nil];
  // note all of them will fire together cause it's current runloop if not dipatch to main.
  // will fire at next runloop?
  [source fireAllCommandsOnRunLoop:CFRunLoopGetCurrent()];

  // Why this not working?! may be the thread is gone when block finishes.
  // TODO try create a thread & see how Texture uses runloop.
  // ASDK use thread pool
  // Runloop use the thread it's created on.
  /*
  __block CFRunLoopRef ref;
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    ref = CFRunLoopGetCurrent();
    RunLoopSource *source2 = [[RunLoopSource alloc] init];
    [source2 addToCurrentRunLoop];
    [source2 addCommand:2 withData:nil];
    [source2 fireAllCommandsOnRunLoop:ref];
  });
  */

}

@end

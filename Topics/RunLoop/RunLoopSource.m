//
//  RunLoopSource.m
//  Topics
//
//  Created by Max Wang on 5/20/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "RunLoopSource.h"
#import "AppDelegate.h"

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode) {
  NSLog(@"!!!! RunLoopSourceScheduleRoutine");

  AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
  RunLoopSource *obj = (RunLoopSource *)CFBridgingRelease(info);
  RunLoopContext *theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];
  [del performSelectorOnMainThread:@selector(registerSource:)
                        withObject:theContext waitUntilDone:NO];
}
void RunLoopSourcePerformRoutine (void *info) {
  NSLog(@"!!!! RunLoopSourcePerformRoutine");
  RunLoopSource* obj = (__bridge RunLoopSource*)info;
  [obj sourceFired];
}
void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode) {
  NSLog(@"!!!! RunLoopSourceCancelRoutine");
  RunLoopSource* obj = (RunLoopSource*)CFBridgingRelease(info);
  AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
  RunLoopContext* theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];

  [del performSelectorOnMainThread:@selector(removeSource:)
                        withObject:theContext waitUntilDone:YES];
}

@implementation RunLoopSource

- (id)init {
  if (self = [super init]) {
    CFRunLoopSourceContext context = {0, (void *)CFBridgingRetain(self), NULL, NULL, NULL, NULL, NULL,
      &RunLoopSourceScheduleRoutine,
      &RunLoopSourceCancelRoutine,
      &RunLoopSourcePerformRoutine};
    runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
    commands = [[NSMutableArray alloc] init];
    return self;
  }
  return nil;
}

- (void)addToCurrentRunLoop {
  CFRunLoopRef runLoop = CFRunLoopGetCurrent();
  CFRunLoopAddSource(runLoop, runLoopSource, kCFRunLoopDefaultMode);
}

- (void)invalidate {
  CFRunLoopSourceInvalidate(runLoopSource);
}

// Handler method
- (void)sourceFired {
  for (NSNumber *cmd in commands) {
    NSLog(@"firing %@", cmd);
  }
  [commands removeAllObjects];
}

// Client interface for registering commands to process
- (void)addCommand:(NSInteger)command withData:(id)data {
  [commands addObject:[NSNumber numberWithInteger:command]];
}


- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop {
  CFRunLoopSourceSignal(runLoopSource);
  CFRunLoopWakeUp(runloop);
}

@end

@implementation RunLoopContext : NSObject

- (id)initWithSource:(RunLoopSource*)src andLoop:(CFRunLoopRef)loop {
  if (self = [super init]) {
    _runLoop = loop;
    _source = src;
    return self;
  }
  return nil;
}

@end


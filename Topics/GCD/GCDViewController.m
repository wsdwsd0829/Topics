//
//  GCDViewController.m
//  Topics
//
//  Created by Max Wang on 5/17/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "GCDViewController.h"

void timerSourceHandle() {
  printf("handling source");
}

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [self serialQueue];
  [self dispatchSource];

}

- (void)dispatchSource {
  __block int counter = 0;
  dispatch_queue_t q = dispatch_queue_create("source queu", DISPATCH_QUEUE_SERIAL); //DISPATCH_QUEUE_CONCURRENT
  dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, q);
  dispatch_source_set_timer(source, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
  dispatch_source_set_event_handler(source, ^{
    printf("handle timer %d \n", counter);
    counter += 1;
    if (counter == 5) {
      dispatch_source_cancel(source);
    }
  });
  dispatch_resume(source);
}

- (void)serialQueue {
  // Serail queue exec one after another, dispatch_async will do work in background thread.
  // Mutiple async will not mix each other's work together.
  dispatch_queue_t q = dispatch_queue_create("serial queue", DISPATCH_QUEUE_SERIAL); //DISPATCH_QUEUE_CONCURRENT
  dispatch_async(q, ^{
    for (int i = 0; i < 100; i++) {
      NSLog(@"Async execute 11111 %d", i);
    }
  });
  dispatch_async(q, ^{
    for (int i = 0; i < 100; i++) {
      NSLog(@"Async execute 22222 %d", i);
    }
  });

  dispatch_sync(q, ^{
    for (int i = 0; i < 100; i++) {
      NSLog(@"Sync execute 33333 %d", i);
    }
  });
  NSLog(@"Done!!!!!!");
}



@end

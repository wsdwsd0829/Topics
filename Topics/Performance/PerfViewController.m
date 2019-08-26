//
//  PerfViewController.m
//  Topics
//
//  Created by Max Wang on 5/19/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "PerfViewController.h"
#import <sys/kdebug_signpost.h>

@protocol FakeProtocol <NSObject>
- (void)fakeMethod;
@end

@interface FakeObj : NSObject <FakeProtocol>
- (void)fakeMethod;
@end
@implementation FakeObj
- (void)fakeMethod {
//  NSLog(@"^^^ calling fake Method");
}
@end

@interface PerfViewController ()

@end

@implementation PerfViewController {
  FakeObj *_fakeObj;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _fakeObj = [[FakeObj alloc] init];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
  [self testCallingToConformToProtocolALot];
  sleep(5);
  [self callFakeMethod];
}

- (void)callFakeMethod {
  for (int i = 0; i < 1000; i++) {
    kdebug_signpost_start(1001, 0, 0, 0, 0);
    _fakeObj = [[FakeObj alloc] init];
    [_fakeObj fakeMethod];
    kdebug_signpost_end(1001, 0, 0, 0, 0);
  }
}

// weak pointer, conformsToProtocol? => TODO: objc4 source code
- (void)testCallingToConformToProtocolALot {
  for (int i = 0; i < 1000; i++) {
    kdebug_signpost_start(1000, 0, 0, 0, 0);
//    kdebug_signpost_start(999, 0, 0, 0, 0);
    _fakeObj = [[FakeObj alloc] init];
    if ([_fakeObj conformsToProtocol:@protocol(FakeProtocol)]) {
//      kdebug_signpost_end(999, 0, 0, 0, 0);
      [(id<FakeProtocol>)_fakeObj fakeMethod];
    }
    kdebug_signpost_end(1000, 0, 0, 0, 0);
  }
}


@end

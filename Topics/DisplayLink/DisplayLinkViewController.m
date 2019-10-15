//
//  DisplayLinkViewController.m
//  Topics
//
//  Created by Max Wang on 10/2/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "DisplayLinkViewController.h"

@interface DisplayLinkViewController ()

@end

@implementation DisplayLinkViewController {
  CADisplayLink *_displayLink;
  NSThread *_thread;

}

- (void)viewDidLoad {
    [super viewDidLoad];
  _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fire:)];
//  [self->_displayLink addToRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
  _thread = [[NSThread alloc] initWithBlock:^{
    [self->_displayLink addToRunLoop: [NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self->_displayLink.frameInterval = 1;
    self->_displayLink.paused = NO;
    CFRunLoopRun();
  }];
  [_thread start];
  [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer * _Nonnull timer) {
//    [_displayLink invalidate];
    _displayLink.paused = YES;
    NSLog(@"%@, %@, %@", _thread.executing ? @"Executing":@"No E", _thread.finished ? @"Finished" : @"No Finished", _thread.cancelled ? @"Cancelled" : @"Not Cancelled");
  }];
    [NSTimer scheduledTimerWithTimeInterval:4 repeats:NO block:^(NSTimer * _Nonnull timer) {
  //    [_displayLink invalidate];
      [_displayLink invalidate];
      [_thread cancel];

      NSLog(@"%@, %@, %@", _thread.executing ? @"Executing":@"No E", _thread.finished ? @"Finished" : @"No Finished", _thread.cancelled ? @"Cancelled" : @"Not Cancelled");
    }];
  [NSTimer scheduledTimerWithTimeInterval:16 repeats:NO block:^(NSTimer * _Nonnull timer) {
  //    [_displayLink invalidate];
      [_displayLink invalidate];
      [_thread cancel];

      NSLog(@"%@, %@, %@", _thread.executing ? @"Executing":@"No E", _thread.finished ? @"Finished" : @"No Finished", _thread.cancelled ? @"Cancelled" : @"Not Cancelled");
    }];
}

- (void)fire:(CADisplayLink *)displayLink {
  NSLog(@"!!!! displayLink fired");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

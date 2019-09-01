//
//  KeyboardTypeViewController.m
//  Topics
//
//  Created by Max Wang on 9/1/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "KeyboardTypeViewController.h"

@interface KeyboardTypeViewController () <UITextFieldDelegate>

@end

@implementation KeyboardTypeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.edgesForExtendedLayout = UIRectEdgeNone;

  // Do any additional setup after loading the view.
  UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
  UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 200, 200, 200)];

  [self.view addSubview:textField];
  [self.view addSubview:textView];

  textField.backgroundColor = [UIColor blueColor];
  textView.backgroundColor = [UIColor yellowColor];

  textField.delegate = self;

  textField.keyboardType = UIKeyboardTypeNumberPad;
  textView.keyboardType = UIKeyboardTypePhonePad; // With extra + * # than number.

  textField.returnKeyType = UIReturnKeyJoin; // work when keyboard type it's number;
  textView.returnKeyType = UIReturnKeyNext;

  textField.keyboardAppearance = UIKeyboardAppearanceDark;
  textView.keyboardAppearance = UIKeyboardAppearanceLight;

  if (@available(iOS 10.0, *)) {
    // This works only on device, for example: UITextContentTypeTelephoneNumber will should your number on top content are of keyboard.
    textField.textContentType = UITextContentTypeAddressCity;

  } else {
    // Fallback on earlier versions
  }
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason  API_AVAILABLE(ios(10.0)){
  NSLog(@"^^^^ didEndEditing: %@", textField.text);
}




@end

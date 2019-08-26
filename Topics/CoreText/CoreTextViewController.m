//
//  CoreTextViewController.m
//  Topics
//
//  Created by Max Wang on 8/25/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "CoreTextViewController.h"

@interface CoreTextViewController ()

@end

@implementation CoreTextViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSString *str = @"1. HelloWorld!!!\n"
  "2. Hello World!!!\n"
  "3. Hello World!!!\n"
  "4. Hello World!!!\n"
  "5. Hello World!!!\n"
  "6. Hello World!!!\n";
  NSTextAttachment *ta = [[NSTextAttachment alloc] init];
  ta.image = [UIImage imageNamed:@"settings"];
  NSAttributedString *attachment = [NSAttributedString attributedStringWithAttachment:ta];

  UIFont *arialFont = [UIFont fontWithName:@"arial" size:18.0];
  UIFont *arialFont30 = [UIFont fontWithName:@"arial" size:30.0];
  NSDictionary *attrs = @{ NSFontAttributeName:arialFont };

  NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:str attributes:attrs];
  [result addAttribute:NSFontAttributeName value:arialFont30 range:NSMakeRange(3, 5)];

  [result replaceCharactersInRange:NSMakeRange(2, 0) withAttributedString:attachment];

  UITextView *textView = [[UITextView alloc] init];
  textView.attributedText = result;
  textView.frame = CGRectMake(10, 10, 300, 300);
  [self.view addSubview:textView];

  UILabel *label = [[UILabel alloc] init];
  label.attributedText = result;
  label.numberOfLines = 0;
  label.frame = CGRectMake(10, 310, 300, 400);
  [self.view addSubview:label];

  CTFrame
}

@end

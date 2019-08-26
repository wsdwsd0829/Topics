//
//  CoreTextViewController.m
//  Topics
//
//  Created by Max Wang on 8/25/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "CoreTextViewController.h"
#import <CoreText/CoreText.h>
#import "CoreTextView.h"

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

//  [result replaceCharactersInRange:NSMakeRange(2, 0) withAttributedString:attachment];

  UITextView *textView = [[UITextView alloc] init];
  textView.attributedText = result;
  textView.frame = CGRectMake(10, 10, 300, 300);
  [self.view addSubview:textView];



  CGRect frame = CGRectMake(10, 310, 400, 100);

  // Get FrameSetter
  CTFramesetterRef ctFrameSetter = CTFramesetterCreateWithAttributedString((__bridge_retained CFMutableAttributedStringRef)result);

  // Get Frame
  CGPathRef pathRef = CGPathCreateWithRect(frame, NULL);
  CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRangeMake(0, result.length), pathRef, nil);
  CFRange range = CTFrameGetStringRange(ctFrame);
  CFRange visiblerange = CTFrameGetVisibleStringRange(ctFrame); //correct but assuming attachment take no space???

  CFRange *fitRange = calloc(1, sizeof(CFRange));
  CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(ctFrameSetter, CFRangeMake(0, result.length), NULL, CGSizeMake(100, 100), fitRange); // Fit range not correct?
  NSLog(@"Suggested Frame: %@", NSStringFromCGSize(size));

  // Get Lines
  CFArrayRef ctLines = CTFrameGetLines(ctFrame);
  long linesCount = CFArrayGetCount(ctLines); //correct.

  // CGPoint *points = (CGPoint *)calloc(linesCount, sizeof(CGPoint)); //calloc not working????
  CGPoint *points = (CGPoint *)malloc(linesCount * sizeof(CGPoint));
  CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, result.length), points);
  for (int i = 0; i< linesCount; i++) {
    CGPoint origin = points[i];
    NSLog(@"Origin %d: %@", i, NSStringFromCGPoint(origin));
  }

  for (int i = 0; i < linesCount; i++) {
    CTLineRef ctLine = (CTLineRef)CFArrayGetValueAtIndex(ctLines, i);
    CFArrayRef ctRuns = CTLineGetGlyphRuns(ctLine);
  }

  CoreTextView *coreTextView = [[CoreTextView alloc] init];
  coreTextView.frame = CGRectMake(10, 310, 400, 400); //frame
  coreTextView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:coreTextView];

//  UILabel *label = [[UILabel alloc] init];
//  label.attributedText = result;
//  label.numberOfLines = 0;
//  label.frame = frame;
//  [self.view addSubview:label];
//  label.backgroundColor = [UIColor greenColor];

  // CTLine practice
  NSAttributedString *abcde = [[NSAttributedString alloc] initWithString:@"aaaaabbbbbcccccdddddeeeee" attributes:attrs];
  CTLineRef abcdeLine = CTLineCreateWithAttributedString((__bridge_retained CFAttributedStringRef)abcde);
  CTLineRef truncationTokenLine = CTLineCreateWithAttributedString((__bridge_retained CFAttributedStringRef)[[NSAttributedString alloc] initWithString:@"..." attributes:attrs]);
  CTLineRef truncatedLine = CTLineCreateTruncatedLine(abcdeLine, 50, kCTLineTruncationMiddle, truncationTokenLine);
  NSLog(@"line glyph count %d, %d", CTLineGetGlyphCount(abcdeLine), CTLineGetGlyphCount(truncatedLine));
  CFRange truncatedLineRange = CTLineGetStringRange(truncatedLine);
  CFArrayRef ctRuns = CTLineGetGlyphRuns(truncatedLine);
  CGFloat ascent, descent, leading;
  int width = CTLineGetTypographicBounds(truncatedLine, &ascent, &descent, &leading);
  int trailingWhiteSpaceWidth = CTLineGetTrailingWhitespaceWidth(abcdeLine); // return 0 nomatter what???

  for (int i = 0; i < CFArrayGetCount(ctRuns); i++) {
    CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(ctRuns, i);
    long glyphCountForRun = CTRunGetGlyphCount(run);
    double width = CTRunGetTypographicBounds(run, CFRangeMake(0, glyphCountForRun), nil, nil, nil);
    NSLog(@"glyphcount for run %d %f", glyphCountForRun, width);
  }

}


@end

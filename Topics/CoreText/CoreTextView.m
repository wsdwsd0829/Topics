//
//  CoreTextView.m
//  Topics
//
//  Created by Max Wang on 8/26/19.
//  Copyright © 2019 Max. All rights reserved.
//

#import "CoreTextView.h"
#import <CoreText/CoreText.h>
#import <CoreGraphics/CoreGraphics.h>

@implementation CoreTextView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGRect frame = self.bounds; //CGRectMake(10, 310, 200, 100);will not work //!!!

  CGContextSetTextMatrix(context,
                         CGAffineTransformIdentity);
  CGContextTranslateCTM(context, 0, frame.size.height);
  CGContextScaleCTM(context, 1.0, -1.0);

  NSAttributedString *abcde = [[NSAttributedString alloc] initWithString:@"aaaaabbbbbcccccdddddeeeee\n" attributes:nil];
  CTLineRef abcdeLine = CTLineCreateWithAttributedString((__bridge_retained CFAttributedStringRef)abcde);
  CTLineRef truncationTokenLine = CTLineCreateWithAttributedString((__bridge_retained CFAttributedStringRef)[[NSAttributedString alloc] initWithString:@"..." attributes:nil]);
  CTLineRef truncatedLine = CTLineCreateTruncatedLine(abcdeLine, 50, kCTLineTruncationMiddle, truncationTokenLine);
  NSLog(@"line glyph count %d, %d", CTLineGetGlyphCount(abcdeLine), CTLineGetGlyphCount(truncatedLine));
  CFRange truncatedLineRange = CTLineGetStringRange(truncatedLine);
  CFArrayRef ctRuns = CTLineGetGlyphRuns(truncatedLine);
  CTLineDraw(truncatedLine, context); //why this is drawing to bottom?? which is different from FrameDraw


  [[UIColor blackColor] setStroke];
  [[UIColor greenColor] setFill];



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
  NSDictionary *attrs = @{ NSFontAttributeName:arialFont,
                            NSForegroundColorAttributeName: [UIColor blueColor]
                           };

  NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:str attributes:attrs];
  [result addAttribute:NSFontAttributeName value:arialFont30 range:NSMakeRange(3, 5)];

  //  [result replaceCharactersInRange:NSMakeRange(2, 0) withAttributedString:attachment];

  CTFramesetterRef ctFrameSetter = CTFramesetterCreateWithAttributedString((__bridge_retained CFMutableAttributedStringRef)result);



  CGPathRef pathRef = CGPathCreateWithRect(frame, NULL);
  CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRangeMake(0, result.length), pathRef, nil);
  CTFrameDraw(ctFrame, context); // Well, not working as expected.


  CGContextRestoreGState(context);
}



@end

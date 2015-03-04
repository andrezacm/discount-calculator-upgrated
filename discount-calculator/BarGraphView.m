//
//  BarGraphView.m
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 2/28/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BarGraphView.h"

@implementation BarGraphView

  @synthesize discountPercent;
  @synthesize savedPercent;
  @synthesize originalPrice;
  @synthesize discount;
  @synthesize saved;

-(id)initWithFrame:(CGRect)frame {
  NSLog(@"initWithFrame");
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
  NSLog(@"initWithCoder");
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Initialization code
  }
  return self;
}

-(void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  //set colors
  CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
  CGContextSetLineWidth(context, 2.0);
  
  //price
  CGRect priceRect = CGRectMake(40, 100, 100, 300);
  CGContextStrokeRect(context, priceRect);
  
  //price - discount price
  float savedHeight = (300 * [savedPercent floatValue]);
  CGRect savedRect = CGRectMake(180, 100, 100, savedHeight);
  CGContextStrokeRect(context, savedRect);
  
  //discount price
  CGRect discountRect = CGRectMake(180, (100 + savedHeight), 100, (300 * [discountPercent floatValue]));
  CGContextStrokeRect(context, discountRect);
  
  NSDecimalNumber * percent = [NSDecimalNumber decimalNumberWithString:@"100"];
  
  [self drawString:originalPrice withRect:priceRect isSaved:NO];
  
  
  NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
  [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
  [numberFormatter setMaximumFractionDigits:2];
  [numberFormatter setMinimumFractionDigits:2];
  [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
  
  NSString * discountP = [numberFormatter stringFromNumber:[discountPercent decimalNumberByMultiplyingBy:percent]];
  NSString * savedP    = [numberFormatter stringFromNumber:[savedPercent decimalNumberByMultiplyingBy:percent]];
  
  NSString * sDiscount = [[[discount stringByAppendingString:@"\n"]
                                     stringByAppendingString:discountP]
                                     stringByAppendingString:@"%"];
  [self drawString:sDiscount withRect:discountRect isSaved:NO];
  
  NSString * sSaved = [[[saved stringByAppendingString:@"\n"]
                               stringByAppendingString:savedP]
                               stringByAppendingString:@"%"];
  [self drawString:sSaved withRect:savedRect isSaved:YES];
}

-(void)drawString:(NSString *)s withRect:(CGRect)rect isSaved:(BOOL)saved {
  if (saved && [savedPercent floatValue] < 0.35) {
    NSDictionary * textAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:12]};
    [s drawInRect:rect withAttributes:textAttributes];
  } else {
    NSDictionary * textAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:14]};
    CGSize size = [s sizeWithAttributes:textAttributes];
    
    CGRect textRect = CGRectMake((rect.origin.x + 4),
                                 rect.origin.y + (rect.size.height - size.height)/2,
                                 rect.size.width,
                                 (rect.size.height - size.height)/2);
    
    [s drawInRect:textRect withAttributes:textAttributes];
  }
}

@end
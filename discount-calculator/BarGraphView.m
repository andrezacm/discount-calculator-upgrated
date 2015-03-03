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
  
  NSString * sPrice = [@"$ " stringByAppendingString:[originalPrice stringValue]];
  [self drawString:sPrice withRect:priceRect];
  
  NSString * sDiscount = [[[[@"$ " stringByAppendingString:[discount stringValue]]
                                   stringByAppendingString:@"\n"]
                                   stringByAppendingString:[[discountPercent decimalNumberByMultiplyingBy:percent] stringValue]]
                                   stringByAppendingString:@"%"];
  [self drawString:sDiscount withRect:discountRect];
  
  NSString * sSaved = [[[[@"$ " stringByAppendingString:[saved stringValue]]
                                stringByAppendingString:@"\n"]
                                stringByAppendingString:[[savedPercent decimalNumberByMultiplyingBy:percent] stringValue]]
                                stringByAppendingString:@"%"];
  [self drawString:sSaved withRect:savedRect];
}

-(void)drawString:(NSString *)s withRect:(CGRect)rect {
  NSDictionary * textAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:18]};
  CGSize size = [s sizeWithAttributes:textAttributes];
  
  CGRect textRect = CGRectMake((rect.origin.x + 4),
                               rect.origin.y + (rect.size.height - size.height)/2,
                               rect.size.width,
                               (rect.size.height - size.height)/2);
  
  [s drawInRect:textRect withAttributes:textAttributes];
}

@end
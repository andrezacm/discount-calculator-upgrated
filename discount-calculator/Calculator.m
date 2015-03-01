//
//  Calculator.m
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 2/27/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculator.h"

//static instance to implement singleton pattern
Calculator * calculator = nil;

@implementation Calculator

  @synthesize price;
  @synthesize dollarsOff;
  @synthesize discount;
  @synthesize discountAdd;
  @synthesize tax;
  @synthesize originalPrice;
  @synthesize finalPrice;
  @synthesize discountPrice;

+(Calculator *)initialize {
  if (calculator == nil) {
    calculator = [[self alloc] init];
  }
  return calculator;
}

-(void)setPrice:(NSDecimalNumber *)p {
  price = p;
}

-(void)setDollarsOff:(NSDecimalNumber *)d {
  dollarsOff = d;
}

-(void)setDiscount:(NSDecimalNumber *)d {
  discount = d;
}

-(void)setDiscountAdd:(NSDecimalNumber *)d {
  discountAdd = d;
}

-(void)setTax:(NSDecimalNumber *)t {
  tax = t;
}

-(NSDecimalNumber *)finalPrice {
  return finalPrice;
}

-(NSDecimalNumber *)originalPrice {
  return originalPrice;
}

-(NSDecimalNumber *)discountPrice {
  return discountPrice;
}

-(void)calculateOriginalPrice {
  //calculate tax
  NSDecimalNumber * taxValue = [price decimalNumberByMultiplyingBy:[tax decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]];
  originalPrice = [taxValue decimalNumberByAdding:price];
}

-(void)calculateFinalPrice {
  //calculate tax
  NSDecimalNumber * taxValue = [price decimalNumberByMultiplyingBy:[tax decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]];
  //dollars off
  NSDecimalNumber * dOff     = [price decimalNumberBySubtracting:dollarsOff];
  //discount
  NSDecimalNumber * disc     = [dOff decimalNumberByMultiplyingBy:[discount decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]];
  NSDecimalNumber * priceDisc= [dOff decimalNumberBySubtracting:disc];
  //Add disnt
  NSDecimalNumber * discAdd  = [priceDisc decimalNumberByMultiplyingBy:[discountAdd decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]];
  discountPrice = [priceDisc decimalNumberBySubtracting:discAdd];
  //Add Tax value
  finalPrice = [discountPrice decimalNumberByAdding:taxValue];
}

@end
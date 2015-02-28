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
Calculator * calculator;

@implementation Calculator

  @synthesize price;
  @synthesize dollarsOff;
  @synthesize discount;
  @synthesize discountAdd;
  @synthesize tax;

+(Calculator *)initialize {
  if (self == nil) {
    calculator = [[Calculator alloc] init];
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
  return self.finalPrice;
}

-(NSDecimalNumber *)originalPrice {
  return self.originalPrice;
}

-(void)calculateOriginalPrice {
  //calculate tax
  NSDecimalNumber * taxValue = [price decimalNumberByMultiplyingBy:tax];
  self.originalPrice = [taxValue decimalNumberByAdding:price];
}

-(void)calculateFinalPrice {
  //calculate tax
  NSDecimalNumber * taxValue = [price decimalNumberByMultiplyingBy:tax];
  //dollars off
  NSDecimalNumber * dOff     = [price decimalNumberBySubtracting:dollarsOff];
  //discount
  NSDecimalNumber * disc     = [dOff decimalNumberByMultiplyingBy:[discount decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]];
  NSDecimalNumber * priceDisc= [dOff decimalNumberBySubtracting:disc];
  //Add disnt
  NSDecimalNumber * discAdd  = [priceDisc decimalNumberByMultiplyingBy:[discountAdd decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]];
  NSDecimalNumber * priceAdd = [discAdd decimalNumberBySubtracting:disc];
  //Add Tax value
  self.finalPrice = [priceAdd decimalNumberByAdding:taxValue];
}

@end
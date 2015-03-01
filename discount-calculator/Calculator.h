//
//  Calculator.h
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 2/27/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

@interface Calculator : NSObject

  @property(strong, nonatomic) NSDecimalNumber * price;
  @property(strong, nonatomic) NSDecimalNumber * dollarsOff;
  @property(strong, nonatomic) NSDecimalNumber * discount;
  @property(strong, nonatomic) NSDecimalNumber * discountAdd;
  @property(strong, nonatomic) NSDecimalNumber * tax;
  @property(strong, nonatomic) NSDecimalNumber * originalPrice;
  @property(strong, nonatomic) NSDecimalNumber * finalPrice;
  @property(strong, nonatomic) NSDecimalNumber * discountPrice;

  +(Calculator *)initialize;

  -(void)setPrice:      (NSDecimalNumber *)p;
  -(void)setDollarsOff: (NSDecimalNumber *)d;
  -(void)setDiscount:   (NSDecimalNumber *)d;
  -(void)setDiscountAdd:(NSDecimalNumber *)d;
  -(void)setTax:        (NSDecimalNumber *)t;

  -(void)calculateOriginalPrice;
  -(void)calculateFinalPrice;
  -(NSDecimalNumber *)originalPrice;
  -(NSDecimalNumber *)finalPrice;
  -(NSDecimalNumber *)discountPrice;

@end

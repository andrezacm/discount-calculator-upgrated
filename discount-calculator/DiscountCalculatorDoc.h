//
//  DiscountCalculatorDoc.h
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 4/10/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//
//  Following tutorial:
//    http://www.raywenderlich.com/1914/nscoding-tutorial-for-ios-how-to-save-your-app-data
//

@interface DiscountCalculatorDoc : NSObject

  @property(nonatomic, strong) NSString * path;
  @property(nonatomic, strong) id data;

  -(id)initWithPath:(NSString *)docPath;
  -(void)saveData;
  -(void)deleteDoc;

@end
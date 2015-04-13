//
//  DiscountCalculatorDatabase.h
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 4/11/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//
//  Following tutorial:
//    http://www.raywenderlich.com/1914/nscoding-tutorial-for-ios-how-to-save-your-app-data
//

@interface DiscountCalculatorDatabase : NSObject

+(NSMutableArray *)loadDocs;
+(NSString *)next;

@end
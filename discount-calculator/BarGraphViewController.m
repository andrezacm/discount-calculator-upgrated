//
//  BarGraphView.m
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 2/27/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BarGraphViewController.h"
#import "BarGraphView.h"

@implementation BarGraphViewController

  @synthesize finalPrice;
  @synthesize originalPrice;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  ((BarGraphView *)self.view).discountPercent = [finalPrice decimalNumberByDividingBy:originalPrice];
  ((BarGraphView *)self.view).savedPercent = [[originalPrice decimalNumberBySubtracting:finalPrice] decimalNumberByDividingBy:originalPrice];
  
  NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
  [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
  [numberFormatter setCurrencySymbol:@"$"];
  [numberFormatter setMaximumFractionDigits:2];
  [numberFormatter setMinimumFractionDigits:2];
  [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
  
  ((BarGraphView *)self.view).originalPrice = [numberFormatter stringFromNumber:originalPrice];
  ((BarGraphView *)self.view).discount = [numberFormatter stringFromNumber:finalPrice];
  ((BarGraphView *)self.view).saved = [numberFormatter stringFromNumber:[originalPrice decimalNumberBySubtracting:finalPrice]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
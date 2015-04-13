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
  @synthesize homeFormatter;
  @synthesize originalPriceForeign;
  @synthesize finalPriceForeign;
  @synthesize foreignFormatter;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  ((BarGraphView *)self.view).discountPercent = [finalPrice decimalNumberByDividingBy:originalPrice];
  ((BarGraphView *)self.view).savedPercent = [[originalPrice decimalNumberBySubtracting:finalPrice] decimalNumberByDividingBy:originalPrice];
  
  if (homeFormatter == nil) {
    NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencySymbol:@"$"];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    ((BarGraphView *)self.view).originalPrice = [numberFormatter stringFromNumber:originalPrice];
    ((BarGraphView *)self.view).discount = [numberFormatter stringFromNumber:finalPrice];
    ((BarGraphView *)self.view).saved = [numberFormatter stringFromNumber:[originalPrice decimalNumberBySubtracting:finalPrice]];
  } else {
    ((BarGraphView *)self.view).originalPrice = [homeFormatter stringFromNumber:originalPrice];
    ((BarGraphView *)self.view).discount = [homeFormatter stringFromNumber:finalPrice];
    ((BarGraphView *)self.view).saved = [homeFormatter stringFromNumber:[originalPrice decimalNumberBySubtracting:finalPrice]];
  }
  
  if (originalPriceForeign != nil || finalPriceForeign != nil) {
    ((BarGraphView *)self.view).originalPrice = [[((BarGraphView *)self.view).originalPrice stringByAppendingString:@"\n"] stringByAppendingString:[foreignFormatter stringFromNumber:originalPriceForeign]];
    ((BarGraphView *)self.view).discount = [[((BarGraphView *)self.view).discount stringByAppendingString:@"\n"] stringByAppendingString:[foreignFormatter stringFromNumber:finalPriceForeign]];
    ((BarGraphView *)self.view).saved = [[((BarGraphView *)self.view).saved stringByAppendingString:@"\n"] stringByAppendingString:[foreignFormatter stringFromNumber:[originalPriceForeign decimalNumberBySubtracting:finalPriceForeign]]];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
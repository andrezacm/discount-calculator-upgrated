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

  @synthesize discount;
  @synthesize originalPrice;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  ((BarGraphView *)self.view).discountPercent = [discount decimalNumberByDividingBy:originalPrice];
  ((BarGraphView *)self.view).savedPercent = [[originalPrice decimalNumberBySubtracting:discount] decimalNumberByDividingBy:originalPrice];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
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

  @synthesize price;
  @synthesize discount;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  ((BarGraphView *)self.view).discountPrice = discount;
  ((BarGraphView *)self.view).savedValue = [price decimalNumberBySubtracting:discount];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
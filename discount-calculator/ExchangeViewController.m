//
//  ExchangeViewController.m
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 4/7/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExchangeViewController.h"

@implementation ExchangeViewController

@synthesize homeCurrency;
@synthesize foreignCurrency;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
  UIView * contentView = [[UIView alloc] initWithFrame:applicationFrame];
  contentView.backgroundColor = [UIColor whiteColor];
  self.view = contentView;
  
  self.homeCurrencyValue = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 200, 83)];
  self.homeCurrencyValue.text = homeCurrency.entity;
  [self.homeCurrencyValue sizeToFit];
  self.homeCurrencyValue.backgroundColor = [UIColor greenColor];
  [self.view addSubview:self.homeCurrencyValue];
  
  self.foreignCurrencyValue = [[UILabel alloc]initWithFrame:CGRectMake(20, 150, 200, 83)];
  self.foreignCurrencyValue.text = foreignCurrency.entity;
  [self.foreignCurrencyValue sizeToFit];
  self.foreignCurrencyValue.backgroundColor = [UIColor redColor];
  [self.view addSubview:self.foreignCurrencyValue];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
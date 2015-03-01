//
//  CalculatorView.m
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 2/27/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorViewController.h"
#import "BarGraphViewController.h"

@implementation CalculatorViewController

  @synthesize calculator;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  calculator = [Calculator initialize];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

// Dismiss keyboard by touching outside
- (void) touchesBegan:(NSSet * )touches withEvent:(UIEvent * )event {
  [[self view] endEditing:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  [segue destinationViewController];
  
}

- (IBAction)calculateDiscount:(id)sender {  
  [calculator setPrice:[NSDecimalNumber decimalNumberWithString:_price.text]];
  [calculator setDollarsOff:[NSDecimalNumber decimalNumberWithString:_dollarsOff.text]];
  [calculator setDiscount:[NSDecimalNumber decimalNumberWithString:_discount.text]];
  [calculator setDiscountAdd:[NSDecimalNumber decimalNumberWithString:_discountAdd.text]];
  [calculator setTax:[NSDecimalNumber decimalNumberWithString:_tax.text]];
  
  [calculator calculateOriginalPrice];
  [calculator calculateFinalPrice];
  
  _originalPrice.text = [@"Original Price: $" stringByAppendingString:[calculator.originalPrice stringValue]];
  _discountPrice.text = [@"Discount Price: $" stringByAppendingString:[calculator.discountPrice stringValue]];
  _finalPrice.text = [@"Final Price (with tax): $" stringByAppendingString:[calculator.finalPrice stringValue]];
}

@end
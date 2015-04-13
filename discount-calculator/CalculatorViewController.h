//
//  CalculatorView.h
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 2/27/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"

@interface CalculatorViewController : UIViewController<UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UITextField * price;
@property(weak, nonatomic) IBOutlet UITextField * dollarsOff;
@property(weak, nonatomic) IBOutlet UITextField * discount;
@property(weak, nonatomic) IBOutlet UITextField * discountAdd;
@property(weak, nonatomic) IBOutlet UITextField * tax;
@property(weak, nonatomic) IBOutlet UILabel     * originalPriceText;
@property(weak, nonatomic) IBOutlet UILabel     * originalPrice;
@property(weak, nonatomic) IBOutlet UILabel     * discountPriceText;
@property(weak, nonatomic) IBOutlet UILabel     * discountPrice;
@property(weak, nonatomic) IBOutlet UILabel     * finalPriceText;
@property(weak, nonatomic) IBOutlet UILabel     * finalPrice;
@property(weak, nonatomic) IBOutlet UIButton    * calculateButtom;

@property(strong, nonatomic) NSDecimalNumber   * originalPriceForeign;
@property(strong, nonatomic) NSDecimalNumber   * finalPriceForeign;
@property(strong, nonatomic) NSNumberFormatter * homeFormatter;
@property(strong, nonatomic) NSNumberFormatter * foreignFormatter;

@property(strong) Calculator * calculator;

- (IBAction)calculateDiscount:(id)sender;

@end
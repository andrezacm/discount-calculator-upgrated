//
//  ExchangeViewController.h
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 4/7/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"

@interface ExchangeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel * homeCurrencyValue;
@property (strong, nonatomic) IBOutlet UILabel * foreignCurrencyValue;

@property (nonatomic, strong) Currency * homeCurrency;
@property (nonatomic, strong) Currency * foreignCurrency;



@end
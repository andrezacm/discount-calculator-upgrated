//
//  ForeignCurrencyViewController.h
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 4/6/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"

@interface ForeignCurrencyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * tableData;
@property (nonatomic, strong) Currency * homeCurrency;
@property (nonatomic, strong) Currency * foreignCurrency;

@property(strong, nonatomic) NSDecimalNumber * originalPrice;
@property(strong, nonatomic) NSDecimalNumber * finalPrice;
@property(strong, nonatomic) NSDecimalNumber * discountPrice;

@end

//
//  ForeignCurrencyViewController.h
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 4/6/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExchangeRate.h"

@interface ForeignCurrencyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableArray * tableData;

@property (nonatomic, strong) Currency * homeCurrency;
@property (nonatomic, strong) Currency * foreignCurrency;
@property (nonatomic, strong) ExchangeRate * exchange;

@property(strong, nonatomic) NSDecimalNumber * originalPrice;
@property(strong, nonatomic) NSDecimalNumber * finalPrice;
@property(strong, nonatomic) NSDecimalNumber * discountPrice;

@property (nonatomic, strong) NSMutableData   * buffer;
@property (nonatomic, strong) NSURLConnection * connection;
@property (nonatomic, strong) NSURLResponse   * urlResponse;

@property (strong, nonatomic) IBOutlet UIProgressView * progressView;

@end

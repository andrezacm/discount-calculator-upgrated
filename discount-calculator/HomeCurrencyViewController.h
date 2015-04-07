//
//  HomeCurrencyViewController.h
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 4/5/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCurrencyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * tableData;

@end
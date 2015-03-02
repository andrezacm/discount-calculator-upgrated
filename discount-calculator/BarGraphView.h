//
//  BarGraphView.h
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 2/28/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarGraphView : UIView

@property(strong, nonatomic)NSDecimalNumber * discountPercent;
@property(strong, nonatomic)NSDecimalNumber * savedPercent;

@end

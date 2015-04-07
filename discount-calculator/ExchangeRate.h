//
//  ExchangeRate.h
//  class-03-10
//
//  Created by Andreza da Costa Medeiros on 3/10/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import "Currency.h"

@interface ExchangeRate : NSObject <NSCoding>

  @property (retain) Currency * srcCurrency;
  @property (retain) Currency * dstCurrency;
  @property (retain) NSNumber * rate;
  @property (retain) NSDate   * lastFetchedOn;
  @property (retain) NSNumber * expireAfterHours;
  @property (retain) NSDecimalNumberHandler * decimalHandler;

-(ExchangeRate *)initWithSrcCurrency:(Currency *)aSrc destination:(Currency *)aDst;
-(BOOL)update;
@end
//
//  Currency.m
//  class-03-05
//
//  Created by Andreza da Costa Medeiros on 3/5/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

/* select * from Yahoo.finance.xchange where pair in ('USDCAD') */

#import <Foundation/Foundation.h>
#import "Currency.h"

enum {
  denmark = 0,
  india,
  pound
};

Currency * _secretCurrencies[11];

@implementation Currency

  @synthesize entity;
  @synthesize currency;
  @synthesize code;
  @synthesize symbol;
  @synthesize formatter;

-(Currency *)initWithEntity:(NSString *)theEntity currency:(NSString *)aCurrency code:(NSString *)theCode decimalPlaces:(int)places symbol:(NSString *)sym {
  //TODO
  return self;
}

// DENMARK	Danish Krone	DKK	208	2
+(Currency *)theDanishKroner {
  if (_secretCurrencies[denmark] == nil) {
    _secretCurrencies[denmark] = [[Currency alloc] initWithEntity:@"DENMARK" currency:@"Danish Krone" code:@"DKK" decimalPlaces:2 symbol:@"kr."];
  }
  return _secretCurrencies[denmark];
}

@end

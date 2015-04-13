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
  pound,
  china,
  euro
};

Currency * _secretCurrencies[11];

@implementation Currency

  @synthesize entity;
  @synthesize currency;
  @synthesize code;
  @synthesize symbol;
  @synthesize minorUnit;
  @synthesize formatter;

-(Currency *)initWithEntity:(NSString *)theEntity currency:(NSString *)aCurrency code:(NSString *)theCode decimalPlaces:(int)places symbol:(NSString *)sym {
  
  entity    = theEntity;
  currency  = aCurrency;
  code      = theCode;
  symbol    = sym;
  minorUnit = [NSNumber numberWithInt:places];
  
  NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
  [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
  [numberFormatter setCurrencySymbol:sym];
  [numberFormatter setMaximumFractionDigits:places];
  [numberFormatter setMinimumFractionDigits:places];
  formatter = numberFormatter;
  
  return self;
}

// DENMARK	Danish Krone	DKK	208	2
+(Currency *)theDanishKroner {
  if (_secretCurrencies[denmark] == nil) {
    _secretCurrencies[denmark] = [[Currency alloc] initWithEntity:@"DENMARK" currency:@"Danish Krone" code:@"DKK" decimalPlaces:2 symbol:@"kr."];
  }
  return _secretCurrencies[denmark];
}

// INDIA	Indian Rupee	INR	356	2
+(Currency *)theIndianRupee {
  if (_secretCurrencies[india] == nil) {
    _secretCurrencies[india] = [[Currency alloc] initWithEntity:@"INDIA" currency:@"Indian Rupee" code:@"INR" decimalPlaces:2 symbol:@"₹"];
  }
  return _secretCurrencies[india];
}

// UNITED KINGDOM	Pound Sterling	GBP	826	2
+(Currency *)theBritishPound {
  if (_secretCurrencies[pound] == nil) {
    _secretCurrencies[pound] = [[Currency alloc] initWithEntity:@"UNITED KINGDOM" currency:@"Pound Sterling" code:@"GBP" decimalPlaces:2 symbol:@"£"];
  }
  return _secretCurrencies[pound];
}

// CHINA	Yuan Renminbi	CNY	156	2
+(Currency *)theChineseYuan {
  if (_secretCurrencies[china] == nil) {
    _secretCurrencies[china] = [[Currency alloc] initWithEntity:@"CHINA" currency:@"Yuan Renminbi" code:@"CNY" decimalPlaces:2 symbol:@"¥"];
  }
  return _secretCurrencies[china];
}

//EUROPE	Euro	EUR	978	2
+(Currency *)theEuropeanEuro {
  if (_secretCurrencies[euro] == nil) {
    _secretCurrencies[euro] = [[Currency alloc] initWithEntity:@"EUROPE" currency:@"Euro" code:@"EUR" decimalPlaces:2 symbol:@"€"];
  }
  return _secretCurrencies[euro];
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [coder encodeObject:entity    forKey:@"entity"];
  [coder encodeObject:currency  forKey:@"currency"];
  [coder encodeObject:code      forKey:@"code"];
  [coder encodeObject:symbol    forKey:@"symbol"];
  [coder encodeObject:minorUnit forKey:@"minorUnit"];
  [coder encodeObject:formatter forKey:@"formatter"];
}

- (id)initWithCoder:(NSCoder *)coder {
  self = [self init];
  
  entity    = [coder decodeObjectForKey:@"entity"];
  currency  = [coder decodeObjectForKey:@"currency"];
  code      = [coder decodeObjectForKey:@"code"];
  symbol    = [coder decodeObjectForKey:@"symbol"];
  minorUnit = [coder decodeObjectForKey:@"minorUnit"];
  formatter = [coder decodeObjectForKey:@"formatter"];
  
  return self;
}

@end

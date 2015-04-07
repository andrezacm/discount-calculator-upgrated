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

- (void)encodeWithCoder:(NSCoder *)coder {
  [coder encodeObject:entity forKey:@"entity"];
  [coder encodeObject:currency forKey:@"currency"];
  [coder encodeObject:code forKey:@"code"];
  [coder encodeObject:symbol forKey:@"symbol"];
  [coder encodeObject:formatter forKey:@"formatter"];
}

- (id)initWithCoder:(NSCoder *)coder {
  self = [self init];
  
  entity    = [coder decodeObjectForKey:@"entity"];
  currency  = [coder decodeObjectForKey:@"currency"];
  code      = [coder decodeObjectForKey:@"code"];
  symbol    = [coder decodeObjectForKey:@"symbol"];
  formatter = [coder decodeObjectForKey:@"formatter"];
  
  return self;
}

@end

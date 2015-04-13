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
  euro,
  japan,
  us,
  canada,
  mexico,
  russia,
  brazil
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

// EUROPE	Euro	EUR	978	2
+(Currency *)theEuropeanEuro {
  if (_secretCurrencies[euro] == nil) {
    _secretCurrencies[euro] = [[Currency alloc] initWithEntity:@"EUROPE" currency:@"Euro" code:@"EUR" decimalPlaces:2 symbol:@"€"];
  }
  return _secretCurrencies[euro];
}

// JAPAN	Yen	JPY	392	0
+(Currency *)theJapaneseYen {
  if (_secretCurrencies[japan] == nil) {
    _secretCurrencies[japan] = [[Currency alloc] initWithEntity:@"JAPAN" currency:@"Yen" code:@"JPY" decimalPlaces:0 symbol:@"¥"];
  }
  return _secretCurrencies[japan];
}

// UNITED STATES	US Dollar	USD	840	2
+(Currency *)theUSDollar {
  if (_secretCurrencies[us] == nil) {
    _secretCurrencies[us] = [[Currency alloc] initWithEntity:@"UNITED STATES" currency:@"US Dollar" code:@"USD" decimalPlaces:2 symbol:@"$"];
  }
  return _secretCurrencies[us];
}

// CANADA	Canadian Dollar	CAD	124	2
+(Currency *)theCanadianDollar {
  if (_secretCurrencies[canada] == nil) {
    _secretCurrencies[canada] = [[Currency alloc] initWithEntity:@"CANADA" currency:@"Canadian Dollar" code:@"CAD" decimalPlaces:2 symbol:@"$"];
  }
  return _secretCurrencies[canada];
}

// MEXICO	Mexican Peso	MXN	484	2
+(Currency *)theMexicanPeso {
  if (_secretCurrencies[mexico] == nil) {
    _secretCurrencies[mexico] = [[Currency alloc] initWithEntity:@"MEXICO" currency:@"Mexican Peso" code:@"MXN" decimalPlaces:2 symbol:@"$"];
  }
  return _secretCurrencies[mexico];
}

// RUSSIAN FEDERATION	Russian Ruble	RUB	643	2
+(Currency *)theRussianRuble {
  if (_secretCurrencies[russia] == nil) {
    _secretCurrencies[russia] = [[Currency alloc] initWithEntity:@"RUSSIAN FEDERATION" currency:@"Russian Ruble" code:@"RUB" decimalPlaces:2 symbol:@"₽"];
  }
  return _secretCurrencies[russia];
}

// BRAZIL	Brazilian Real	BRL	986	2
+(Currency *)theBrazilianReal {
  if (_secretCurrencies[brazil] == nil) {
    _secretCurrencies[brazil] = [[Currency alloc] initWithEntity:@"BRAZIL" currency:@"Brazilian Real" code:@"BRL" decimalPlaces:2 symbol:@"R$"];
  }
  return _secretCurrencies[brazil];
}

+(Currency *)currency:(NSString *)alphacode {
  if ([alphacode  isEqual: @"DKK"]) return _secretCurrencies[denmark];
  if ([alphacode  isEqual: @"INR"]) return _secretCurrencies[india];
  if ([alphacode  isEqual: @"GBP"]) return _secretCurrencies[pound];
  if ([alphacode  isEqual: @"CNY"]) return _secretCurrencies[china];
  if ([alphacode  isEqual: @"EUR"]) return _secretCurrencies[euro];
  if ([alphacode  isEqual: @"JPY"]) return _secretCurrencies[japan];
  if ([alphacode  isEqual: @"USD"]) return _secretCurrencies[us];
  if ([alphacode  isEqual: @"CAD"]) return _secretCurrencies[canada];
  if ([alphacode  isEqual: @"MXN"]) return _secretCurrencies[mexico];
  if ([alphacode  isEqual: @"RUB"]) return _secretCurrencies[russia];
  return _secretCurrencies[brazil];
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

//
//  ExchangeRate.m
//  class-03-10
//
//  Created by Andreza da Costa Medeiros on 3/10/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExchangeRate.h"
#import "DiscountCalculatorDatabase.h"
#import "DiscountCalculatorDoc.h"

@implementation ExchangeRate

  @synthesize srcCurrency;
  @synthesize dstCurrency;
  @synthesize rate;
  @synthesize lastFetchedOn;
  @synthesize expireAfterHours;
  @synthesize decimalHandler;

- (void)encodeWithCoder:(NSCoder *)coder {
  [coder encodeObject:srcCurrency       forKey:@"srcCurrency"];
  [coder encodeObject:dstCurrency       forKey:@"dstCurrency"];
  [coder encodeObject:rate              forKey:@"rate"];
  [coder encodeObject:lastFetchedOn     forKey:@"lastFetchedOn"];
  [coder encodeObject:expireAfterHours  forKey:@"expireAfterHours"];
  [coder encodeObject:decimalHandler    forKey:@"decimalHandler"];
}

- (id)initWithCoder:(NSCoder *)coder {
  self = [self init];
  
  srcCurrency       = [coder decodeObjectForKey:@"srcCurrency"];
  dstCurrency       = [coder decodeObjectForKey:@"dstCurrency"];
  rate              = [coder decodeObjectForKey:@"rate"];
  lastFetchedOn     = [coder decodeObjectForKey:@"lastFetchedOn"];
  expireAfterHours  = [coder decodeObjectForKey:@"expireAfterHours"];
  decimalHandler    = [coder decodeObjectForKey:@"decimalHandler"];
  
  return self;
}

-(ExchangeRate *)initWithSrcCurrency:(Currency *)aSrc destination:(Currency *)aDst {
  self = [super init];
  if (self) {
    srcCurrency = aSrc;
    dstCurrency = aDst;
    decimalHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                        scale:dstCurrency.minorUnit.integerValue
                                        raiseOnExactness:NO
                                        raiseOnOverflow:NO
                                        raiseOnUnderflow:NO
                                        raiseOnDivideByZero:NO];
    rate = @-1;
    lastFetchedOn = [NSDate dateWithTimeIntervalSince1970:0];
    expireAfterHours = @25;
  }
  return self;
}

-(BOOL)update {
  if ([self.lastFetchedOn timeIntervalSinceNow] > (self.expireAfterHours.doubleValue * -3600.0))
    return NO;
  else
    return YES;
}

@end
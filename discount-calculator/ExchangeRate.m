//
//  ExchangeRate.m
//  class-03-10
//
//  Created by Andreza da Costa Medeiros on 3/10/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExchangeRate.h"

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
  if ([self.lastFetchedOn timeIntervalSinceNow] > (self.expireAfterHours.doubleValue * -3600.0)) {
    return NO;
  }
  
  //alphacode = 3 letter code in currency
  //NSString * yqlString = [NSString stringWithFormat:@"Select * from yahoo.finance.xchange where pair in (\"%@%@\")", self.srcCurrency.alphacode, self.dstCurrency.alphacode];
  
  /*http://query.yahooapis.com/v1/public/yql?q=select%20%2a%20from%20yahoo.finance.xchange%20where%20pair%20in%20%28%22USDEUR%22%29&env=store://datatables.org/alltableswithkeys
  */
  NSString * yqlString = [NSString stringWithFormat:@"select * from yahoo.finance.xchange where pair in %28%22%@%@%22%29&env=store://datatables.org/alltableswithkeys", self.srcCurrency.code, self.dstCurrency.code];
  
  //NSString * urlString = [NSString stringWithFormat:@"http://.../yql?q=%@...", [yqlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
  
  NSString * urlString = [NSString stringWithFormat:@"http://query.yahooapis.com/v1/public/yql?q=%@", [yqlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
  
  
  NSURL * yahooRESTQueryURL = [NSURL URLWithString:urlString];
  
  NSURLRequest * request = [NSURLRequest requestWithURL:yahooRESTQueryURL];
  NSHTTPURLResponse * response = nil;
  NSError * error = nil;
  
  NSData * queryResults = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  
  if (response.statusCode == 200) {
    id unknownObject = [NSJSONSerialization JSONObjectWithData:queryResults options:0 error:&error];
    if (!error) {
      if ([unknownObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary * exchangeRateDict = unknownObject;
        NSDictionary * results = [[[exchangeRateDict valueForKey:@"query"] valueForKey:@"results"] valueForKey:@"rate"];
        self.rate = @([[results objectForKey:@"rate"] floatValue]);
        self.lastFetchedOn = [NSDate date];
      } else {
        return NO;
      }
    } else {
      return NO;
    }
  }
  
  return YES;
}

@end
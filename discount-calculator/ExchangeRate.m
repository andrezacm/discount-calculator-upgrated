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

-(ExchangeRate *)initWithSrcCurrency:(Currency *)aSrc destination:(Currency *)aDst {
  self = [super init];
  if (self) {
    srcCurrency = aSrc;
    dstCurrency = aDst;
    decimalHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                        scale:dstCurrency /*.minorUnit.intergerValue*/
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
  
  NSString * yqlString = [NSString stringWithFormat:@"Select * from yahoo.finance.xchange where pair in (\"%@%@\")", self.srcCurrency.code, self.dstCurrency.code];
  
  NSString * urlString = [NSString stringWithFormat:@"http://.../yql?q=%@...", [yqlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
  
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
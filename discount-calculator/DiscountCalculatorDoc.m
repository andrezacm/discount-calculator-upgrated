//
//  DiscountCalculatorDoc.m
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 4/10/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscountCalculatorDoc.h"
#import "DiscountCalculatorDatabase.h"
#import "ExchangeRate.h"

#define kDataKey        @"Data"
#define kDataFile       @"data.plist"

@implementation DiscountCalculatorDoc

  @synthesize path;

-(id)initWithPath:(NSString *)docPath {
  self = [super init];
  if (self) {
    path = [docPath copy];
  }
  return self;
}

-(BOOL)createDataPath {
  if (path == nil) {
    path = [DiscountCalculatorDatabase next];
  }
  NSError * error;
  BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
  if (!success) {
    NSLog(@"ERROR: creating data path %@", [error localizedDescription]);
  }
  return success;
}

-(id)data {
  if (_data != nil) return _data;
  
  NSString * dataPath = [path stringByAppendingPathComponent:kDataFile];
  NSData * codedData  = [[NSData alloc] initWithContentsOfFile:dataPath];
  if (codedData == nil) return nil;
 
  NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
  
  NSString * srcCurrency      = [unarchiver decodeObjectForKey:@"srcCurrency"];
  NSString * dstCurrency      = [unarchiver decodeObjectForKey:@"dstCurrency"];
  NSNumber * rate             = [unarchiver decodeObjectForKey:@"rate"];
  NSDate   * lastFetchedOn    = [unarchiver decodeObjectForKey:@"lastFetchedOn"];
  NSNumber * expireAfterHours = [unarchiver decodeObjectForKey:@"expireAfterHours"];
  
  ExchangeRate * exchange = [[ExchangeRate alloc] init];
  
  exchange.srcCurrency = [self tempCurrency:srcCurrency];
  exchange.dstCurrency = [self tempCurrency:dstCurrency];
  exchange.rate = rate;
  exchange.lastFetchedOn = lastFetchedOn;
  exchange.expireAfterHours = expireAfterHours;
  
  _data = exchange;
  
  return _data;
}

-(Currency *)tempCurrency:(NSString *)code {
  if ([code  isEqual: @"GBP"]) {
    return [Currency theBritishPound];
  }
  if ([code  isEqual: @"INR"]) {
    return [Currency theIndianRupee];
  }
  if ([code  isEqual: @"DKK"]) {
    return [Currency theDanishKroner];
  }
  return [Currency theDanishKroner];
}

-(void)saveData {
  if (_data == nil) return;
  [self createDataPath];
  
  NSString        * dataPath = [path stringByAppendingPathComponent:kDataFile];
  NSMutableData   * data     = [[NSMutableData alloc] init];
  NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
  ExchangeRate    * dataCast = (ExchangeRate *)_data;
  
  [archiver encodeObject:[dataCast.srcCurrency code] forKey:@"srcCurrency"];
  [archiver encodeObject:[dataCast.dstCurrency code] forKey:@"dstCurrency"];
  [archiver encodeObject: dataCast.rate              forKey:@"rate"];
  [archiver encodeObject: dataCast.lastFetchedOn     forKey:@"lastFetchedOn"];
  [archiver encodeObject: dataCast.expireAfterHours  forKey:@"expireAfterHours"];
  
  [archiver encodeObject:_data forKey:kDataKey];
  [archiver finishEncoding];
  [data writeToFile:dataPath atomically:YES];
}

-(void)deleteDoc {
  NSError * error;
  BOOL success = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
  if (!success) {
    NSLog(@"ERROR: removing document path %@", error.localizedDescription);
  }
}

@end
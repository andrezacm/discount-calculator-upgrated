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
  _data = [unarchiver decodeObjectForKey:kDataKey];
  [unarchiver finishDecoding];
  
  return _data;
}

-(void)saveData {
  if (_data == nil) return;
  [self createDataPath];
  
  NSString        * dataPath = [path stringByAppendingPathComponent:kDataFile];
  NSMutableData   * data     = [[NSMutableData alloc] init];
  NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
  
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
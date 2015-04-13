//
//  DiscountCalculatorDatabase.m
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 4/11/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscountCalculatorDatabase.h"
#import "DiscountCalculatorDoc.h"

@implementation DiscountCalculatorDatabase

+ (NSString *)getPrivateDocsDir {
  NSArray   * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
  NSString  * documentsDirectory = [paths objectAtIndex:0];
  documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
  NSError   * error;
  
  [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
  return documentsDirectory;
}

+(NSMutableArray *)loadDocs {
  NSString * documentsDirectory = [DiscountCalculatorDatabase getPrivateDocsDir];
  NSLog(@"Loading from %@", documentsDirectory);
  
  // Get contents of documents directory
  NSError * error;
  NSArray * files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
  if (files == nil) {
    NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
    return nil;
  }
  
  // Create discountcalculatordoc for each file
  NSMutableArray * retval = [NSMutableArray arrayWithCapacity:files.count];
  for (NSString * file in files) {
    if ([file.pathExtension compare:@"discountcalculator" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
      NSString * fullPath = [documentsDirectory stringByAppendingPathComponent:file];
      DiscountCalculatorDoc * doc = [[DiscountCalculatorDoc alloc] initWithPath:fullPath];
      [retval addObject:doc];
    }
  }
  return retval;
}

+ (NSString *)next {
  // Get private docs dir
  NSString * documentsDirectory = [DiscountCalculatorDatabase getPrivateDocsDir];
  
  // Get contents of documents directory
  NSError * error;
  NSArray * files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
  if (files == nil) {
    NSLog(@"ERROR: reading contents of documents directory %@", [error localizedDescription]);
    return nil;
  }
  
  // Search for an available name
  int maxNumber = 0;
  for (NSString *file in files) {
    if ([file.pathExtension compare:@"discountcalculator" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
      NSString *fileName = [file stringByDeletingPathExtension];
      maxNumber = MAX(maxNumber, fileName.intValue);
    }
  }
  
  // Get available name
  NSString * availableName = [NSString stringWithFormat:@"%d.discountcalculator", maxNumber+1];
  return [documentsDirectory stringByAppendingPathComponent:availableName];
}

@end
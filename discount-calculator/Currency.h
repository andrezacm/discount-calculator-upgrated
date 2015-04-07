//
//  Currency.h
//  class-03-05
//
//  Created by Andreza da Costa Medeiros on 3/5/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

/*
 Danish Kroner
 Indian Rupee
 Euro
 China
 British Pound
 Yen
 US Dollars
 Canadian Dollar
 Mexican Peso
 Russian Ruble
 Brazil Real
 */

@interface Currency : NSObject <NSCoding>

  @property(nonatomic, readonly)NSString * entity;
  @property(nonatomic, readonly)NSString * currency;
  @property(nonatomic, readonly)NSString * code;
  @property(nonatomic, readonly)NSString * symbol;
  @property(nonatomic, readonly)NSNumber * minorUnit;
  @property(nonatomic, readonly)NSNumberFormatter * formatter;

  +(Currency *)theDanishKroner;
  +(Currency *)theIndianRupee;
  +(Currency *)theBritishPound;

@end

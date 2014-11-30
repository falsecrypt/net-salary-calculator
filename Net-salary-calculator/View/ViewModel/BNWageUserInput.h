//
//  BNWageUserInput.h
//  Brutto-Netto-Rechner
//
//  Created by Administrator on 02.11.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNFederalState;

@interface BNWageUserInput : NSObject
@property (nonatomic, strong) NSDecimalNumber *grossWage;
@property (nonatomic, strong) NSDecimalNumber *taxAllowance;
@property (nonatomic, strong) NSString *timePeriod; // todo, use enum
@property (nonatomic, strong) NSNumber *taxClass;
@property (nonatomic, assign) BOOL hasChurchTax;
@property (nonatomic, assign) BOOL hasChildren;
@property (nonatomic, strong) BNFederalState* federalState;
@property (nonatomic, strong) NSNumber *yearOfBirth;
@end
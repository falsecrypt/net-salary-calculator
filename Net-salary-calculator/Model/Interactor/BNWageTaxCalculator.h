//
//  BNWageTaxCalculator.h
//  Brutto-Netto-Rechner
//
//  Created by Administrator on 26.10.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNWageUserInput;

@interface BNWageTaxCalculator : NSObject

- (NSDecimalNumber *)calculateWageTaxWithUserInput:(BNWageUserInput *)inputData;

@end

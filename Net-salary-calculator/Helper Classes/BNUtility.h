//
//  BNUtility.h
//  Net_salary_calculator
//
//  Created by Administrator on 28.12.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNUtility : NSObject

+ (NSString *)currencyStringFromDecimalNumber:(NSDecimalNumber *)number;
+ (NSInteger)getCurrentYear;
+ (NSInteger)getPreviousYear;
@end

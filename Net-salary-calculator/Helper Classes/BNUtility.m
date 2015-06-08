//
//  BNUtility.m
//  Net_salary_calculator
//
//  Created by Administrator on 28.12.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNUtility.h"

@implementation BNUtility

+ (NSString *)currencyStringFromDecimalNumber:(NSDecimalNumber *)decimal {
    if (!decimal) {
        return nil;
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setGeneratesDecimalNumbers:TRUE];
    NSLocale *german = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    [formatter setLocale:german];
    [formatter setCurrencyDecimalSeparator:@","];
    
    return [formatter stringFromNumber:decimal];
}

+ (NSInteger)getCurrentYear {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
    return [components year];
}

+ (NSInteger)getPreviousYear {
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:-1];
    NSDate *prevYearDate = [[NSCalendar currentCalendar] dateByAddingComponents:offsetComponents toDate:[NSDate date] options:0];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:prevYearDate];
    return [components year];
}

@end

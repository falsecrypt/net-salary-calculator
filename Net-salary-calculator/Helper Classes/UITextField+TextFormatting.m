//
//  UITextField+TextFormatting.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 14.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "UITextField+TextFormatting.h"

@implementation UITextField (TextFormatting)


- (NSDecimalNumber *)currencyNumber {
    if (!self.text) {
        return nil;
    }
    //NSString *cleanedInput = [self preFormat];
    NSString *cleanedInput = self.text;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setGeneratesDecimalNumbers:TRUE];
    NSLocale *german = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    [formatter setLocale:german];
    [formatter setCurrencyDecimalSeparator:@","];
    NSNumber *modifiedNumber = [formatter numberFromString:cleanedInput];
    NSDecimalNumber *decimal = nil;
    if (modifiedNumber) {
        // for a 'currency' string
        decimal = [NSDecimalNumber decimalNumberWithDecimal:[modifiedNumber decimalValue]];
    }
    else {
        // for normal string
        decimal = [[NSDecimalNumber alloc] initWithString:cleanedInput locale:german];
    }
    
    return decimal;
}

- (NSString *)preFormat {
    if (!self.text) {
        return @"";
    }
    // remove all except numbers and comma
    NSMutableCharacterSet *charSet = [NSMutableCharacterSet characterSetWithCharactersInString:@","];
    [charSet formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]] ;
    NSCharacterSet *inverted = [charSet invertedSet];
    return [[self.text componentsSeparatedByCharactersInSet:inverted] componentsJoinedByString:@""];
}

- (NSString *)currencyString  {
    // just format the text
    if (!self.text) {
        return @"";
    }
    NSString *cleanedInput = [self preFormat];
    if ([cleanedInput length] == 0) {
        return @"";
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setGeneratesDecimalNumbers:TRUE];
    NSLocale *german = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    [formatter setLocale:german];
    [formatter setCurrencyDecimalSeparator:@","];
    NSNumber *modifiedNumber = [formatter numberFromString:cleanedInput];
    NSDecimalNumber *decimal = nil;
    if (modifiedNumber) {
        // for a 'currency' string
        decimal = [NSDecimalNumber decimalNumberWithDecimal:[modifiedNumber decimalValue]];
    }
    else {
        // for normal string
        decimal = [[NSDecimalNumber alloc] initWithString:cleanedInput locale:german];
    }
    
    
    return [formatter stringFromNumber:decimal];
}


@end

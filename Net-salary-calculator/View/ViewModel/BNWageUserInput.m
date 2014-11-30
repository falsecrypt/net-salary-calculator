//
//  BNWageUserInput.m
//  Brutto-Netto-Rechner
//
//  Created by Administrator on 02.11.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNWageUserInput.h"
#import "BNFederalState.h"

@implementation BNWageUserInput

- (NSString *)description
{
    return [NSString stringWithFormat:@"\nUser grossWage: %@ \nUser taxAllowance: %@\ntaxClass = %@\nhasChurchTax = %i\nhasChildren = %i\nfederalState = %@\nyearOfBirth = %@",
            _grossWage, _taxAllowance, _taxClass, _hasChurchTax, _hasChildren, _federalState.name, _yearOfBirth];
    
}

@end

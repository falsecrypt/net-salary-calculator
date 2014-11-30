//
//  BNWageTaxCalculator.m
//  Brutto-Netto-Rechner
//
//  Created by Administrator on 26.10.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNWageTaxCalculator.h"
#import "BNWageUserInput.h"

/**
 *  Berechnung basiert auf dem Programmablaufplan für die maschinelle Berechnung der vom Arbeitslohn einzubehaltenden Lohnsteuer, des
 *  Solidaritätszuschlags und der Maßstabsteuer für die Kirchenlohnsteuer für 2014.
 *  http://www.bundesfinanzministerium.de/Content/DE/Downloads/Steuern/Steuerarten/Lohnsteuer/Programmablaufplan/2013-12-03-entwuerfe-PAP-2014-anlage-1.pdf?__blob=publicationFile&v=2
 *  http://www.bundesfinanzministerium.de/Content/DE/Downloads/Steuern/Steuerarten/Lohnsteuer/Programmablaufplan/2013-12-03-entwuerfe-PAP-2014-anlage-2.pdf?__blob=publicationFile&v=2
 *
 */

@implementation BNWageTaxCalculator

- (NSDecimalNumber *)calculateWageTaxWithUserInput:(BNWageUserInput *)inputData {
    NSDecimalNumber *resultWageTax = nil;
    
    
    
    
    return resultWageTax;
}

@end

//
//  BNGrossNetWageInteractorIO.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 04.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNFederalState;

@protocol BNGrossNetWageInteractorInput <NSObject>
// presenter talks to an interacter that implements this input-ptotocol("interface")

- (void)storeCurrentGrossWage:(NSNumber *)input;
- (void)storeCurrentTaxAllowance:(NSDecimalNumber *)value;
- (void)storeCurrentHasChildrenFlag:(BOOL)hasChildren;
- (void)storeCurrentFederalState:(BNFederalState *)state;
- (void)storeCurrentYearOfBirth:(NSNumber *)year;
- (BOOL)currentHasChildrenFlag;
@end

@protocol BNGrossNetWageInteractorOutput <NSObject>
// interactor talks to a presenter that implements this output-protocol("interface")
@end
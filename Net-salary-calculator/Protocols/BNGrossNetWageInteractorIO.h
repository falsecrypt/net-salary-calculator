//
//  BNGrossNetWageInteractorIO.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 04.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNWageUserInput.h"

@protocol BNGrossNetWageInteractorInput <NSObject>
// presenter talks to an interacter that implements this input-ptotocol("interface")

- (void)storeCurrentGrossWage:(NSDecimalNumber *)input;
- (void)storeCurrentTaxAllowance:(NSDecimalNumber *)value;
- (void)storeCurrentHasChildrenFlag:(BOOL)hasChildren;
- (void)storeCurrentHasChurchTaxFlag:(BOOL)churchTax;
- (void)storeCurrentFederalState:(BNFederalState *)state;
- (void)storeCurrentYearOfBirth:(NSNumber *)year;
- (void)storeCurrentTargetYear:(NSNumber *)year;
- (void)storeCurrentHealthInsuranceType:(HealthInsuranceType)insuranceType;
- (void)taxClassSelectedAtDataIndex:(NSInteger)index;
- (void)federalStateSelected:(BNFederalState *)state;
- (BOOL)currentHasChildrenFlag;
- (BOOL)currenthasChurchTaxFlag;
- (HealthInsuranceType)currentHealthInsuranceType;
- (NSString *)currentFederalState;
- (NSArray *)taxClasses;
- (NSDecimalNumber *)currentGrossWage;
- (NSDecimalNumber *)currentTaxAllowance;
- (NSNumber *)currentBirthdayYear;
- (NSNumber *)currentTargetYear;

@end

@protocol BNGrossNetWageInteractorOutput <NSObject>
// interactor talks to a presenter that implements this output-protocol("interface")
@end
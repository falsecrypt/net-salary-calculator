//
//  BNGrossNetWageInteractor.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 04.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNGrossNetWageInteractor.h"
#import "BNWageDataManager.h"
#import "BNWageUserInput.h"
#import "BNFederalState.h"

@interface TaxClass : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, assign) BOOL hasFactor;
@end

@implementation TaxClass
@end

//////////

@interface BNGrossNetWageInteractor ()
@property (nonatomic, strong) BNWageDataManager *dataManager;
@property (nonatomic, strong) BNWageUserInput *userInput;
@property (nonatomic, strong) BNWageUserInput *userInputDefault;
@property (nonatomic, strong) NSArray *taxClassOptions;
@end

@implementation BNGrossNetWageInteractor

- (instancetype)initWithDataManager:(BNWageDataManager *)dataManager {
    if ((self = [super init]))
    {
        _dataManager = dataManager;
        _userInput = [BNWageUserInput new];
        [self setupDefaultUserInput];
    }
    return self;
}

/**
 * The UI must distinguish between the state 'not entered any value yet' and 'has already some value'
 * to e.g. show a placeholder in a input field
 */
- (void)setupDefaultUserInput {
    _userInputDefault = [BNWageUserInput new];
    _userInputDefault.hasChildren = NO;
    _userInputDefault.grossWage = [NSDecimalNumber decimalNumberWithString:@"0.0"];
    _userInputDefault.taxAllowance = [NSDecimalNumber decimalNumberWithString:@"0.0"];
    _userInputDefault.taxClass = @(1);
    _userInputDefault.hasChurchTax = YES;
    _userInputDefault.targetYear = @([BNUtility getCurrentYear]);
}

- (NSArray *)taxClassOptions {
    if (!_taxClassOptions) {
        NSMutableArray *objs = [NSMutableArray array];
        for (NSInteger i = 1; i <= 4 ; i++) {
            TaxClass *taxClass = [TaxClass new];
            taxClass.name = [NSString stringWithFormat:@"Klasse %@", @(i)];
            taxClass.value = @(i);
            [objs addObject:taxClass];
        }
        
        TaxClass *taxClass4Factor = [TaxClass new];
        taxClass4Factor.name = @"Klasse 4 mit Faktor";
        taxClass4Factor.value = @(4);
        taxClass4Factor.hasFactor = YES;
        [objs addObject:taxClass4Factor];
        
        for (NSInteger i = 5; i <= 6 ; i++) {
            TaxClass *taxClass = [TaxClass new];
            taxClass.name = [NSString stringWithFormat:@"Klasse %@", @(i)];
            taxClass.value = @(i);
            [objs addObject:taxClass];
        }
        
        _taxClassOptions = [objs copy];
    }
    return _taxClassOptions;
}

/**
 * Call this method before giving the values to interactor
 */
- (BNWageUserInput *)mergeWithDefaultValues:(BNWageUserInput *)input {
    input.hasChildren = input.hasChildren ? input.hasChildren : self.userInputDefault.hasChildren;
    input.grossWage = input.grossWage ? input.grossWage : self.userInputDefault.grossWage;
    input.taxAllowance = input.taxAllowance ? input.taxAllowance : self.userInputDefault.taxAllowance;
    input.taxClass = input.taxClass ? input.taxClass : self.userInputDefault.taxClass;
    input.hasChurchTax = input.hasChurchTax ? input.hasChurchTax : self.userInputDefault.hasChurchTax;
    return input;
}

#pragma mark - Store methods

- (void)storeCurrentTargetYear:(NSNumber *)year {
    [self.userInput setTargetYear:year]; // can be null
    DLog(@"%@", self.userInput);
}

- (void)storeCurrentGrossWage:(NSDecimalNumber *)wage {
    [self.userInput setGrossWage:wage]; // can be null
    DLog(@"%@", self.userInput);
}

- (void)storeCurrentTaxAllowance:(NSDecimalNumber *)value {
    [self.userInput setTaxAllowance:value];
    DLog(@"%@", self.userInput);
}

- (void)storeCurrentHasChildrenFlag:(BOOL)hasChildren {
    [self.userInput setHasChildren:hasChildren];
    DLog(@"%@", self.userInput);
}

- (void)storeCurrentHasChurchTaxFlag:(BOOL)churchTax {
    [self.userInput setHasChurchTax:churchTax];
    DLog(@"%@", self.userInput);
}

- (void)storeCurrentFederalState:(BNFederalState *)state {
    if (!state) {
        return;
    }
    [self.userInput setFederalState:state];
    DLog(@"%@", self.userInput);
}

- (void)storeCurrentYearOfBirth:(NSNumber *)year {
    if (!year) {
        return;
    }
    [self.userInput setYearOfBirth:year];
    DLog(@"%@", self.userInput);
}

- (void)storeCurrentHealthInsuranceType:(HealthInsuranceType)insuranceType {
    [self.userInput setHealthInsurance:insuranceType];
    DLog(@"%@", self.userInput);
}

- (void)storeCurrentInsuranceTypeForPensionInsurance:(CommonInsuranceType)type {
    [self.userInput setPensionInsurance:type];
    DLog(@"%@", self.userInput);
}

- (void)storeCurrentInsuranceTypeForUnemploymentInsurance:(CommonInsuranceType)type {
    [self.userInput setUnemploymentInsurance:type];
    DLog(@"%@", self.userInput);
}


#pragma mark - Current Values methods

- (HealthInsuranceType)currentHealthInsuranceType {
    if (self.userInput.healthInsurance) {
        return self.userInput.healthInsurance;
    }
    else {
        return HealthInsuranceTypeStatutory; // Default
    }
}

- (NSDecimalNumber *)currentTaxAllowance {
    if (self.userInput.taxAllowance) {
        return self.userInput.taxAllowance;
    }
    else {
        return nil;
    }
}

- (NSDecimalNumber *)currentGrossWage {
    if (self.userInput.grossWage) {
        return self.userInput.grossWage;
    }
    else {
        return nil;
    }
}

- (NSNumber *)currentTargetYear {
    if (self.userInput.targetYear) {
        return self.userInput.targetYear;
    }
    else {
        return self.userInputDefault.targetYear;
    }
}

- (BOOL)currentHasChildrenFlag {
    if (self.userInput.hasChildren) {
        return self.userInput.hasChildren;
    }
    else {
        return self.userInputDefault.hasChildren;
    }
}

- (BOOL)currenthasChurchTaxFlag {
    if (self.userInput.hasChurchTax) {
        return self.userInput.hasChurchTax;
    }
    else {
        return self.userInputDefault.hasChurchTax;
    }
}

- (NSString *)currentFederalState {
    if (self.userInput.federalState) {
        return self.userInput.federalState.name;
    }
    else {
        return @"Baden-Württemberg";
    }
}

- (NSNumber *)currentBirthdayYear {
    if (self.userInput.yearOfBirth) {
        return self.userInput.yearOfBirth;
    }
    else {
        return nil;
    }
}

- (CommonInsuranceType)currentPensionInsuranceType {
    if (self.userInput.pensionInsurance) {
        return self.userInput.pensionInsurance;
    }
    else {
        return CommonInsuranceTypeStatutory;
    }
}

- (CommonInsuranceType)currentUnemploymentInsuranceType {
    if (self.userInput.unemploymentInsurance) {
        return self.userInput.unemploymentInsurance;
    }
    else {
        return CommonInsuranceTypeStatutory;
    }
}

- (NSArray *)taxClasses {
    // return all tax class names
    return [self.taxClassOptions valueForKeyPath:@"name"];
}

- (NSArray *)possiblePayrollYears {
    // current and previous for the first release
    return @[@([BNUtility getCurrentYear]), @([BNUtility getPreviousYear])];
}

- (void)taxClassSelectedAtDataIndex:(NSInteger)index {
    DLog(@"New Tax Class: %@", [(self.taxClassOptions[index]) name]);
    TaxClass *selected = self.taxClassOptions[index];
    [self.userInput setTaxClass:selected.value];
}

- (void)federalStateSelected:(BNFederalState *)state {
    [self.userInput setFederalState:state];
}

@end

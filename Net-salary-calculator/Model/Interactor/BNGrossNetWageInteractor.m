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

@interface BNGrossNetWageInteractor ()
@property (nonatomic, strong) BNWageDataManager *dataManager;
@property (nonatomic, strong) BNWageUserInput *userInput;
@end

@implementation BNGrossNetWageInteractor

- (instancetype)initWithDataManager:(BNWageDataManager *)dataManager {
    if ((self = [super init]))
    {
        _dataManager = dataManager;
        _userInput = [self fillWithDefaultValues:[BNWageUserInput new]];
    }
    return self;
}

- (BNWageUserInput *)fillWithDefaultValues:(BNWageUserInput *)input {
    input.hasChildren = NO;
    input.grossWage = [NSDecimalNumber decimalNumberWithString:@"0.0"];
    input.taxAllowance = [NSDecimalNumber decimalNumberWithString:@"0.0"];
    input.taxClass = @(1);
    input.hasChurchTax = YES;
    return input;
}

- (void)storeCurrentGrossWage:(NSDecimalNumber *)wage {
    if (!wage) {
        return;
    }
    [self.userInput setGrossWage:wage];
}

- (void)storeCurrentTaxAllowance:(NSDecimalNumber *)value {
    if (!value) {
        return;
    }
    [self.userInput setTaxAllowance:value];
}

- (void)storeCurrentHasChildrenFlag:(BOOL)hasChildren {
    [self.userInput setHasChildren:hasChildren];
}

- (BOOL)currentHasChildrenFlag {
    return self.userInput.hasChildren;
}

- (void)storeCurrentFederalState:(BNFederalState *)state {
    if (!state) {
        return;
    }
    [self.userInput setFederalState:state];
}

- (void)storeCurrentYearOfBirth:(NSNumber *)year {
    if (!year) {
        return;
    }
    [self.userInput setYearOfBirth:year];
}

@end

//
//  BNGrossNetWagePresenter.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 04.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNGrossNetWagePresenter.h"
#import "UITextField+TextFormatting.h"
#import "BNFederalStateRepository.h"
#import "BNFederalState.h"
#import "BNHealthInsuranceViewController.h"
#import "BNCommonInsuranceViewController.h"
#import "BNHealthInsurancePresenter.h"

@interface BNGrossNetWagePresenter ()
@property (nonatomic, strong) BNFederalStateRepository *stateRepository;
@end


@implementation BNGrossNetWagePresenter

- (BNFederalStateRepository *)stateRepository {
    if (!_stateRepository) {
        _stateRepository = [[BNFederalStateRepository alloc] init];
    }
    return _stateRepository;
}


- (BOOL)grossWageFieldShouldReturn:(UITextField *)grossWageField {
    if (!grossWageField) {
        return NO;
    }
    if (grossWageField.text.length) {
        [self.interactor storeCurrentGrossWage:[grossWageField currencyNumber]];
        [grossWageField setText:[grossWageField currencyString]];
    }
    else {
       [self.interactor storeCurrentGrossWage:nil];
    }

    [grossWageField resignFirstResponder];
    
    return YES;
}

- (BOOL)grossWageFieldShouldBeginEditing:(UITextField *)grossWageField {
    // remove euro sign
    grossWageField.text = [grossWageField.text
                              stringByReplacingOccurrencesOfString:@"€" withString:@""];
    grossWageField.text = [grossWageField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return YES;
}

- (BOOL)taxAllowanceFieldShouldReturn:(UITextField *)taxAllowanceField {
    if(!taxAllowanceField) {
        return NO;
    }
    if (taxAllowanceField.text.length) {
        [self.interactor storeCurrentTaxAllowance:[taxAllowanceField currencyNumber]];
        [taxAllowanceField setText:[taxAllowanceField currencyString]];
    }
    else {
        [self.interactor storeCurrentTaxAllowance:nil];
    }

    [taxAllowanceField resignFirstResponder];
    
    return YES;
}

- (BOOL)yearOfBirthFieldShouldReturn:(UITextField *)field {
    if (!field) {
        return NO;
    }
    [self.interactor storeCurrentYearOfBirth:@([field.text integerValue])];
    [field resignFirstResponder];
    
    return YES;
}

- (BOOL)taxAllowanceFieldShouldBeginEditing:(UITextField *)taxAllowanceField {
    // remove euro sign
    taxAllowanceField.text = [taxAllowanceField.text
                              stringByReplacingOccurrencesOfString:@"€" withString:@""];
    taxAllowanceField.text = [taxAllowanceField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return YES;
}

- (void)hasChildrenValueChangedTo:(BOOL)newValue {
    BOOL hasChildren = newValue == YES;
    [self.interactor storeCurrentHasChildrenFlag:hasChildren];
    if (hasChildren) {
        [self.view insertChildAllowanceCell];
    }
    else {
        [self.view removeChildAllowanceCell];
    }
}

- (void)hasChurchTaxValueChangedTo:(BOOL)newValue {
    [self.interactor storeCurrentHasChurchTaxFlag:newValue];
}

- (BOOL)currentHasChildrenValue {
    return [self.interactor currentHasChildrenFlag];
}

- (BOOL)currentHasChurchTaxValue {
    return [self.interactor currenthasChurchTaxFlag];
}

- (NSArray *)stateNamesForDisplay {
    NSArray *states = [self.stateRepository availableStates];
    NSMutableArray *names = [NSMutableArray new];
    for (BNFederalState *state in states) {
        [names addObject:state.name];
    }
    return [names copy];
}

- (NSArray *)availableTaxClasses {
    return [self.interactor taxClasses];
}

- (NSString *)currentFederalState {
    return [self.interactor currentFederalState];
}

- (void)federalStateNameWasSelected:(NSString *)stateName {
    [self.interactor storeCurrentFederalState:[self.stateRepository federalStateByName:stateName]];
}

// Navigating to another views, maybe should move this logic to a special 'Routing' class?

- (void)didSelectHealthInsuranceCell {
    BNHealthInsuranceViewController *destination = [[BNHealthInsuranceViewController alloc] initWithStyle:UITableViewStyleGrouped];
    BNHealthInsurancePresenter *presenter = [[BNHealthInsurancePresenter alloc] init];
    destination.presenter = presenter;
    presenter.interactor = self.interactor;
    [self.view navigateToViewController:destination];
}

- (void)didSelectPensionInsuranceCell {
    BNCommonInsuranceViewController *destination = [[BNCommonInsuranceViewController alloc] initWithStyle:UITableViewStyleGrouped insuranceType:BNInsuranceTypePension];
    [self.view navigateToViewController:destination];
}

- (void)didSelectUnemploymentInsuranceCell {
    BNCommonInsuranceViewController *destination = [[BNCommonInsuranceViewController alloc] initWithStyle:UITableViewStyleGrouped insuranceType:BNInsuranceTypeUnemployment];
    [self.view navigateToViewController:destination];
}

- (void)didSelectTaxClassValueIndex:(NSInteger)dataIndex {
    [self.interactor taxClassSelectedAtDataIndex:dataIndex];
}

- (void)didSelectFederalStateValueIndex:(NSInteger)dataIndex {
    [self.interactor federalStateSelected:[[self.stateRepository availableStates] objectAtIndex:dataIndex]];
}

- (NSDecimalNumber *)currentGrossWageValue {
    return [self.interactor currentGrossWage];
}

- (NSDecimalNumber *)currentTaxAllowanceValue {
    return [self.interactor currentTaxAllowance];
}

- (NSNumber *)currentBirthdayYearValue {
    return [self.interactor currentBirthdayYear];
}

- (NSNumber *)currentTargetYearValue {
    return [self.interactor currentTargetYear];
}

@end

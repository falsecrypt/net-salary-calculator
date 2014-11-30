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
    
    [self.interactor storeCurrentGrossWage:[grossWageField currencyNumber]];
    [grossWageField setText:[grossWageField currencyString]];
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
    [self.interactor storeCurrentTaxAllowance:[taxAllowanceField currencyNumber]];
    [taxAllowanceField setText:[taxAllowanceField currencyString]];
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

- (BOOL)currentHasChildrenValue {
    return [self.interactor currentHasChildrenFlag];
}

- (NSArray *)stateNamesForDisplay {
    NSArray *states = [self.stateRepository availableStates];
    NSMutableArray *names = [NSMutableArray new];
    for (BNFederalState *state in states) {
        [names addObject:state.name];
    }
    return [names copy];
}

- (NSString *)defaultFederalState {
    return [((BNFederalState *)[[self.stateRepository availableStates] firstObject]) name];
}

- (void)federalStateNameWasSelected:(NSString *)stateName {
    [self.interactor storeCurrentFederalState:[self.stateRepository federalStateByName:stateName]];
}

@end

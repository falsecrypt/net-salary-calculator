//
//  BNGrossNetWagePresenter.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 04.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNGrossNetWageView.h"
#import "BNGrossNetWageInteractorIO.h"

/**
 *  UI Logic for the view. Reacts to user interactions and updates the UI.
 *  Sends requests to an interactor, receives and converts the results for efficient displaying in a View.
 */
@interface BNGrossNetWagePresenter : NSObject<BNGrossNetWageInteractorOutput>

@property (nonatomic, weak) id<BNGrossNetWageView> view;
@property (nonatomic, strong) id<BNGrossNetWageInteractorInput> interactor;

// public API for the View

- (BOOL)grossWageFieldShouldReturn:(UITextField *)grossWageField;
- (BOOL)grossWageFieldShouldBeginEditing:(UITextField *)grossWageField;
- (BOOL)taxAllowanceFieldShouldReturn:(UITextField *)taxAllowanceField;
- (BOOL)taxAllowanceFieldShouldBeginEditing:(UITextField *)taxAllowanceField;
- (BOOL)yearOfBirthFieldShouldReturn:(UITextField *)field;
- (void)hasChildrenValueChangedTo:(BOOL)newValue;
- (void)hasChurchTaxValueChangedTo:(BOOL)newValue;
- (BOOL)currentHasChildrenValue;
- (BOOL)currentHasChurchTaxValue;
- (HealthInsuranceType)currentHealthInsurance;
- (void)federalStateNameWasSelected:(NSString *)stateName;
- (NSArray *)stateNamesForDisplay;
- (NSArray *)availableTaxClasses;
- (NSArray*)availableYearsToChoose;
- (NSString *)currentFederalState;
- (void)didSelectHealthInsuranceCell;
- (void)didSelectPensionInsuranceCell;
- (void)didSelectUnemploymentInsuranceCell;
- (void)didSelectTaxClassValueIndex:(NSInteger)dataIndex;
- (void)didSelectFederalStateValueIndex:(NSInteger)dataIndex;
- (void)didTouchSubmitButton;
// current values
- (NSDecimalNumber *)currentGrossWageValue;
- (NSDecimalNumber *)currentTaxAllowanceValue;
- (NSNumber *)currentBirthdayYearValue;
- (NSNumber *)currentTargetYearValue;
- (NSString *)currentPensionInsuranceType;
- (NSString *)currentUnemploymentInsuranceType;
@end

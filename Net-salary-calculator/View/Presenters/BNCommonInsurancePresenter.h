//
//  BNCommonInsurance.h
//  Net_salary_calculator
//
//  Created by Pavel Ermolin on 08.06.15.
//  Copyright (c) 2015 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNGrossNetWageInteractorIO.h"

@protocol BNCommonInsurancePresenter <NSObject>

@property (nonatomic, weak) id<BNGrossNetWageInteractorInput> interactor;

- (void)didSelectStatutoryHealthInsurance;
- (void)didSelectNonInsured;
- (void)didSelectEmployerContributionOnly;
- (void)didSelectEmployeeContributionOnly;
@end

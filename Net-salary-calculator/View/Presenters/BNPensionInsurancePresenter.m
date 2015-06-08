//
//  BNStatutoryInsurancePresenter.m
//  Net_salary_calculator
//
//  Created by Administrator on 30.11.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNPensionInsurancePresenter.h"

@interface BNPensionInsurancePresenter ()

@end

@implementation BNPensionInsurancePresenter

- (void)didSelectStatutoryHealthInsurance {
    [self.interactor storeCurrentInsuranceTypeForPensionInsurance:CommonInsuranceTypeStatutory];
}

- (void)didSelectNonInsured {
    [self.interactor storeCurrentInsuranceTypeForPensionInsurance:CommonInsuranceTypeUninsured];
}

- (void)didSelectEmployerContributionOnly {
   [self.interactor storeCurrentInsuranceTypeForPensionInsurance:CommonInsuranceTypeEmployerContributionOnly];
}

- (void)didSelectEmployeeContributionOnly {
    [self.interactor storeCurrentInsuranceTypeForPensionInsurance:CommonInsuranceTypeEmployeeContributionOnly];
}

@end

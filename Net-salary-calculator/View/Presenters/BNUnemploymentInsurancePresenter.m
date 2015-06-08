//
//  BNUnemploymentInsurancePresenter.m
//  Net_salary_calculator
//
//  Created by Administrator on 30.11.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNUnemploymentInsurancePresenter.h"

@implementation BNUnemploymentInsurancePresenter

- (void)didSelectStatutoryHealthInsurance {
    [self.interactor storeCurrentInsuranceTypeForUnemploymentInsurance:CommonInsuranceTypeStatutory];
}

- (void)didSelectNonInsured {
    [self.interactor storeCurrentInsuranceTypeForUnemploymentInsurance:CommonInsuranceTypeUninsured];
}

- (void)didSelectEmployerContributionOnly {
    [self.interactor storeCurrentInsuranceTypeForUnemploymentInsurance:CommonInsuranceTypeEmployerContributionOnly];
}

- (void)didSelectEmployeeContributionOnly {
    [self.interactor storeCurrentInsuranceTypeForUnemploymentInsurance:CommonInsuranceTypeEmployeeContributionOnly];
}

@end

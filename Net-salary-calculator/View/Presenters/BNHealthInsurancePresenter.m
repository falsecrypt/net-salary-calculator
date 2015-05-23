//
//  BNHealthInsurancePresenter.m
//  Net_salary_calculator
//
//  Created by Administrator on 30.11.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNHealthInsurancePresenter.h"
#import "BNWageUserInput.h"

@implementation BNHealthInsurancePresenter

- (void)didSelectPrivateHealthInsurance {
    [self.interactor storeCurrentHealthInsuranceType:HealthInsuranceTypePrivate];
}

- (void)didSelectStatutoryHealthInsurance {
    [self.interactor storeCurrentHealthInsuranceType:HealthInsuranceTypeStatutory];
}

- (NSInteger)currentSelectedRow {
    HealthInsuranceType type = [self.interactor currentHealthInsuranceType];
    switch (type) {
        case HealthInsuranceTypeStatutory:
            return 0;
        case HealthInsuranceTypePrivate:
            return 1;
        default:
            return 0;
    }
}

@end

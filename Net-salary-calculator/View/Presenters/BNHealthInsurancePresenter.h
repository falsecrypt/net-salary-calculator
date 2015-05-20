//
//  BNHealthInsurancePresenter.h
//  Net_salary_calculator
//
//  Created by Administrator on 30.11.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNGrossNetWageInteractorIO.h"

@interface BNHealthInsurancePresenter : NSObject

@property (nonatomic, weak) id/*<BNHealthInsuranceView>*/ view;
@property (nonatomic, weak) id<BNGrossNetWageInteractorInput> interactor;

- (void)didSelectPrivateHealthInsurance;
- (void)didSelectStatutoryHealthInsurance;
- (NSInteger)currentSelectedRow;
@end

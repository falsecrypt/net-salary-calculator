//
//  BNStatutoryInsurancePresenter.h
//  Net_salary_calculator
//
//  Created by Pavel Ermolin on 30.11.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCommonInsurancePresenter.h"

@interface BNPensionInsurancePresenter : NSObject <BNCommonInsurancePresenter>

@property (nonatomic, weak) id<BNGrossNetWageInteractorInput> interactor;

@end

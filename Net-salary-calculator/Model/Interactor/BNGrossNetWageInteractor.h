//
//  BNGrossNetWageInteractor.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 04.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNGrossNetWageInteractorIO.h"

@class BNWageDataManager;

@interface BNGrossNetWageInteractor : NSObject<BNGrossNetWageInteractorInput>
@property (nonatomic, weak) id<BNGrossNetWageInteractorOutput> output;


- (instancetype)initWithDataManager:(BNWageDataManager *)dataManager;
@end

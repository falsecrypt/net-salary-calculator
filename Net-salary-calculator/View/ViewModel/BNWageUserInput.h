//
//  BNWageUserInput.h
//  Brutto-Netto-Rechner
//
//  Created by Administrator on 02.11.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNFederalState;

typedef NS_ENUM(NSInteger, HealthInsuranceType) {
    HealthInsuranceTypeStatutory, /* Gesetzlich pflichtversichert */
    HealthInsuranceTypePrivate /* Privat versichert */
};

typedef NS_ENUM(NSInteger, CommonInsuranceType) { /* Optionen für Renten- und Arbeitslosenversicherung */
    CommonInsuranceTypeStatutory, /* Gesetzlich */
    CommonInsuranceTypeUninsured, /* Nicht versichert */
    CommonInsuranceTypeEmployerContributionOnly, /* Arbeitgeber Anteil */
    CommonInsuranceTypeEmployeeContributionOnly /* Arbeitnehmer Anteil */
};


@interface BNWageUserInput : NSObject
@property (nonatomic, strong) NSDecimalNumber *grossWage;
@property (nonatomic, strong) NSDecimalNumber *taxAllowance;
@property (nonatomic, strong) NSString *timePeriod; // todo, use enum
@property (nonatomic, strong) NSNumber *taxClass;
@property (nonatomic, assign) BOOL hasChurchTax;
@property (nonatomic, assign) BOOL hasChildren;
@property (nonatomic, strong) BNFederalState* federalState;
@property (nonatomic, strong) NSNumber *yearOfBirth;
@property (nonatomic, assign) HealthInsuranceType healthInsurance;
@property (nonatomic, assign) CommonInsuranceType *pensionInsurance;
@property (nonatomic, assign) CommonInsuranceType *unemploymentInsurance;
@end
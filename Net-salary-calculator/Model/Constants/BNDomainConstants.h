//
//  BNDomainConstants.h
//  Net_salary_calculator
//
//  Created by falsecrypt on 29.05.15.
//  Copyright (c) 2015 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, BNInsuranceType) {
    BNInsuranceTypePension,
    BNInsuranceTypeUnemployment
};

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
//  Brutto-Netto-Rechner
//
//  Created by Administrator on 02.11.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNWageUserInput.h"
#import "BNFederalState.h"

@implementation BNWageUserInput

- (NSString *)description
{
    return [NSString stringWithFormat:@"BNWageUserInput description:%@\ngrossWage: %@\ntaxAllowance: %@\ntimePeriod: %@\ntargetYear: %@\ntaxClass: %@\nhasChurchTax: %i\nhasChildren: %i\nyearOfBirth: %@\nKrankenversicherung: %@\nRentenversicherung: %@\nArbeitslosenversicherung: %@\n",[super description], self.grossWage, self.taxAllowance, self.timePeriod, self.targetYear, self.taxClass, self.hasChurchTax, self.hasChildren, self.yearOfBirth, [self nameForHealthInsuranceType:self.healthInsurance], [self nameForCommonInsuranceType:self.pensionInsurance], [self nameForCommonInsuranceType:self.unemploymentInsurance]];
}

- (NSString*)nameForCommonInsuranceType:(CommonInsuranceType)type {
    switch (type) {
        case CommonInsuranceTypeStatutory:
            return @"Gesetzlich pflichtversichert";
            break;
        case CommonInsuranceTypeUninsured:
            return @"Nicht versichert";
            break;
        case CommonInsuranceTypeEmployerContributionOnly:
            return @"Arbeitegeber Anteil";
            break;
        case CommonInsuranceTypeEmployeeContributionOnly:
            return @"Arbeitnehmer Anteil";
        default:
            return nil;
            break;
    };
    return nil;
}

- (NSString*)nameForHealthInsuranceType:(HealthInsuranceType)type {
    switch (type) {
        case HealthInsuranceTypeStatutory:
            return @"Gesetzlich versichert";
            break;
        case HealthInsuranceTypePrivate:
            return @"Privat versichert";
            break;
        default:
            return nil;
            break;
    };
    return nil;
}

@end

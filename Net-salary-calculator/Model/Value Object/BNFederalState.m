//
//  BNFederalState.m
//  Brutto-Netto-Rechner
//
//  Created by Administrator on 02.11.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNFederalState.h"

@implementation BNFederalState

- (NSString *)description
{
    return [NSString stringWithFormat:@"BNFederalState description:%@\n name: %@\nabbreviation: %@\n",[super description], self.name, self.abbreviation];
}
@end

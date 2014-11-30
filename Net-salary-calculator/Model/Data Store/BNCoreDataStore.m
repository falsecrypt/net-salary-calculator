//
//  BNCoreDataStore.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 06.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNCoreDataStore.h"

@interface BNCoreDataStore ()



@end

@implementation BNCoreDataStore


+ (void)setupCoreDataStack {
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"BNRechnerDB"];
}

@end

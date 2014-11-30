//
//  BNCoreDataStore.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 06.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This data store is responsible for fetching and persisting entities using core data framework.
 */
@interface BNCoreDataStore : NSObject


+ (void)setupCoreDataStack;

@end

//
//  BNWageDataManager.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 06.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNCoreDataStore;

/**
 *  This data manager communicates with interactors, providing view model objects.
 *  It knows the data store and entities (NSManagedObject's).
 */
@interface BNWageDataManager : NSObject

@property (nonatomic, strong) BNCoreDataStore *dataStore;

@end

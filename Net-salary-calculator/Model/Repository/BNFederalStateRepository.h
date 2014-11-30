//
//  BNFederalStateRepository.h
//  Brutto-Netto-Rechner
//
//  Created by Administrator on 02.11.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNFederalState;

@interface BNFederalStateRepository : NSObject


- (NSArray *)availableStates;
- (BNFederalState *)federalStateByName:(NSString *)name;

@end

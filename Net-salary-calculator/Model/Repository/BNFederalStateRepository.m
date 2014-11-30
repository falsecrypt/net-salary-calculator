//
//  BNFederalStateRepository.m
//  Brutto-Netto-Rechner
//
//  Created by Administrator on 02.11.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNFederalStateRepository.h"
#import "BNFederalState.h"

@interface BNFederalStateRepository ()

@property (nonatomic, strong) NSMutableArray *createdStates;

@end

@implementation BNFederalStateRepository


- (id)init {
    self = [super init];
    if (self) {
        _createdStates = [NSMutableArray array];
        [self createStates];
    }
    return self;
}

- (void)createStates {
    [self.createdStates addObject:[self createStateWithName:@"Baden-Württemberg" andAbbr:@"BW"]];
    [self.createdStates addObject:[self createStateWithName:@"Bayern" andAbbr:@"BY"]];
    [self.createdStates addObject:[self createStateWithName:@"Berlin" andAbbr:@"BE"]];
    [self.createdStates addObject:[self createStateWithName:@"Brandenburg" andAbbr:@"BB"]];
    [self.createdStates addObject:[self createStateWithName:@"Bremen" andAbbr:@"HB"]];
    [self.createdStates addObject:[self createStateWithName:@"Hamburg" andAbbr:@"HH"]];
    [self.createdStates addObject:[self createStateWithName:@"Hessen" andAbbr:@"HE"]];
    [self.createdStates addObject:[self createStateWithName:@"Mecklenburg-Vorpommern" andAbbr:@"MV"]];
    [self.createdStates addObject:[self createStateWithName:@"Niedersachsen" andAbbr:@"NI"]];
    [self.createdStates addObject:[self createStateWithName:@"Nordrhein-Westfalen" andAbbr:@"NW"]];
    [self.createdStates addObject:[self createStateWithName:@"Rheinland-Pfalz" andAbbr:@"NP"]];
    [self.createdStates addObject:[self createStateWithName:@"Saarland" andAbbr:@"SL"]];
    [self.createdStates addObject:[self createStateWithName:@"Sachsen" andAbbr:@"SN"]];
    [self.createdStates addObject:[self createStateWithName:@"Sachsen-Anhalt" andAbbr:@"ST"]];
    [self.createdStates addObject:[self createStateWithName:@"Schleswig-Holstein" andAbbr:@"SH"]];
    [self.createdStates addObject:[self createStateWithName:@"Thüringen" andAbbr:@"TH"]];
}

- (BNFederalState *)createStateWithName:(NSString *)name andAbbr:(NSString *)abbr {
    BNFederalState *state = [BNFederalState new];
    [state setName:name];
    [state setAbbreviation:abbr];
    return state;
}

- (BNFederalState *)federalStateByName:(NSString *)name {
    __block BNFederalState* found = nil;
    [self.createdStates enumerateObjectsUsingBlock:^(BNFederalState *obj, NSUInteger index, BOOL *stop) {
        if ([obj.name isEqualToString:name]) {
            found = obj;
            *stop = YES;
        }
    }];
    return found;
}


- (NSArray *)availableStates {
   
    return [_createdStates copy];
}

@end

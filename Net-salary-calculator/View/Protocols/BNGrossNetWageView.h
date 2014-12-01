//
//  BNGrossNetWageView.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 04.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BNGrossNetWageView <NSObject>
- (void)insertChildAllowanceCell;
- (void)removeChildAllowanceCell;
- (void)navigateToViewController:(UIViewController *)toViewController;
@end

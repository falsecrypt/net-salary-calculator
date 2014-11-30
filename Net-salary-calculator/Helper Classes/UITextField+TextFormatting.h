//
//  UITextField+TextFormatting.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 14.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (TextFormatting)

- (NSDecimalNumber *)currencyNumber;
- (NSString *)currencyString;
@end

//
//  BNPickerManagerDelegate.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 28.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BNPickerManagerDelegate <NSObject>

@optional

- (void)pickerCellWasInsertedAtIndexPath:(NSIndexPath *)indexPath;
- (void)pickerCellWasRemovedAtIndexPath:(NSIndexPath *)indexPath;

@end

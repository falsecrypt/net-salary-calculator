//
//  BNPickerDataSource.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 14.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BNPickerManagerDataSource <NSObject>

- (NSString *)cellTitleForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)cellDefaultValueForIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)pickerDataToSelectForIndexPath:(NSIndexPath *)indexPath;


@end

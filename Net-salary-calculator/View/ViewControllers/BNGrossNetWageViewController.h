//
//  BNGrossNetWageViewController.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 04.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNGrossNetWageView.h"
#import "BNPickerManagerDataSource.h"
#import "BNPickerManagerDelegate.h"

@class BNGrossNetWagePresenter;

@interface BNGrossNetWageViewController : UITableViewController<BNGrossNetWageView,BNPickerManagerDataSource,BNPickerManagerDelegate>


@property (nonatomic, strong) BNGrossNetWagePresenter *presenter;

@end

//
//  BNHealthInsuranceViewController.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 03.10.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNHealthInsurancePresenter;

@interface BNHealthInsuranceViewController : UITableViewController

@property (nonatomic, strong) BNHealthInsurancePresenter *presenter;

@end

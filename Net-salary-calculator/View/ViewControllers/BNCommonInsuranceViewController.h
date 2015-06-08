//
//  BNPensionInsuranceViewController.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 05.10.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNCommonInsurancePresenter.h"

@interface BNCommonInsuranceViewController : UITableViewController

@property (nonatomic, strong) id<BNCommonInsurancePresenter> presenter;

- (id)initWithStyle:(UITableViewStyle)style insuranceType:(BNInsuranceType)type;


@end

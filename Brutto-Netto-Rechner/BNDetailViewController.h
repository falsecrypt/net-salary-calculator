//
//  BNDetailViewController.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 02.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end

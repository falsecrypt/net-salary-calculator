//
//  BNLabelInputCell.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 06.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNLabelInputCell : UITableViewCell

@property (nonatomic, weak) UITextField *valueField;

- (void)setCustomTitle:(NSString *)title;
- (void)setCustomPlaceholder:(NSString *)placeholder;

@end

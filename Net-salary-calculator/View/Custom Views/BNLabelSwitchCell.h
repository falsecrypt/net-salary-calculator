//
//  BNLabelSwitchCell.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 20.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SwitchControlState) {
    SwitchControlStateOn,
    SwitchControlStateOff
};

@interface BNLabelSwitchCell : UITableViewCell

- (void)setCustomTitle:(NSString *)title;
- (void)configureSwitchControlWithTarget:(id)target action:(SEL)action controlEvents:(UIControlEvents)controlEvents;
- (void)setSwitchControlState:(SwitchControlState)state;
- (void)setSwitchTag:(NSInteger)switchTag;
@end

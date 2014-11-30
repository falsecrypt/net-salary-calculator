//
//  BNLabelSwitchCell.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 20.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNLabelSwitchCell.h"

@interface BNLabelSwitchCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UISwitch *inlineSwitch;

@end

@implementation BNLabelSwitchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // Create and set subviews
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UISwitch* switchObj = [[UISwitch alloc] init];
        switchObj.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self.contentView addSubview:switchObj];
        self.inlineSwitch = switchObj;
        
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // debug
        //self.titleLabel.backgroundColor = [UIColor lightGrayColor];
        //self.valueField.backgroundColor = [UIColor lightGrayColor];
        
    }
    return self;
}

- (void)configureSwitchControlWithTarget:(id)target action:(SEL)action controlEvents:(UIControlEvents)controlEvents {
    if (self.inlineSwitch) {
        [self.inlineSwitch addTarget:target action:action forControlEvents:controlEvents];
    }
}

// set frames of our subviews
- (void)layoutSubviews {
    CGSize size = self.contentView.frame.size;
    CGFloat titleWidth = floorf(size.width/2.0) + 20.0;
    [self.titleLabel setFrame:CGRectMake(15.0, 0.0, titleWidth, size.height)];
    CGSize switchSize = [self.inlineSwitch sizeThatFits:CGSizeZero];
    self.inlineSwitch.frame = CGRectMake(size.width - switchSize.width - 15.0f,
                         (size.height - switchSize.height) / 2.0f,
                         switchSize.width,
                         switchSize.height);
    
    
    
}

- (void)setSwitchControlState:(SwitchControlState)state {
    if (!self.inlineSwitch) {
        return;
    }
    switch (state) {
        case SwitchControlStateOn:
            [self.inlineSwitch setOn:YES];
            break;
        case SwitchControlStateOff:
            [self.inlineSwitch setOn:NO];
            break;
        default:
            break;
    }
}

- (void)setCustomTitle:(NSString *)title {
    if (self.titleLabel) {
        [self.titleLabel setText:title];
        [self.titleLabel setNeedsDisplay];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  BNLabelDetailCell.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 03.10.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNLabelDetailCell.h"

@interface BNLabelDetailCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation BNLabelDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // Create and set subviews
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0f];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // debug
        self.titleLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

// set frames of our subviews
- (void)layoutSubviews {
    CGSize size = self.contentView.frame.size;
    CGFloat titleWidth = size.width - 10.0;
    [self.titleLabel setFrame:CGRectMake(15.0, 0.0, titleWidth, size.height)];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCustomTitle:(NSString *)title {
    if (self.titleLabel) {
        [self.titleLabel setText:title];
        [self.titleLabel setNeedsDisplay];
    }
}

@end

//
//  BNLabelInputCell.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 06.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNLabelInputCell.h"

@interface BNLabelInputCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation BNLabelInputCell

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
        
        UITextField *valueField = [[UITextField alloc] init];
        valueField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
        valueField.adjustsFontSizeToFitWidth = YES;
        valueField.borderStyle = UITextBorderStyleNone;
        valueField.minimumFontSize = 15.0;
        [valueField setTextAlignment:NSTextAlignmentRight];
        [valueField setTextColor:[UIColor blackColor]];
        valueField.returnKeyType = UIReturnKeyDone;
        valueField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [self.contentView addSubview:valueField];
        self.valueField = valueField;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // debug
        //self.titleLabel.backgroundColor = [UIColor lightGrayColor];
        //self.valueField.backgroundColor = [UIColor lightGrayColor];
        
    }
    return self;
}

// set frames of our subviews
- (void)layoutSubviews {
    CGSize size = self.contentView.frame.size;
    CGFloat titleWidth = floorf(size.width/2.0) - 20.0;
    [self.titleLabel setFrame:CGRectMake(15.0, 0.0, titleWidth, size.height)];
    [self.valueField setFrame:CGRectMake(titleWidth + 20.0, 0.0, titleWidth + 10.0, size.height)];
    
}

- (void)setCustomTitle:(NSString *)title {
    if (self.titleLabel) {
        [self.titleLabel setText:title];
        [self.titleLabel setNeedsDisplay];
    }
}

- (void)setCustomPlaceholder:(NSString *)placeholder {
    if (self.valueField) {
        [self.valueField setPlaceholder:placeholder];
        [self.valueField setNeedsDisplay];
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

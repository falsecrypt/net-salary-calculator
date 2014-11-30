//
//  BNPickerViewCell.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 07.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNPickerViewCell.h"

@implementation BNPickerViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        [self.contentView addSubview:pickerView];
        self.picker = pickerView;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
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

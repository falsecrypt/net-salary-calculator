//
//  BNPensionInsuranceViewController.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 05.10.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNCommonInsuranceViewController.h"

// todo refactor: move such enums to constants.h

typedef NS_ENUM(NSInteger, BNCellNumber) {
    FirstCell = 0,
    SecondCell,
    ThirdCell,
    FourthCell,
    FifthCell,
    SixthCell,
    SeventhCell,
    EighthCell,
    NinthCell
};

typedef NS_ENUM(NSInteger, BNSectionNumber) {
    FirstSection = 0,
    SecondSection,
    ThirdSection,
    FourthSection
};

@interface BNCommonInsuranceViewController ()
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;
@property (nonatomic, assign) BNInsuranceType insuranceType;
@end

@implementation BNCommonInsuranceViewController

- (id)initWithStyle:(UITableViewStyle)style insuranceType:(BNInsuranceType)type {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _insuranceType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.insuranceType == BNInsuranceTypePension) {
        self.title = @"Rentenversicherung";
    }
    else if (self.insuranceType == BNInsuranceTypeUnemployment) {
       self.title = @"Arbeitslosenversicherung";
    }
    
    self.lastSelectedIndexPath = [NSIndexPath indexPathForRow:FirstCell inSection:FirstSection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (indexPath.section == FirstSection) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        if (indexPath.row == FirstCell) {
            cell = [self configureAsStatutoryHealthInsuranceCell:cell];
        }
        else if (indexPath.row == SecondCell) {
            cell = [self configureAsNonInsuredCell:cell];
        }
        else if (indexPath.row == ThirdCell) {
            cell = [self configureAsEmployerContributionOnlyCell:cell];
        }
        else if (indexPath.row == FourthCell) {
            cell = [self configureAsEmployeeContributionOnlyCell:cell];
        }
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UITableViewCell* cellCheck = [tableView
                                  cellForRowAtIndexPath:indexPath];
    cellCheck.accessoryType = UITableViewCellAccessoryCheckmark;
    cellCheck.textLabel.textColor = [UIColor blackColor];
    
    if (self.lastSelectedIndexPath && [self.lastSelectedIndexPath isEqual:indexPath] == NO) {
        UITableViewCell* uncheckCell = [tableView
                                        cellForRowAtIndexPath:self.lastSelectedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
        uncheckCell.textLabel.textColor = [UIColor grayColor];
    }
    self.lastSelectedIndexPath = indexPath;
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* uncheckCell = [tableView
                                    cellForRowAtIndexPath:indexPath];
    uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    uncheckCell.textLabel.textColor = [UIColor grayColor];
}

- (UITableViewCell *)configureAsStatutoryHealthInsuranceCell:(UITableViewCell *)cell {
    
    cell.textLabel.text = @"Gesetzlich pflichtversichert";
    cell.accessoryType = UITableViewCellAccessoryCheckmark; // todo, set current selected
    
    return cell;
}

- (UITableViewCell *)configureAsNonInsuredCell:(UITableViewCell *)cell {
    
    cell.textLabel.text = @"Nicht versichert";
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}

- (UITableViewCell *)configureAsEmployerContributionOnlyCell:(UITableViewCell *)cell {
    
    cell.textLabel.text = @"Arbeitgeber Anteil";
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}

- (UITableViewCell *)configureAsEmployeeContributionOnlyCell:(UITableViewCell *)cell {
    
    cell.textLabel.text = @"Arbeitnehmer Anteil";
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}


@end

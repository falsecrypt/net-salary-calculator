//
//  BNHealthInsuranceViewController.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 03.10.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNHealthInsuranceViewController.h"
#import "BNLabelInputCell.h"
#import "BNLabelSwitchCell.h"


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

@interface BNHealthInsuranceViewController ()<UITextFieldDelegate>
@property (nonatomic, assign) NSInteger numberOfSections;
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;
@property (nonatomic, strong) NSIndexPath *privateHealthInsuranceCellIndexPath;
@end

@implementation BNHealthInsuranceViewController

extern NSString *titleInputCell;
NSInteger monthlyContributionField = 0;
extern NSString *titleSwitchCell;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Krankenversicherung";
    self.numberOfSections = 1;
    // set default or last selection option for insurance
    self.lastSelectedIndexPath = [NSIndexPath indexPathForRow:FirstCell inSection:FirstSection];
    self.privateHealthInsuranceCellIndexPath = [NSIndexPath indexPathForRow:SecondCell inSection:FirstSection];
    
    [self.tableView registerClass:[BNLabelInputCell class] forCellReuseIdentifier:titleInputCell];
    [self.tableView registerClass:[BNLabelSwitchCell class] forCellReuseIdentifier:titleSwitchCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if (textField.tag == grossWageField) {
//        // forward to presenter
//        return [self.presenter grossWageFieldShouldReturn:textField];
//    }
//    else if (textField.tag == taxAllowanceField) {
//        return [self.presenter taxAllowanceFieldShouldReturn:textField];
//    }
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    if (textField.tag == grossWageField) {
//        return [self.presenter grossWageFieldShouldBeginEditing:textField];
//    }
//    else if (textField.tag == taxAllowanceField) {
//        return [self.presenter taxAllowanceFieldShouldBeginEditing:textField];
//    }
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == FirstSection) {
        return 2;
    }
    else if (section == SecondSection) {
        return 2;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == SecondSection) {
        return @"Angaben zu Ihrer privaten KV";
    }
    else {
        return nil;
    }
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
            cell = [self configureAsPrivateHealthInsuranceCell:cell];
        }
    }
    else if (indexPath.section == SecondSection) {
        if (indexPath.row == FirstCell) {
            cell = (BNLabelInputCell *)[tableView dequeueReusableCellWithIdentifier:titleInputCell forIndexPath:indexPath];
            cell = [self configureAsMonthlyContributionCell:(BNLabelInputCell *)cell];
        }
        else if (indexPath.row == SecondCell) {
            cell = (BNLabelSwitchCell *)[tableView dequeueReusableCellWithIdentifier:titleSwitchCell forIndexPath:indexPath];
            cell = [self configureAsEmployerAllowanceCell:(BNLabelSwitchCell *)cell];
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
    
    if ([indexPath isEqual:self.privateHealthInsuranceCellIndexPath]) {
        // show other input fields
        [tableView beginUpdates];
        self.numberOfSections = 2;
        [tableView insertSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [tableView endUpdates];
    }
    else {
        [tableView beginUpdates];
        self.numberOfSections = 1;
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
    }
    
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

// todo: should be called from presenter!

// 'gesetzlich pflichtversichert'
- (UITableViewCell *)configureAsStatutoryHealthInsuranceCell:(UITableViewCell *)cell {
    
    cell.textLabel.text = @"Gesetzliche Krankenversicherung";
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    return cell;
}

// 'privat versichert'
- (UITableViewCell *)configureAsPrivateHealthInsuranceCell:(UITableViewCell *)cell {
    
    cell.textLabel.text = @"Private Krankenversicherung";
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.textColor = [UIColor grayColor]; // not selected
    
    return cell;
}

- (UITableViewCell *)configureAsMonthlyContributionCell:(BNLabelInputCell *)cell {
    [cell setCustomTitle:@"Ihr Beitrag"];
    [cell setCustomPlaceholder:@"monatlich, in EUR"];
    cell.valueField.delegate = self;
    cell.valueField.tag = monthlyContributionField;
    return cell;
}

- (UITableViewCell *)configureAsEmployerAllowanceCell:(BNLabelSwitchCell *)cell {
    [(BNLabelSwitchCell *)cell setCustomTitle:@"Arbeitgeberzuschuss"];
    // set correct state
//    BOOL current = [self.presenter currentHasChildrenValue];
//    if (current == NO) {
//        [(BNLabelSwitchCell *)cell setSwitchControlState:SwitchControlStateOff];
//    }
//    else {
//        [(BNLabelSwitchCell *)cell setSwitchControlState:SwitchControlStateOn];
//    }
    [(BNLabelSwitchCell *)cell configureSwitchControlWithTarget:self action:@selector(switchChanged:) controlEvents:UIControlEventValueChanged];
    return cell;
}

- (void)switchChanged:(id)sender {
    UISwitch* switcher = (UISwitch*)sender;
    __unused BOOL hasChildren = switcher.on;
    
    //[self.presenter hasChildrenValueChangedTo:hasChildren];
}


@end

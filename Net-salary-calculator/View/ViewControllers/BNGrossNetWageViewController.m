//
//  BNGrossNetWageViewController.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 04.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNGrossNetWageViewController.h"
#import "BNLabelInputCell.h"
#import "BNInlinePickerViewManager.h"
#import "BNGrossNetWagePresenter.h"
#import "BNLabelSwitchCell.h"
#import "BNLabelDetailCell.h"
#import "BNHealthInsuranceViewController.h"
#import "BNCommonInsuranceViewController.h"

/*
 Felder:
 
 Bruttolohn
 Abrechnungszeitraum
 Steuerklasse
 Jährl. Steuerfreibetrag
 Alter/Geb Jahr
 In der Kirche?
 Kinderfreibetrag
 Bundesland
 Krankenversicherung
 Rentenversicherungspflicht: ja/nein
 
 Ergebnis Arbeitnehemer:
 
    Nettogehalt
    Sozialabgaben:
        Rentenversicherung
        Arbeitslosenversicherung
        Pflegeversicherung
        Krankenversicherung
        Gesamt
    Steuern:
        Lohnsteuer
        Soli-Zuschlag
        Kirchensteuer
        Gesamt
 
 Arbeitgeberbelastung:
 Bruttogehalt + Rentenversicherung
 + Arbeitslosenversicherung
 + Pflegeversicherung
 + Krankenversicherung
 
 */

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
    FourthSection,
    FifthSection
};


@interface BNGrossNetWageViewController () <UITextFieldDelegate>
@property (nonatomic, strong) BNInlinePickerViewManager *pickerViewCellsManager;
@property (nonatomic, strong) NSMutableDictionary *pickerIndexPathForIdentifier;
@property (nonatomic, strong) NSIndexPath *hasChildrenSwitchCellIndexPath;
@property (nonatomic, assign) NSInteger numberOfInsertedCells;
@property (nonatomic, assign) NSInteger numberOfVisiblePickerCells;
@property (nonatomic, assign) NSInteger birthdayYearCellRow;
@property (nonatomic, strong) NSIndexPath *healthInsuranceCellIndexPath;
@property (nonatomic, strong) NSIndexPath *pensionInsuranceCellIndexPath;
@property (nonatomic, strong) NSIndexPath *unemploymentInsuranceCellIndexPath;
@end

@implementation BNGrossNetWageViewController

NSString *titleInputCell = @"titleInputCell";
NSString *titleSwitchCell = @"titleSwitchCell";
NSString *titleDetailCell = @"titleDetailCell";
NSInteger grossWageField = 0;
NSInteger taxAllowanceField = 1;
NSInteger birthdayYearField = 2;
NSString * const TimePeriodCellKey = @"timePeriodCell";
NSString * const YearSelectorCellKey = @"yearSelectorCell";
NSString * const TaxClassSelectorCellKey = @"taxClassSelectorCell";
NSString * const ChurchTaxCellKey = @"churchTaxCell";
NSString * const StateCellKey = @"germanStateCell";
NSString * const ChildAllowanceCellKey = @"childAllowanceCell";


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setup];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.title = @"Gehaltsrechner";
    [self.tabBarItem setTitle:@"Gehaltsrechner"];
    _numberOfInsertedCells = 0;
    _birthdayYearCellRow = 8;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[BNLabelInputCell class] forCellReuseIdentifier:titleInputCell];
    [self.tableView registerClass:[BNLabelSwitchCell class] forCellReuseIdentifier:titleSwitchCell];
    [self.tableView registerClass:[BNLabelDetailCell class] forCellReuseIdentifier:titleDetailCell];
    
    
    self.healthInsuranceCellIndexPath = [NSIndexPath indexPathForRow:FirstCell inSection:SecondSection];
    self.hasChildrenSwitchCellIndexPath = [NSIndexPath indexPathForRow:EighthCell inSection:FirstSection];
    self.pensionInsuranceCellIndexPath = [NSIndexPath indexPathForRow:FirstCell inSection:ThirdSection];
    self.unemploymentInsuranceCellIndexPath = [NSIndexPath indexPathForRow:FirstCell inSection:FourthSection];
    
    
    CGFloat tableWidth = CGRectGetWidth(self.tableView.frame);
    CGFloat buttonWidth = tableWidth - 10.0 - 10.0;
    UIView *footerContainer = [[UIView alloc]initWithFrame:CGRectMake(0.0, 25.0, tableWidth, 44.0)];
    [footerContainer setBackgroundColor:[UIColor clearColor]];
    footerContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeSystem];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit setTitle:@"Berechnen" forState:UIControlStateNormal];
    [submit.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0f]];
    [submit setBackgroundColor:[UIColor colorWithRed:46.0/256.0 green:204.0/256.0 blue:113.0/256.0 alpha:1.0]];
    [submit setFrame:CGRectMake(10.0, 25.0, buttonWidth, 44.0)];
    submit.layer.cornerRadius = 4;
    [footerContainer addSubview:submit];
    self.tableView.tableFooterView = footerContainer;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60.0, 0);
}

// Defines some specific behavior for inline picker cells
- (BNInlinePickerViewManager *)pickerViewCellsManager {
    if (!_pickerViewCellsManager) {
        _pickerViewCellsManager = [[BNInlinePickerViewManager alloc] initWithTableView:self.tableView pickerIndexPaths:[self pickerIndexPaths]];
        _pickerViewCellsManager.presenter = self.presenter; // pass weak reference
        _pickerViewCellsManager.pickerDataSource = self;
    }
    return _pickerViewCellsManager;
}

- (NSMutableDictionary *)pickerIndexPathForIdentifier {
    if (!_pickerIndexPathForIdentifier) {
        _pickerIndexPathForIdentifier = [NSMutableDictionary dictionary];
        [_pickerIndexPathForIdentifier setObject:[NSIndexPath indexPathForRow:SecondCell inSection:FirstSection] forKey:TimePeriodCellKey];
        [_pickerIndexPathForIdentifier setObject:[NSIndexPath indexPathForRow:ThirdCell inSection:FirstSection] forKey:YearSelectorCellKey];
        [_pickerIndexPathForIdentifier setObject:[NSIndexPath indexPathForRow:FifthCell inSection:FirstSection] forKey:TaxClassSelectorCellKey];
        [_pickerIndexPathForIdentifier setObject:[NSIndexPath indexPathForRow:SixthCell inSection:FirstSection] forKey:ChurchTaxCellKey];
        [_pickerIndexPathForIdentifier setObject:[NSIndexPath indexPathForRow:SeventhCell inSection:FirstSection] forKey:StateCellKey];
    }
    return _pickerIndexPathForIdentifier;
}

- (BOOL)isPickerCellInitiallyVisible:(NSIndexPath *)indexPath {
    if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:StateCellKey]]) {
        return NO;
    }
    return YES;
}

- (NSInteger)numberOfVisiblePickerCells {
    if (!_numberOfVisiblePickerCells) {
        NSArray *allIndexPaths = [self.pickerIndexPathForIdentifier allValues];
        _numberOfVisiblePickerCells = [allIndexPaths count];
        for (NSIndexPath *pickerCell in allIndexPaths) {
            if ([self isPickerCellInitiallyVisible:pickerCell] == NO) {
                _numberOfVisiblePickerCells--;
            }
        }
    }
    return _numberOfVisiblePickerCells;
}


- (NSArray *)pickerIndexPaths {
    
    return [self.pickerIndexPathForIdentifier allValues];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == grossWageField) {
        // forward to presenter
        return [self.presenter grossWageFieldShouldReturn:textField];
    }
    else if (textField.tag == taxAllowanceField) {
        return [self.presenter taxAllowanceFieldShouldReturn:textField];
    }
    else if (textField.tag == birthdayYearField) {
        return [self.presenter yearOfBirthFieldShouldReturn:textField];
    }
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.pickerViewCellsManager hideVisiblePickerCell];
    if (textField.tag == grossWageField) {
        return [self.presenter grossWageFieldShouldBeginEditing:textField];
    }
    else if (textField.tag == taxAllowanceField) {
        return [self.presenter taxAllowanceFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == birthdayYearField) {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return !([newString length] > 4); // limit the year to 4 characters
    }
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

// No Footer please
-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == SecondSection) {
        return @"Krankenversicherung";
    }
    else if (section == ThirdSection) {
        return @"Rentenversicherung";
    }
    else if (section == FourthSection) {
        return @"Arbeitslosenversicherung";
    }
    else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger rows = 0;
    if (section == FirstSection) {
        rows = self.numberOfVisiblePickerCells + 5 /* number other fields */ + [self.pickerViewCellsManager numberOfVisibleDatePickers] + self.numberOfInsertedCells;
    }
    else if (section == SecondSection) {
        rows = 1; // options for social security contributions
    }
    else if (section == ThirdSection) {
        rows = 1; // options for social security contributions
    }
    else if (section == FourthSection) {
        rows = 1; // options for social security contributions
    }
    else if (section == FifthSection) {
        rows = 1;
    }
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // DatePickerCell
    if ([indexPath isEqual:[self.pickerViewCellsManager indexPathOfVisibleDatePicker]]) {
        return [self.pickerViewCellsManager heightOfDatePickerCell];
    }
    
    // All other cells
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"getting cell number %li", (long)indexPath.row);
    if ([self.pickerViewCellsManager isManagedPickerCell:indexPath]) {
        
        return [self.pickerViewCellsManager tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    UITableViewCell *cell = nil;
    if (indexPath.section == FirstSection) {
        NSInteger currentRow = indexPath.row;
        if ([self.pickerViewCellsManager numberOfVisibleDatePickers] != 0 && indexPath.row > self.pickerViewCellsManager.indexPathOfVisibleDatePicker.row ) {
            currentRow--;
        }
        if (currentRow == FirstCell) {
            cell = (BNLabelInputCell *)[tableView dequeueReusableCellWithIdentifier:titleInputCell forIndexPath:indexPath];
            cell = [self configureAsGrossWageCell:(BNLabelInputCell *)cell];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        else if (currentRow == FourthCell) {
            cell = (BNLabelInputCell *)[tableView dequeueReusableCellWithIdentifier:titleInputCell forIndexPath:indexPath];
           cell = [self configureAsTaxAllowanceCell:(BNLabelInputCell *)cell];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        else if (currentRow == EighthCell) {
            //self.hasChildrenSwitchCellIndexPath = indexPath;
            cell = (BNLabelSwitchCell *)[tableView dequeueReusableCellWithIdentifier:titleSwitchCell forIndexPath:indexPath];
            cell = [self configureAsHasChildrenCell:(BNLabelSwitchCell *)cell];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        else if (currentRow == self.birthdayYearCellRow) {
            cell = (BNLabelInputCell *)[tableView dequeueReusableCellWithIdentifier:titleInputCell forIndexPath:indexPath];
            cell = [self configureAsBirthdayYearCell:cell];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Another cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Another cell"];
            }
        }
    }
    else if (indexPath.section == SecondSection) {
        if (indexPath.row == FirstCell) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Another cell"];
            if (!cell) {
                cell = [self createCellWithCustomLabel];
            }
            cell = [self configureAsHealthInsuranceCell:cell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    else if (indexPath.section == ThirdSection) {
        if (indexPath.row == FirstCell) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Another cell"];
            if (!cell) {
                cell = [self createCellWithCustomLabel];
            }
            cell = [self configureAsPensionInsuranceCell:cell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    else if (indexPath.section == FourthSection) {
        if (indexPath.row == FirstCell) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Another cell"];
            if (!cell) {
                cell = [self createCellWithCustomLabel];
            }
            cell = [self configureAsUnemploymentInsuranceCell:cell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
//    else if (indexPath.section == FifthSection) {
//        // Submit - Button
//        
//    }
    
    
    return cell;
}

- (UITableViewCell *)createCellWithCustomLabel {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Another cell"];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    [titleLabel setTextColor:[UIColor blackColor]];
    CGSize size = cell.contentView.frame.size;
    CGFloat titleWidth = size.width - 40.0;
    [titleLabel setFrame:CGRectMake(15.0, 0.0, titleWidth, size.height)];
    [cell.contentView addSubview:titleLabel];
    titleLabel.tag = 4123;
    return cell;
}

- (UITableViewCell *)configureAsGrossWageCell:(BNLabelInputCell *)cell {
    [cell setCustomTitle:@"Bruttolohn"];
    [cell setCustomPlaceholder:@"Ihr Bruttolohn in EUR"];
    cell.valueField.delegate = self;
    cell.valueField.tag = grossWageField;
    return cell;
}

- (UITableViewCell *)configureAsTaxAllowanceCell:(BNLabelInputCell *)cell {
    [cell setCustomTitle:@"Steuerfreibetrag"];
    [cell setCustomPlaceholder:@"Jährlich in EUR"];
    cell.valueField.delegate = self;
    cell.valueField.tag = taxAllowanceField;
    return cell;
}

- (UITableViewCell *)configureAsHealthInsuranceCell:(UITableViewCell *)cell {
    UILabel *title = (UILabel *)[cell viewWithTag:4123];
    [title setText:@"Gesetzlich pflichtversichert"];
    return cell;
}

- (UITableViewCell *)configureAsPensionInsuranceCell:(UITableViewCell *)cell {
    UILabel *title = (UILabel *)[cell viewWithTag:4123];
    [title setText:@"Gesetzlich pflichtversichert"];
    return cell;
}

- (UITableViewCell *)configureAsUnemploymentInsuranceCell:(UITableViewCell *)cell {
    UILabel *title = (UILabel *)[cell viewWithTag:4123];
    [title setText:@"Gesetzlich pflichtversichert"];
    return cell;
}

- (UITableViewCell *)configureAsHasChildrenCell:(BNLabelSwitchCell *)cell {
    [(BNLabelSwitchCell *)cell setCustomTitle:@"Haben Sie Kinder?"];
    // set correct state
    BOOL current = [self.presenter currentHasChildrenValue];
    if (current == NO) {
        [(BNLabelSwitchCell *)cell setSwitchControlState:SwitchControlStateOff];
    }
    else {
        [(BNLabelSwitchCell *)cell setSwitchControlState:SwitchControlStateOn];
    }
    [(BNLabelSwitchCell *)cell configureSwitchControlWithTarget:self action:@selector(switchChanged:) controlEvents:UIControlEventValueChanged];
    return cell;
}

- (UITableViewCell *)configureAsBirthdayYearCell:(UITableViewCell *)cell {
    [(BNLabelInputCell *)cell setCustomTitle:@"Ihr Geburtsjahr"];
    ((BNLabelInputCell *)cell).valueField.delegate = self;
    [(BNLabelInputCell *)cell setCustomPlaceholder:@""];
    ((BNLabelInputCell *)cell).valueField.tag = birthdayYearField;
    return cell;
}

- (void)switchChanged:(id)sender {
    UISwitch* switcher = (UISwitch*)sender;
    BOOL hasChildren = switcher.on;
    if (hasChildren) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:NinthCell inSection:FirstSection];
        [self.pickerIndexPathForIdentifier setObject:newIndexPath forKey:ChildAllowanceCellKey];
        [self.pickerViewCellsManager addManagedIndexPath:newIndexPath];
        self.birthdayYearCellRow = 9;
    }
    else {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:NinthCell inSection:FirstSection];
        [self.pickerIndexPathForIdentifier removeObjectForKey:ChildAllowanceCellKey];
        [self.pickerViewCellsManager removeManagedIndexPath:newIndexPath];
        self.birthdayYearCellRow = 8;
    }
    
    
    [self.presenter hasChildrenValueChangedTo:hasChildren];
}

- (void)insertChildAllowanceCell {
    NSIndexPath *indexPathOfNewCell = [NSIndexPath indexPathForRow:self.hasChildrenSwitchCellIndexPath.row + 1
                                                                   inSection:self.hasChildrenSwitchCellIndexPath.section];
    //NSLog(@"inserting: row with switch control: %li", (long)self.hasChildrenSwitchCellIndexPath.row);
    //NSLog(@"inserting row: %li", (long)indexPathOfNewCell.row);
    
    [self.tableView beginUpdates];
    self.numberOfInsertedCells++;
    [self.tableView insertRowsAtIndexPaths:@[indexPathOfNewCell]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
    [self.tableView scrollToRowAtIndexPath:indexPathOfNewCell atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)removeChildAllowanceCell {

    NSIndexPath *indexPathOfCellToRemove = [NSIndexPath indexPathForRow:self.hasChildrenSwitchCellIndexPath.row + 1
                                                         inSection:self.hasChildrenSwitchCellIndexPath.section];
    //NSLog(@"removing: row with switch control: %li", (long)self.hasChildrenSwitchCellIndexPath.row);
    //NSLog(@"removing row: %li", (long)indexPathOfCellToRemove.row);
    
    [self.tableView beginUpdates];
    self.numberOfInsertedCells--;
    [self.tableView deleteRowsAtIndexPaths:@[indexPathOfCellToRemove]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];

}


// presenter should decide what to do
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Date Cells
    if ([self.pickerViewCellsManager isManagedPickerCell:indexPath]) {
        return [self.pickerViewCellsManager tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else if ([indexPath isEqual:self.healthInsuranceCellIndexPath]) {
        UITableViewController *destination = [[BNHealthInsuranceViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:destination animated:YES];
    }
    else if ([indexPath isEqual:self.pensionInsuranceCellIndexPath]) {
        UITableViewController *destination = [[BNCommonInsuranceViewController alloc] initWithStyle:UITableViewStyleGrouped insuranceType:BNInsuranceTypePension];
        [self.navigationController pushViewController:destination animated:YES];
    }
    else if ([indexPath isEqual:self.unemploymentInsuranceCellIndexPath]) {
        UITableViewController *destination = [[BNCommonInsuranceViewController alloc] initWithStyle:UITableViewStyleGrouped insuranceType:BNInsuranceTypeUnemployment];
        [self.navigationController pushViewController:destination animated:YES];
    }
}

// TODO move this to presenter

#pragma mark - BNPickerManagerDataSource

- (NSString *)cellTitleForIndexPath:(NSIndexPath *)indexPath {
    NSString *title = @"";
    if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:TimePeriodCellKey]]) {
        title = @"Zeitraum";
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:YearSelectorCellKey]]) {
        title = @"Abrechnungsjahr";
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:TaxClassSelectorCellKey]]) {
        title = @"Steuerklasse";
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:ChurchTaxCellKey]]) {
        title = @"Kirchensteuer";
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:StateCellKey]]) {
        title = @"Bundesland";
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:ChildAllowanceCellKey]]) {
        title = @"Kinderfreibetrag";
    }
    return title;
}

- (NSString *)cellDefaultValueForIndexPath:(NSIndexPath *)indexPath {
    NSString *value = @"";
    if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:TimePeriodCellKey]]) {
        value = @"Jahr";
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:YearSelectorCellKey]]) {
        value = @"2014"; // todo current year?
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:TaxClassSelectorCellKey]]) {
        value = @"Klasse 1";
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:ChurchTaxCellKey]]) {
        value = @"Ja";
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:StateCellKey]]) {
        value = [self.presenter defaultFederalState];
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:ChildAllowanceCellKey]]) {
        value = @"0";
    }
    
    return value;
    
}

- (NSArray *)pickerDataToSelectForIndexPath:(NSIndexPath *)indexPath {
    NSArray *data = @[];
    if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:TimePeriodCellKey]]) {
        data = @[ @"Woche", @"Monat", @"Jahr"];
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:YearSelectorCellKey]]) {
        data = @[ @"2011", @"2012", @"2013", @"2014"];
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:TaxClassSelectorCellKey]]) {
        data = @[ @"Klasse 1", @"Klasse 2", @"Klasse 3", @"Klasse 3", @"Klasse 4", @"Klasse 4 mit Faktor", @"Klasse 5", @"Klasse 6"];
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:ChurchTaxCellKey]]) {
        data = @[ @"Ja", @"Nein"];
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:StateCellKey]]) {
        data = [self.presenter stateNamesForDisplay];
    }
    else if ([indexPath isEqual:[self.pickerIndexPathForIdentifier objectForKey:ChildAllowanceCellKey]]) {
        data = @[ @"0",
                  @"0.5",
                  @"1",
                  @"1.5",
                  @"2",
                  @"2.5",
                  @"3",
                  @"3.5",
                  @"4",
                  @"4.5",
                  @"5",
                  @"5.5",
                  @"6"];
    }
    
    return data;
}

#pragma mark - BNPickerManagerDelegate

- (void)pickerCellWasInsertedAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.hasChildrenSwitchCellIndexPath.row + 1) {
        NSIndexPath *correctedPath = [NSIndexPath indexPathForRow:self.hasChildrenSwitchCellIndexPath.row + 1
                                                        inSection:self.hasChildrenSwitchCellIndexPath.section];
        self.hasChildrenSwitchCellIndexPath = correctedPath;
    }
}

- (void)pickerCellWasRemovedAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.hasChildrenSwitchCellIndexPath.row) {
        NSIndexPath *correctedPath = [NSIndexPath indexPathForRow:self.hasChildrenSwitchCellIndexPath.row - 1
                                                        inSection:self.hasChildrenSwitchCellIndexPath.section];
        self.hasChildrenSwitchCellIndexPath = correctedPath;
    }
}


@end

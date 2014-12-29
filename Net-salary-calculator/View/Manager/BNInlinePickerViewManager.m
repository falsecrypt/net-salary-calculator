//
//  BNInlinePickerViewManager.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 07.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNInlinePickerViewManager.h"
#import "BNPickerViewCell.h"
#import "BNPickerManagerDataSource.h"
#import "BNPickerManagerDelegate.h"
#import "BNGrossNetWagePresenter.h"


static NSString * const PickerCellIdentifier = @"PickerCellIdentifier";
static NSString * const RightDetailCellIdentifier = @"RightDetailCellIdentifier";


@interface BNInlinePickerViewManager ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *pickerIndexPaths;
@property (nonatomic, weak) UITableView *managedTableView;

@property (assign) NSInteger pickerCellRowHeight;
@property (nonatomic, assign) NSInteger currentSelectedPickerRow;
@property (nonatomic, strong) NSArray *pickerData; // todo refactor
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@end

@implementation BNInlinePickerViewManager

- (id)initWithTableView:(UITableView *)tableView pickerIndexPaths:(NSArray *)indexPaths
{
    self = [super init];
    if (self) {
        if (indexPaths && [indexPaths isKindOfClass:[NSArray class]]) {
            _pickerIndexPaths = [indexPaths mutableCopy];
        }
        if (tableView && [tableView isKindOfClass:[UITableView class]]) {
            _managedTableView = tableView;
        }
        _currentSelectedPickerRow = 2; // 'Year' is default
        
    }
    return self;
}

// todo, use presenter class
- (NSArray *)pickerData {
    _pickerData = [self.pickerDataSource pickerDataToSelectForIndexPath:self.currentIndexPath];
    return _pickerData;
}

- (void)addManagedIndexPath:(NSIndexPath *)indexPath {
    [self.pickerIndexPaths addObject:indexPath];
}

- (void)removeManagedIndexPath:(NSIndexPath *)indexPath {
    [self.pickerIndexPaths removeObject:indexPath];
}

#pragma mark - Selecting rows

- (BOOL)isManagedPickerCell:(NSIndexPath *)indexPath
{
    if (self.indexPathOfVisibleDatePicker && (self.indexPathOfVisibleDatePicker.row < indexPath.row) && (self.indexPathOfVisibleDatePicker.section == indexPath.section)) {
        // there is a visible picker above this cell
        NSIndexPath *correctedIndexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
        if ([self.pickerIndexPaths containsObject:correctedIndexPath]) {
            return true;
        }
        else {
            return false;
        }
    }
    else if ([self.pickerIndexPaths containsObject:indexPath] || [indexPath isEqual:self.indexPathOfVisibleDatePicker]) {
        return true;
    }
    return false;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    
    // Work out identifier to use based on indexPath
    if ([indexPath isEqual:self.indexPathOfVisibleDatePicker]) {
        identifier = PickerCellIdentifier;
    }
    else {
        identifier = RightDetailCellIdentifier;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // If cell couldn't be dequeued, create a new one
    if (!cell) {
        if (identifier == PickerCellIdentifier) {
            cell = [[BNPickerViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:identifier];
        }
        else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:identifier];
        }
    }
    
    if ([identifier isEqualToString:RightDetailCellIdentifier]) {
        // todo move to view controller, data from presenter
        // if a picker is visible above then the current indexpath row is wrong
        if (self.indexPathOfVisibleDatePicker && self.indexPathOfVisibleDatePicker.row < indexPath.row) {
            indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1
                                           inSection:indexPath.section];
        }
        cell.textLabel.text = [self.pickerDataSource cellTitleForIndexPath:indexPath];
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f]];
        [cell.textLabel setTextColor:[UIColor grayColor]];
        cell.detailTextLabel.text = [self.pickerDataSource cellCurrentValueForIndexPath:indexPath];
        [cell.detailTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    // Visible Picker cell
    else if ([identifier isEqualToString:PickerCellIdentifier]) {
        // Set value of datePicker
        [((BNPickerViewCell *) cell).picker selectRow:self.currentSelectedPickerRow inComponent:0 animated:NO];
        [((BNPickerViewCell *) cell).picker setDelegate:self];
        [((BNPickerViewCell *) cell).picker setDataSource:self];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isManagedPickerCell:indexPath]) {
        
        // If picker already visible for a different cell, remember where it was and remove it
        NSIndexPath *pickerIndex = self.indexPathOfVisibleDatePicker;
        if (pickerIndex != nil && (pickerIndex.row - 1 != indexPath.row || pickerIndex.section != indexPath.section)) {
            pickerIndex = self.indexPathOfVisibleDatePicker;
            NSIndexPath *cellShowingPicker = [NSIndexPath indexPathForRow:pickerIndex.row - 1
                                                                inSection:pickerIndex.section];
            
            [self togglePickerForRowAtIndexPath:cellShowingPicker];
            
            // Get the new indexPath for this cell (accounting for the offset in
            // row number where the just-deleted picker was before this one)
            if (pickerIndex.section == indexPath.section && pickerIndex.row <= indexPath.row) {
                indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1
                                               inSection:indexPath.section];
            }
        }

        self.currentIndexPath = indexPath;

        
        // Toggle the picker
        [self togglePickerForRowAtIndexPath:indexPath];
        
        [self setValueOnVisiblePicker];
        
        // Deselect the row
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    }
    
}



#pragma mark - UIPickerViewDelegate

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    
    self.currentSelectedPickerRow = row;
    
    // Update text
    [self refreshSelectedValue];
    
    [self.pickerDataSource didSelectPickerRow:row atIndexPath:self.currentIndexPath];
    
    //[self.presenter federalStateNameWasSelected:self.pickerData[row]];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerData[row];
}

#pragma mark - UIPickerViewDataSource

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (void)refreshSelectedValue
{
    // Get indexPath for cell before date picker
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.indexPathOfVisibleDatePicker.row - 1
                                                inSection:self.indexPathOfVisibleDatePicker.section];
    UITableViewCell *cellWithCurrentValue = [self.managedTableView cellForRowAtIndexPath:indexPath];
    // todo refactor, should come from presenter
    
    cellWithCurrentValue.detailTextLabel.text = self.pickerData[self.currentSelectedPickerRow];
}

- (void)togglePickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableView *tableView = self.managedTableView;
    
    // Get indexPath of (potential) datePicker cell below this cell
    NSIndexPath *indexPathOfVisibleDatePicker = [NSIndexPath indexPathForRow:indexPath.row + 1
                                                                   inSection:indexPath.section];
    
    [tableView beginUpdates];
    
    // Case: No currently visible picker
    if (self.indexPathOfVisibleDatePicker == nil) {
        
        // Remember the indexPath of the picker cell
        self.indexPathOfVisibleDatePicker = indexPathOfVisibleDatePicker;
        
        // Insert the picker cell
        [tableView insertRowsAtIndexPaths:@[indexPathOfVisibleDatePicker]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        
        // Change date colour on cell
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.textColor = [UIColor redColor];
        
        [tableView endUpdates];
        [self.managedTableView scrollToRowAtIndexPath:indexPathOfVisibleDatePicker atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        [self.pickerDataSource pickerCellWasInsertedAtIndexPath:indexPathOfVisibleDatePicker];
        
    }
    
    // Case: Picker is currently visible for the selected cell
    else if ([self.indexPathOfVisibleDatePicker isEqual:indexPathOfVisibleDatePicker]) {
        
        // Set picker cell property to nil
        self.indexPathOfVisibleDatePicker = nil;
        
        // Delete the picker cell
        [tableView deleteRowsAtIndexPaths:@[indexPathOfVisibleDatePicker]
                         withRowAnimation:UITableViewRowAnimationMiddle];
        
        // Change date colour on cell
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.textColor = [UIColor blackColor];
        //[tableView reloadData];
        [tableView endUpdates];
        
        [self.pickerDataSource pickerCellWasRemovedAtIndexPath:indexPathOfVisibleDatePicker];
        
    }
    
    // Case: Picker is currently visible for a different cell
    else {
        
        // Do nothing (caller should remove visible picker first)
    }

}

- (void)setValueOnVisiblePicker
{
    // Get the index path of the currently visible date picker
    NSIndexPath *indexPath = self.indexPathOfVisibleDatePicker;
    
    // Exit if no date picker is currently visible
    if (indexPath == nil) return;
    
    // Get the cell containing the picker
    BNPickerViewCell *cell = (BNPickerViewCell *)[self.managedTableView cellForRowAtIndexPath:indexPath];
    
    // Set the value
    [((BNPickerViewCell *) cell).picker selectRow:self.currentSelectedPickerRow inComponent:0 animated:NO];
}

- (NSInteger)numberOfVisibleDatePickers
{
    return self.indexPathOfVisibleDatePicker == nil ? 0 : 1;
}

- (CGFloat)heightOfDatePickerCell
{
    BNPickerViewCell *pickerCell = [self.managedTableView dequeueReusableCellWithIdentifier:PickerCellIdentifier];
    CGFloat height = pickerCell.picker.bounds.size.height;
    return (height == 0) ? 216 : height;
}

- (void)hideVisiblePickerCell {
    if (self.indexPathOfVisibleDatePicker) {
        NSIndexPath *cellBefore = [NSIndexPath indexPathForRow:self.indexPathOfVisibleDatePicker.row - 1
                                                    inSection:self.indexPathOfVisibleDatePicker.section];
        [self togglePickerForRowAtIndexPath:cellBefore];
    }
}
@end

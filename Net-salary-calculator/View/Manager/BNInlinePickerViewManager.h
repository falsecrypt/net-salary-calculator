//
//  BNInlinePickerViewManager.h
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 07.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BNPickerManagerDataSource;
@protocol BNPickerManagerDelegate;
@class BNGrossNetWagePresenter;

@interface BNInlinePickerViewManager : NSObject

- (id)initWithTableView:(UITableView *)tableView pickerIndexPaths:(NSArray *)indexPaths;

// keep track which indexPath points to the cell with UIPicker
@property (nonatomic, strong) NSIndexPath *indexPathOfVisibleDatePicker;

@property (nonatomic, weak) id<BNPickerManagerDataSource,BNPickerManagerDelegate> pickerDataSource;
@property (nonatomic, weak) BNGrossNetWagePresenter *presenter;

/**
 *  Whether the index path specified is managed by this instance.
 */
- (BOOL)isManagedPickerCell:(NSIndexPath *)indexPath;

/**
 *  The tableView should call this in its identically named delegate method for the cells managed by this instance.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  The tableView should call this in its identically named delegate method for the cells managed by this instance.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  The number of visible pickers managed by this instance. Since there can currently only be one visible picker at a time, this method will only return either 0 or 1.
 */
- (NSInteger)numberOfVisibleDatePickers;

/**
 *  The height of a cell containing a date picker.
 */
- (CGFloat)heightOfDatePickerCell;

- (void)hideVisiblePickerCell;

- (void)addManagedIndexPath:(NSIndexPath *)indexPath;

- (void)removeManagedIndexPath:(NSIndexPath *)indexPath;

@end

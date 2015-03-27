//
//  FlipsideViewController.h
//  Countdown To
//
//  Created by Mark McGookin on 25/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *txtTitle;
@property (retain, nonatomic) IBOutlet UIDatePicker *dpDateTimePicker;

@property (assign, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
- (void)saveToUserDefaults;
- (void)retrieveFromUserDefaults;

@end

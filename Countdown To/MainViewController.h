//
//  MainViewController.h
//  Countdown To
//
//  Created by Mark McGookin on 25/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"
@class CountdownTimer;
@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (retain, nonatomic) IBOutlet UILabel *lblWeeks;
@property (retain, nonatomic) IBOutlet UILabel *lblDays;
@property (retain, nonatomic) IBOutlet UILabel *lblHours;
@property (retain, nonatomic) IBOutlet UILabel *lblMinutes;
@property (retain, nonatomic) IBOutlet UILabel *lblSeconds;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) CountdownTimer *theCountdown;
@property (retain, nonatomic) IBOutlet UILabel *lblWarning;

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

- (void)retrieveFromUserDefaults;

@end

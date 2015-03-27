//
//  FlipsideViewController.m
//  Countdown To
//
//  Created by Mark McGookin on 25/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"

@implementation FlipsideViewController

@synthesize txtTitle = _txtTitle;
@synthesize dpDateTimePicker = _dpDateTimePicker;
@synthesize delegate = _delegate;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)saveToUserDefaults
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
	if (standardUserDefaults) 
    {
        //save the current values to the defaults
        [standardUserDefaults setObject:_dpDateTimePicker.date forKey:@"date"];
        [standardUserDefaults setObject:_txtTitle.text forKey:@"title"];
		[standardUserDefaults synchronize];
	}
}

-(void)retrieveFromUserDefaults
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSDate *Date=[NSDate date];
    _dpDateTimePicker.minimumDate=Date;

	if (standardUserDefaults)
    {
        //If there are defaults, load them and start the timer
        if([standardUserDefaults objectForKey:@"date"])
        {
            _dpDateTimePicker.date = [standardUserDefaults objectForKey:@"date"];
            _txtTitle.text = [standardUserDefaults objectForKey:@"title"];
        }
    }
    else
    {
        _dpDateTimePicker.date=Date;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textBoxName {
	[textBoxName resignFirstResponder];
	return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTxtTitle:nil];
    [self setDpDateTimePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self retrieveFromUserDefaults];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveToUserDefaults];
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
        return NO;
    } else {
        //return YES;
        return NO;
    }
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self saveToUserDefaults];
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (void)dealloc {
    [_txtTitle release];
    [_dpDateTimePicker release];
    [super dealloc];
}
@end

//
//  MainViewController.m
//  Countdown To
//
//  Created by Mark McGookin on 25/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "CountdownTimer.h"

@implementation MainViewController

@synthesize lblWeeks = _lblWeeks;
@synthesize lblDays = _lblDays;
@synthesize lblHours = _lblHours;
@synthesize lblMinutes = _lblMinutes;
@synthesize lblSeconds = _lblSeconds;
@synthesize lblTitle = _lblTitle;
@synthesize flipsidePopoverController = _flipsidePopoverController;
@synthesize theCountdown = _theCountdown;
@synthesize lblWarning = _lblWarning;

bool blIsStarted = false;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)StartCountDown
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    _theCountdown.dtTheDate = [standardUserDefaults objectForKey:@"date"];
    blIsStarted = true;
}

- (void)countDownLoop
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSTimeInterval temp = [[standardUserDefaults objectForKey:@"date"] timeIntervalSinceNow];
    
    if((int)temp > 0) //If there is more than a second left
    {
         _lblWarning.hidden = TRUE;
        
        int wholeWeeks = [_theCountdown getWeeks:temp];
        temp = temp - (wholeWeeks * [_theCountdown secondsPerWeek]);
        
        int wholeDays = [_theCountdown getDays:temp];
        temp = temp - (wholeDays * [_theCountdown secondsPerDay]);
            
        int wholeHours = [_theCountdown getHours:temp];
        temp = temp - (wholeHours * [_theCountdown secondsPerHour]);
            
        int wholeMinutes = [_theCountdown getMinutes:temp];
        temp = temp - (wholeMinutes * [_theCountdown secondsPerMinute]);
        
        if(blIsStarted)
        {
            //If the counter is running, update the label
            _lblWeeks.text = [NSString stringWithFormat:@"%02d", wholeWeeks];
            _lblDays.text = [NSString stringWithFormat:@"%02d", wholeDays];
            _lblHours.text = [NSString stringWithFormat:@"%02d", wholeHours];
            _lblMinutes.text = [NSString stringWithFormat:@"%02d", wholeMinutes];
            _lblSeconds.text = [NSString stringWithFormat:@"%02d", (int)temp];
        }
    }
    else
    {
        //The time is either now or in the past
        _lblWarning.hidden = FALSE;
        
        //If the counter is running, update the label
        _lblWeeks.text = [NSString stringWithFormat:@"00"];
        _lblDays.text = [NSString stringWithFormat:@"00"];
        _lblHours.text = [NSString stringWithFormat:@"00"];
        _lblMinutes.text = [NSString stringWithFormat:@"00"];
        _lblSeconds.text = [NSString stringWithFormat:@"00"];
    }
}

-(void)retrieveFromUserDefaults
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	if ([standardUserDefaults objectForKey:@"title"])
    {
        //If there are defaults, load them and start the timer
        _lblTitle.text = [standardUserDefaults objectForKey:@"title"];
        [self StartCountDown];
    }
    else
    {
        //There are no defaults - Show the settings views
        [self performSegueWithIdentifier:@"showAlternate" sender:self];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Insert code here to initialize your application
    _theCountdown = [[CountdownTimer alloc] init];
    
    //Run a timer on the countDownLoop every second
    [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(countDownLoop) userInfo:nil repeats:YES];

}

- (void)viewDidUnload
{
    [self setLblWeeks:nil];
    [self setLblDays:nil];
    [self setLblHours:nil];
    [self setLblMinutes:nil];
    [self setLblSeconds:nil];
    [self setLblTitle:nil];
    [self setLblWarning:nil];
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
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
    {
        //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
        return NO;
    } 
    else 
    {
        //return YES;
        return NO;
    }
    
    //return YES;
    return  NO;
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
        [self retrieveFromUserDefaults];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (void)dealloc
{
    [_flipsidePopoverController release];
    [_lblWeeks release];
    [_lblDays release];
    [_lblHours release];
    [_lblMinutes release];
    [_lblSeconds release];
    [_lblTitle release];
    [_lblWarning release];
    [super dealloc];
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

@end

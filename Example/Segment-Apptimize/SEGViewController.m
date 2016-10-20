//
//  SEGViewController.m
//  Segment-Apptimize
//
//  Created by Prateek Srivastava on 04/27/2016.
//  Copyright (c) 2016 Prateek Srivastava. All rights reserved.
//

#import "SEGViewController.h"
#import "Apptimize/Apptimize.h"
#import "Analytics/SEGAnalytics.h"

@interface SEGViewController ()

@end


@implementation SEGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonLogin:(id)sender {
    [[SEGAnalytics sharedAnalytics] identify:@"some user"];
}

- (IBAction)buttonLogout:(id)sender {
    [[SEGAnalytics sharedAnalytics] reset];
}

- (IBAction)logGuid:(id)sender {
    NSLog(@"The Apptimize GUID is: %@", [Apptimize userID]);
}

@end

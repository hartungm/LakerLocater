//
//  LakerLocatorViewController.m
//  Laker Locator
//
//  Created by Michael Hartung on 12/9/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import "LakerLocatorViewController.h"
#import "TweetinLakersTableViewController.h"

@interface LakerLocatorViewController ()
@property (strong, nonatomic) MKPointAnnotation *pin;
@end

@implementation LakerLocatorViewController

-(void)viewDidLoad
{
	self.searchRadiusSlider.minimumValue = 1;
	self.searchRadiusSlider.maximumValue = 400;
	self.searchRadiusSlider.value = 5;
	self.searchRadiusLabel.text = [NSString stringWithFormat:@"Set your search Radius: %.0f miles", self.searchRadiusSlider.value];
	self.searchBarButton.enabled = NO;
}

- (IBAction)searchRadiusSliderMoved:(id)sender
{
	self.searchRadiusLabel.text = [NSString stringWithFormat:@"Set your search Radius: %.0f miles", self.searchRadiusSlider.value];
}

- (IBAction)pinDrop:(id)sender
{
	if (self.pin)
	{
		[self.mapView removeAnnotation:self.pin];
	}
	CGPoint touchPoint = [sender locationInView:self.mapView];
	CLLocationCoordinate2D coordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
	self.pin = [[MKPointAnnotation alloc] init];
	self.pin.coordinate = coordinate;
	[self.mapView addAnnotation:self.pin];
	self.searchBarButton.enabled = YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	TweetinLakersTableViewController *controller = [segue destinationViewController];
	controller.coordinate = self.pin.coordinate;
	controller.radius = (int)self.searchRadiusSlider.value;
}

@end

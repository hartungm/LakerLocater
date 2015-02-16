//
//  TweetsMapViewController.m
//  Laker Locator
//
//  Created by Michael Hartung on 12/9/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import "TweetsMapViewController.h"

@implementation TweetsMapViewController

-(void)viewDidLoad
{
	[super viewDidLoad];
	self.mapView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	for(NSDictionary *tweet in self.tweets)
	{
		MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
		NSArray *coordinates = tweet[@"coordinates"][@"coordinates"];
		annotation.coordinate = CLLocationCoordinate2DMake([coordinates[1] doubleValue], [coordinates[0] doubleValue]);
		annotation.title = tweet[@"user"][@"name"];
		annotation.subtitle = tweet[@"text"];
		[self.mapView addAnnotation:annotation];
	}
	[self.mapView showAnnotations:self.mapView.annotations animated:YES];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	if([annotation isKindOfClass:[MKUserLocation class]])
	{
		return nil;
	}
	
	if([annotation isKindOfClass:[MKPointAnnotation class]])
	{
		MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinView"];
		if(!pinView)
		{
			pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinView"];
			pinView.canShowCallout = YES;
			pinView.image = [UIImage imageNamed:@"twitter-icon"];
			return pinView;
		}
		else
		{
			pinView.annotation = annotation;
			return pinView;
		}
	}
	return nil;
}

@end

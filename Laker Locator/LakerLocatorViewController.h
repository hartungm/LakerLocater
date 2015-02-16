//
//  LakerLocatorViewController.h
//  Laker Locator
//
//  Created by Michael Hartung on 12/9/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface LakerLocatorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBarButton;
@property (weak, nonatomic) IBOutlet UILabel *searchRadiusLabel;
@property (weak, nonatomic) IBOutlet UISlider *searchRadiusSlider;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)searchRadiusSliderMoved:(id)sender;
- (IBAction)pinDrop:(UIGestureRecognizer*)sender;
@end

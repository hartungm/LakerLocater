//
//  TweetinLakersTableViewController.h
//  Laker Locator
//
//  Created by Michael Hartung on 12/9/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface TweetinLakersTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *showTweetsMapButton;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) int radius;
@end

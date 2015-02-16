//
//  TweetinLakersTableViewController.m
//  Laker Locator
//
//  Created by Michael Hartung on 12/9/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import "TweetinLakersTableViewController.h"
#import "TweetTableViewCell.h"
#import "HttpCommunication.h"
#import "TweetsMapViewController.h"

@interface TweetinLakersTableViewController ()
@property (nonatomic, strong) NSMutableArray *tweets;
@end

@implementation TweetinLakersTableViewController

-(void)viewDidLoad
{
	[super viewDidLoad];
	self.tableView.estimatedRowHeight = 66.0;
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	self.tweets = [[NSMutableArray alloc] init];
	ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
	[accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
		if (granted)
		{
			ACAccount *account = [[[NSArray alloc] initWithArray:[accountStore accountsWithAccountType:accountType]] firstObject];
			if([account.accountType.identifier isEqualToString:ACAccountTypeIdentifierTwitter])
			{
				NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
				NSDictionary *params = @{@"screen_name": account.username,
										 @"count": @"50",
										 @"q": @"gvsu",
										 @"geocode": [NSString stringWithFormat:@"%f,%f,%dmi",self.coordinate.latitude, self.coordinate.longitude, self.radius]};
				SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:params];
				[request setAccount:account];
				[request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
					if(urlResponse.statusCode == 200)
					{
						NSError *parsingError = nil;
						NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parsingError];
						self.tweets = json[@"statuses"];
						if(!parsingError)
						{
							dispatch_sync(dispatch_get_main_queue(), ^{
								[self.tableView reloadData];
							});
						}
					}
				}];
			}
		 }
	}];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.tweets.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	NSDictionary *object = self.tweets[indexPath.row];
	cell.tweetTextView.text = [object objectForKey:@"text"];
	cell.tweetImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", object[@"user"][@"profile_image_url"]]]]];
	return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	TweetsMapViewController *dest = [segue destinationViewController];
	dest.tweets = self.tweets;
}

@end

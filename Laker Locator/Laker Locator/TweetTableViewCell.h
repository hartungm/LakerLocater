//
//  TweetTableViewCell.h
//  Laker Locator
//
//  Created by Michael Hartung on 12/9/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UIImageView *tweetImage;
@end

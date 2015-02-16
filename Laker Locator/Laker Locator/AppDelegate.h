//
//  AppDelegate.h
//  Laker Locator
//
//  Created by Michael Hartung on 12/9/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly) int networkActivityCounter;
- (void) incrementNetworkCounter;
- (void) decrementNetworkCounter;
- (void) resetNetworkCounter;
@end


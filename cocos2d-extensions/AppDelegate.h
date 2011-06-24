//
//  AppDelegate.h
//  cocos2d-extensions
//
//  Created by Keisuke Hata on 11/06/22.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end

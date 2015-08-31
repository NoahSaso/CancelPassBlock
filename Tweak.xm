@interface SBLockScreenDeviceBlockViewController : UIViewController
@end

@interface SBDeviceLockController : NSObject
+ (id)sharedController;
- (void)_clearBlockedState;
@end

@interface CancelPassWindow : UIWindow
- (void)promptForUnlock;
@end

@implementation CancelPassWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	if(point.x <= 50.f && point.y <= 70.f)
		[self promptForUnlock];
	return nil;
}

- (void)promptForUnlock {
	[[%c(SBDeviceLockController) sharedController] _clearBlockedState];
}

@end

%hook SBLockScreenDeviceBlockViewController

- (void)loadView {
	%orig;
	// Create and add tap
	CancelPassWindow *window = [[CancelPassWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	window.windowLevel = UIWindowLevelStatusBar + 999.f;
	[window makeKeyAndVisible];
}

%end

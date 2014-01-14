#import <UIKit/UIKit.h>


@interface SBApplicationController {}
+(id)sharedInstance;
-(id)applicationWithDisplayIdentifier:(id)bundleIdentifier;
@end

@interface SBApplication {}
-(id)displayIdentifier;
@end

@interface SBUIController : NSObject {}
-(void)activateApplicationAnimated:(id)application;
@end

static NSString *appToRedirect;
static NSString *appToOpen;
BOOL enabled;

static void LoadPrefs() {
	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:@"var/mobile/Library/Preferences/com.jakej.openotherprefs.plist"];
	appToRedirect = [[prefs objectForKey:@"appToRedirect"] retain];
	appToOpen = [[prefs objectForKey:@"appToOpen"] retain];
	enabled = [[prefs objectForKey:@"enabled"] boolValue];
	[prefs release];
}

%hook SBUIController

-(void)activateApplicationAnimated:(id)application {
	LoadPrefs();
	if (enabled) {
		if ([[application displayIdentifier] isEqualToString: appToRedirect]) {
			SBApplication *app = [[%c(SBApplicationController) sharedInstance] applicationWithDisplayIdentifier:appToOpen];
			[[%c(SBUIController) sharedInstance] activateApplicationAnimated:app];
		} else {
			%orig;
		}
	} else {
		%orig;
	}
}

%end
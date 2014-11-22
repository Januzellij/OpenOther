#import <AppList/AppList.h>

@interface SBApplicationController
+(id)sharedInstance;
-(id)applicationWithBundleIdentifier:(id)arg1;
-(id)applicationWithDisplayIdentifier:(id)arg1;
@end

@interface SBApplication
-(id)bundleIdentifier;
-(id)displayIdentifier;
@end

@interface SBUIController : NSObject
-(void)activateApplicationAnimated:(id)arg1;
@end

static NSString *appToOpen;
static NSDictionary *prefs;
BOOL enabled;

static void loadPrefs() {
	prefs = [[NSDictionary alloc] initWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.jakej.openotherprefs.plist"]];
	appToOpen = [prefs objectForKey:@"RED"];
	enabled = [[prefs objectForKey:@"enabled"] boolValue];
}

%hook SBUIController

-(void)activateApplicationAnimated:(id)arg1 {
	loadPrefs();
	if (enabled) {
		if ([arg1 respondsToSelector:@selector(displayIdentifier:)]) { // on iOS 7
			if ([[prefs objectForKey:@"ATR"] isEqualToString:[arg1 displayIdentifier]]) {
				SBApplication *app = [[%c(SBApplicationController) sharedInstance] applicationWithDisplayIdentifier:appToOpen];
				[[%c(SBUIController) sharedInstance] activateApplicationAnimated:app];
			} else {
				%orig;
			}
		} else { // on iOS 8
			if ([[prefs objectForKey:@"ATR"] isEqualToString:[arg1 bundleIdentifier]]) {
				SBApplication *app = [[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:appToOpen];
				[[%c(SBUIController) sharedInstance] activateApplicationAnimated:app];
			} else {
				%orig;
			}
		}
	} else {
		%orig;
	}
}

%end
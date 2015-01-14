@interface SBApplicationController
+(id)sharedInstance;
-(id)applicationWithBundleIdentifier:(id)arg1;
@end

@interface SBApplication
-(id)bundleIdentifier;
@end

@interface SBUIController : NSObject
-(void)activateApplicationAnimated:(id)arg1;
@end

%hook SBUIController

-(void)activateApplicationAnimated:(id)arg1 {
	NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.jakej.openotherprefs.plist"]];
	BOOL enabled = [[prefs objectForKey:@"enabled"] boolValue];
	if (enabled) {
		NSString *appToOpen = nil;
		NSString *bundleID = [arg1 bundleIdentifier];

		if ([[prefs objectForKey:@"ATR1"] isEqualToString:bundleID]) {
			appToOpen = [prefs objectForKey:@"RED1"];
		} else if ([[prefs objectForKey:@"ATR2"] isEqualToString:bundleID]) {
			appToOpen = [prefs objectForKey:@"RED2"];
		} else if ([[prefs objectForKey:@"ATR3"] isEqualToString:bundleID]) {
			appToOpen = [prefs objectForKey:@"RED3"];
		}

		if (appToOpen != nil) {
			SBApplication *app = [[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:appToOpen];
			[[%c(SBUIController) sharedInstance] activateApplicationAnimated:app];
		} else {
			%orig;
		}
	} else {
		%orig;
	}
}

%end
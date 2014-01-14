@interface PSViewController : UIViewController
@end

@interface PSListController : PSViewController{
        NSArray *_specifiers;
}

-(NSArray *)loadSpecifiersFromPlistName:(NSString *)name target:(id)target;
@end

@interface OpenOtherPrefsListController: PSListController {
}
@end

@implementation OpenOtherPrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"OpenOtherPrefs" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc

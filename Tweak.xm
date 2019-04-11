#define PLIST_PATH @"/var/mobile/Library/Preferences/com.gilshahar7.pearlfingerprefs.plist"
#define kBundlePath @"/Library/Application Support/PearlFingerBundle.bundle"




static void loadPrefs() {
	//NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH]; 
    //delay = [[prefs objectForKey:@"delay"] floatValue]; 
}


%hook SBDashBoardPearlUnlockBehavior
-(void)_handlePearlFailure{
    %orig;
	NSBundle *bundle = [[[NSBundle alloc] initWithPath:kBundlePath] autorelease];
	NSString *imagePath = [bundle pathForResource:@"finger@3x" ofType:@"png"];
	UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
	UIImageView *myImageView = [[UIImageView alloc] initWithImage:img];
	[myImageView setFrame:CGRectMake(([[UIApplication sharedApplication] keyWindow].frame.size.width/2) - (img.size.width/2),
                             ([[UIApplication sharedApplication] keyWindow].frame.size.height / 2) - (img.size.height / 2),
                             img.size.width, 
                             img.size.height)];
	[[[UIApplication sharedApplication] keyWindow] addSubview:myImageView];
	
	    [UIView animateWithDuration:0.4 delay:1.5 options:0 animations:^{
         // Animate the alpha value of your imageView from 1.0 to 0.0 here
         myImageView.alpha = 0.0f;
     } completion:^(BOOL finished) {
         // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
         myImageView.hidden = YES;
     }];
}
%end



%ctor{
    loadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.gilshahar7.pearlfingerprefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}

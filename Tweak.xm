
#define kBundlePath @"/Library/Application Support/PearlFingerBundle.bundle"

static UILabel *myLabel = nil;
static UIView *myView = nil;


%hook SBDashBoardPearlUnlockBehavior
-(void)_handlePearlFailure{
  %orig;
  if(myLabel == nil){
    myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIApplication sharedApplication] keyWindow].frame.size.width - 20, 700)];
    myLabel.text = @"🖕";
    myLabel.font = [myLabel.font fontWithSize:300];
    myLabel.numberOfLines = 1;
    myLabel.adjustsFontSizeToFitWidth = YES;
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.textColor = [UIColor blackColor];
    myLabel.textAlignment = NSTextAlignmentCenter;
    myView = [[UIView alloc] initWithFrame:CGRectMake(([[UIApplication sharedApplication] keyWindow].frame.size.width/2) - (myLabel.frame.size.width/2), ([[UIApplication sharedApplication] keyWindow].frame.size.height / 2) - (myLabel.frame.size.height / 2),
    myLabel.frame.size.width,
    myLabel.frame.size.height)];
    [myView addSubview:myLabel];
  }

  myView.alpha = 0.0f;

  [[[UIApplication sharedApplication] keyWindow] addSubview:myView];

  [UIView animateWithDuration:0.2
                            delay:0.0
                          options: UIViewAnimationOptionCurveEaseInOut
                       animations:^{
                           myView.alpha = 1.0;

  }completion:nil];

  [UIView animateWithDuration:0.2
                            delay:2.2
                          options: UIViewAnimationOptionCurveEaseInOut
                       animations:^{
                           myView.alpha = 0.0;
  } completion:nil];


}
%end

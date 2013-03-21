//
//  ViewController.h
//  Tap Me
//
//  Created by Onur Ak on 3/21/13.
//  Copyright (c) 2013 Onur Ak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *timerLabel;

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)buttonPressed:(id)sender;

@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger seconds;
@property (strong, nonatomic) NSTimer *timer;


@property AVAudioPlayer *buttonBeep;
@property AVAudioPlayer *secondBeep;
@property AVAudioPlayer *backgroundMusic;

@end

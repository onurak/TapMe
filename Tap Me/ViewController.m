//
//  ViewController.m
//  Tap Me
//
//  Created by Onur Ak on 3/21/13.
//  Copyright (c) 2013 Onur Ak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString *)type
{
 
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSError *error;
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (!audioPlayer) {
        NSLog(@"%@",[error description]);
    }
    
    return audioPlayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
    
    _scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_score.png"]];
    _timerLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_time.png"]];
    
    _buttonBeep = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
    _secondBeep = [self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
    _backgroundMusic = [self setupAudioPlayerWithFile:@"HallOfTheMountainKing" type:@"mp3"];

    [self setupGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupGame {
    
    _seconds = 30;
    _count = 0;
    
    _timerLabel.text = [NSString stringWithFormat:@"Time: %i", _seconds];
    _scoreLabel.text = [NSString stringWithFormat:@"Score\n%i", _count];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(updateLabelAndTime)
                                           userInfo:nil
                                            repeats:YES];
    
    [_backgroundMusic setVolume:0.3];
    [_backgroundMusic play];
}

- (void)updateLabelAndTime {
    _seconds--;
    _timerLabel.text = [NSString stringWithFormat:@"Time: %i", _seconds];
    
    [_secondBeep play];
    
    if (_seconds == 0) {
        [_timer invalidate];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time is up!"
                                                        message:[NSString stringWithFormat:@"You scored %i points", _count]
                                                       delegate:self
                                              cancelButtonTitle:@"Play Again"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self setupGame];
}

- (IBAction)buttonPressed:(id)sender {
    
    _count++;
    
    _scoreLabel.text = [NSString stringWithFormat:@"Score\n%i", _count];
    
    
    [_buttonBeep play];
}
@end

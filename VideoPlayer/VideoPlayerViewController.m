//
//  VideoPlayerViewController.m
//  VideoPlayer
//
//  Created by Benjamin Myers on 10/3/14.
//  Copyright (c) 2014 AppGuys.biz. All rights reserved.
//

#import "VideoPlayerViewController.h"

@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)playMovie:(id)sender {
	NSURL *url = [NSURL URLWithString:
      @"http://www.benjaminmyers.com/LeviticalTeam/downloads/videos/MicroNugget%20Building%20a%20Great%20IT%20Resume%20(HD).m4v"];
	
	_moviePlayer =  [[MPMoviePlayerController alloc] initWithContentURL:url];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(moviePlayBackDidFinish:)
												 name:MPMoviePlayerPlaybackDidFinishNotification
											   object:_moviePlayer];
	
	_moviePlayer.controlStyle = MPMovieControlStyleDefault;
	_moviePlayer.shouldAutoplay = YES;
	[self.view addSubview:_moviePlayer.view];
	[_moviePlayer setFullscreen:YES animated:YES];
	[_moviePlayer prepareToPlay];
	[_moviePlayer play];
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification {
	MPMoviePlayerController *player = [notification object];
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:MPMoviePlayerPlaybackDidFinishNotification
	 object:player];
	
	if ([player
		 respondsToSelector:@selector(setFullscreen:animated:)])
	{
		[player.view removeFromSuperview];
	}
}

@end

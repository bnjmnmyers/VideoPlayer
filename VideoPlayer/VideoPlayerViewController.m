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

- (IBAction)downloadToDevice:(id)sender {
	_downloadAlert = [[UIAlertView alloc] initWithTitle:@"Video Download" message:@"Would you like to proceed with downloading this video to your device?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];
	[_downloadAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			NSLog(@"Downloading Started");
			NSString *urlToDownload = @"http://www.benjaminmyers.com/LeviticalTeam/downloads/videos/MicroNugget%20Building%20a%20Great%20IT%20Resume%20(HD).m4v";
			NSURL *url = [NSURL URLWithString:urlToDownload];
			NSData *urlData = [NSData dataWithContentsOfURL:url];
			if ( urlData )
			{
				NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
				NSString *documentsDirectory = [paths objectAtIndex:0];
							
				NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"resume.m4v"];
							
				//saving is done on main thread
				dispatch_async(dispatch_get_main_queue(), ^{
					[urlData writeToFile:filePath atomically:YES];
					NSLog(@"File Saved !");
				});
			}
		});
	}
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

//
//  VideoPlayerViewController.h
//  VideoPlayer
//
//  Created by Benjamin Myers on 10/3/14.
//  Copyright (c) 2014 AppGuys.biz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoPlayerViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@property (strong, nonatomic) UIAlertView *downloadAlert;

- (IBAction)playMovie:(id)sender;
- (IBAction)downloadToDevice:(id)sender;
@end

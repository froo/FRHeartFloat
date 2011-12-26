//
//  RightnowViewController.h
//  LikeMe
//
//  Created by Peetry Zhang on 11-12-12.
//  Copyright (c) 2011年 iyaya Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "HeartView.h"

@interface RightnowViewController : UIViewController<AVAudioPlayerDelegate>
{
    HeartView *heart;
    AVAudioPlayer *bgPlayer;
    
    BOOL isShowing;
    BOOL isPresenting;
    
    NSTimer *animateTimer;
    NSTimer *removeTimer;
    NSTimer *bgTimer;
}

@end

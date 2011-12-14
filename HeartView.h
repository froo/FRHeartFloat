//
//  HeartView.h
//  LikeMe
//
//  Created by Peetry Zhang on 11-12-13.
//  Copyright (c) 2011年 iyaya Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface HeartView : UIImageView
{
    NSInteger aniIndex;
    NSInteger colorIndex;
    NSInteger actionIndex;
}

@property (nonatomic, assign) NSInteger aniIndex;
@property (nonatomic, assign) NSInteger colorIndex;
@property (nonatomic, assign) NSInteger actionIndex;

@end

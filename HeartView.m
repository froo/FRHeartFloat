//
//  HeartView.m
//  LikeMe
//
//  Created by Peetry Zhang on 11-12-13.
//  Copyright (c) 2011年 iyaya Inc. All rights reserved.
//

#import "HeartView.h"

@implementation HeartView

@synthesize aniIndex;
@synthesize colorIndex;
@synthesize actionIndex;

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.aniIndex = 0;
        self.colorIndex = arc4random()%4;
        self.actionIndex = arc4random()%3;
    }
    return self;
}

@end

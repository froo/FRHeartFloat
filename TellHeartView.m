//
//  TellHeartView.m
//  LikeMe
//
//  Created by Peetry Zhang on 11-12-19.
//  Copyright (c) 2011年 iyaya Inc. All rights reserved.
//

#import "TellHeartView.h"

@implementation TellHeartView

-(void)dealloc
{
    [super dealloc];
}

-(void)tolove
{
    tellText.text = @"I love you~";
    tellText.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:36];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cris_bg.png"]];
        
        UIImage *tellImg = [UIImage imageNamed:@"tellheart.png"];
        tellHeart = [[UIImageView alloc]initWithFrame:CGRectMake((320-tellImg.size.width)/2,
                                                                              (480-tellImg.size.height)/2,
                                                                              tellImg.size.width,
                                                                              tellImg.size.height)];
        tellHeart.image = tellImg;
        [self addSubview:tellHeart];
        
        tellText = [[UITextView alloc]initWithFrame:CGRectMake((tellHeart.frame.size.width-300)/2,
                                                                           (tellHeart.frame.size.height-150)/2+20,
                                                                           300,
                                                                           150)];
        [tellHeart addSubview:tellText];
        tellText.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:24];
        tellText.textAlignment = UITextAlignmentCenter;
        tellText.textColor = [UIColor whiteColor];
        tellText.text = @"Merry Christmas\n && Happy Every Day~";
        tellText.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tolove)];
        [self addGestureRecognizer:tap];
        [tap release];
    }
    return self;
}

@end

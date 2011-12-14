//
//  RightnowViewController.m
//  LikeMe
//
//  Created by Peetry Zhang on 11-12-12.
//  Copyright (c) 2011年 iyaya Inc. All rights reserved.
//

#import "RightnowViewController.h"
#import "HistoryViewController.h"

@implementation RightnowViewController

-(void)dealloc
{
    [super dealloc];
}

-(id)init
{
    if (self == [super init]) {
        self.title = @"Christmas~";
    }
    return self;
}

-(void)showHistory
{
    HistoryViewController *historyView = [[HistoryViewController alloc]init];
    [self.navigationController pushViewController:historyView animated:YES];
}

//Get heart image, launchpoint, heart counts
-(UIImage*)getHeartImg
{
    switch (heart.colorIndex) {
        case 1:
            return [UIImage imageNamed:@"heart_1.png"];
            break;
        case 2:
            return [UIImage imageNamed:@"heart_2.png"];
            break;
        case 3:
            return [UIImage imageNamed:@"heart_3.png"];
            break;
        case 4:
            return [UIImage imageNamed:@"heart_4.png"];
            break;
            
        default:
            break;
    }
    return nil;
}

-(CGPoint)getRandomPoint
{
    NSNumber *widthed = [NSNumber numberWithFloat:heartImg.size.width];
    NSNumber *heighted = [NSNumber numberWithFloat:heartImg.size.height];
    return  CGPointMake(heartImg.size.width/2+arc4random()%(320-widthed.intValue),
                        heartImg.size.height/2+arc4random()%(480-heighted.intValue));
}

-(NSInteger)getCount
{
    NSNumber *widthed = [NSNumber numberWithFloat:heartImg.size.width];
    NSNumber *heighted = [NSNumber numberWithFloat:heartImg.size.height];
    return 320*480/(widthed.intValue*heighted.intValue)/3*2;
}

//NSTimer functions to generate, animate or remove hearts
-(void)generateHearts:(CGPoint)thePoint
{
    heart = [[HeartView alloc]initWithFrame:CGRectMake(0, 0, heartImg.size.width, heartImg.size.height)];
    heart.center = thePoint;
    heart.image = [self getHeartImg];
    [self.view addSubview:heart];
    heart.alpha = 0;
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         heart.alpha = 1;
                     } 
                     completion:^(BOOL finished) {
                         if (heart.actionIndex == 1) {
                             [UIView animateWithDuration:1
                                                   delay:0
                                                 options:UIViewAnimationOptionAutoreverse
                                              animations:^{
                                                  heart.alpha = 0.5;
                                              } 
                                              completion:^(BOOL finished) {
                                                  
                                              }];
                         }
                     }];
    
    [heart release];
}

-(void)animateHeart:(NSTimer *)timer
{
    for (HeartView *hearts in self.view.subviews) {
        if (hearts.actionIndex != 1) {
            hearts.aniIndex++;
            if (hearts.aniIndex%2==0) {
                [UIView animateWithDuration:3
                                 animations:^{
                                     CGPoint getPoint = hearts.center;
                                     getPoint = CGPointMake(getPoint.x+arc4random()%30,getPoint.y+arc4random()%30);
                                     hearts.center = getPoint;
                                 }];
            }
            else{
                [UIView animateWithDuration:3
                                 animations:^{
                                     CGPoint getPoint = hearts.center;
                                     getPoint = CGPointMake(getPoint.x-arc4random()%30,getPoint.y-arc4random()%30);
                                     hearts.center = getPoint;
                                 }];
            }
        }
        
        if (hearts.frame.origin.x<0
            ||hearts.frame.origin.x+hearts.frame.size.width>320
            ||hearts.frame.origin.y<0
            ||hearts.frame.origin.y+hearts.frame.size.height>480) {
            hearts.center = [self getRandomPoint];
        }
    }
}

-(void)removeHearts
{
    HeartView *removeHeart = [self.view.subviews objectAtIndex:arc4random()%[self getCount]];
    [UIView animateWithDuration:2
                     animations:^{
                         removeHeart.frame = CGRectMake(removeHeart.frame.origin.x,
                                                        removeHeart.frame.origin.y,
                                                        removeHeart.frame.size.width*2,
                                                        removeHeart.frame.size.height*2);
                         removeHeart.alpha = 0;
                     } 
                     completion:^(BOOL finished) {
                         [removeHeart removeFromSuperview];
                         [self generateHearts:[self getRandomPoint]];
                     }];
}

#pragma mark -

-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cris_bg.png"]];

    UIBarButtonItem *historyBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showHistory)];
    self.navigationItem.rightBarButtonItem = historyBtn;
    [historyBtn release];
    
    heartImg = [UIImage imageNamed:@"icon_heart.png"];
    isShowing = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!isShowing) {
        [UIView animateWithDuration:1
                         animations:^{
                             [self.navigationController.navigationBar setHidden:YES];
                         }];
        
        for (int i=0; i<[self getCount]; i++) {
            [self generateHearts:[self getRandomPoint]];
        }
        
        NSTimer *animateTimer;
        animateTimer = [NSTimer scheduledTimerWithTimeInterval:3
                                                        target:self 
                                                      selector:@selector(animateHeart:) 
                                                      userInfo:nil 
                                                       repeats:YES];
        
        NSTimer *removeTimer;
        removeTimer = [NSTimer scheduledTimerWithTimeInterval:5
                                                       target:self 
                                                     selector:@selector(removeHearts) 
                                                     userInfo:nil
                                                      repeats:YES];
    }
    
    isShowing = YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touch = [[touches anyObject] locationInView:self.view];
    [self generateHearts:touch];
}

@end

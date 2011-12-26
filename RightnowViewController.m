//
//  RightnowViewController.m
//  LikeMe
//
//  Created by Peetry Zhang on 11-12-12.
//  Copyright (c) 2011年 iyaya Inc. All rights reserved.
//

#import "RightnowViewController.h"
#import "HistoryViewController.h"
#import "TellHeartView.h"

@implementation RightnowViewController

-(void)dealloc
{
    [bgPlayer release];
    [super dealloc];
}

-(id)init
{
    if (self == [super init]) {
        self.title = @"Christmas~";
    }
    return self;
}

-(void)didReceiveMemoryWarning
{
    
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
    return [UIImage imageNamed:@"heart_4.png"];
}

-(NSInteger)getCount
{
    //return 320*480/([self getHeartImg].size.width*[self getHeartImg].size.height)/2;
    return 24;
}

//-(CGPoint)getRandomPoint
//{
//    NSNumber *widthed = [NSNumber numberWithFloat:[self getHeartImg].size.width];
//    NSNumber *heighted = [NSNumber numberWithFloat:[self getHeartImg].size.height];
//    
//    return CGPointMake([self getHeartImg].size.width/2+arc4random()%(320-widthed.intValue),
//                       [self getHeartImg].size.height/2+arc4random()%(320-heighted.intValue));
//}

-(CGPoint)getRandomPoint:(NSInteger)index
{
    NSInteger theX = index%4*80;
    NSInteger theY = index/4*80;
    return CGPointMake(theX+arc4random()%80, theY+arc4random()%80);
}

//NSTimer functions to generate, animate or remove hearts
-(void)generateHearts:(CGPoint)thePoint
{
    UIImage *hImg = [self getHeartImg];
    heart = [[HeartView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:heart];
    heart.image = hImg;
    heart.alpha = 0;
    heart.center = thePoint;
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         heart.frame = CGRectMake(0, 0, hImg.size.width, hImg.size.height);
                         heart.center = thePoint;
                         heart.alpha = 1;
                     } 
                     completion:^(BOOL finished) {
                         
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
        if (hearts.actionIndex == 1) {
            [UIView animateWithDuration:1.5
                                  delay:0 
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 hearts.alpha = 0.3;
                             } 
                             completion:^(BOOL finished) {
                                 [UIView animateWithDuration:1.5
                                                  animations:^{
                                                      hearts.alpha = 1;
                                                  } 
                                                  completion:^(BOOL finished) {
                                                      
                                                  }];
                             }];
        }
        
        if (hearts.frame.origin.x<0
            ||hearts.frame.origin.x+hearts.frame.size.width>320
            ||hearts.frame.origin.y<0
            ||hearts.frame.origin.y+hearts.frame.size.height>480) {
            [UIView animateWithDuration:1.5
                             animations:^{
                                 hearts.center = [self getRandomPoint:arc4random()%[self getCount]];
                             }];
        }
    }
}

-(void)removeHearts
{
    HeartView *removeHeart = [self.view.subviews objectAtIndex:arc4random()%[self getCount]];
    [UIView animateWithDuration:5
                     animations:^{
                         removeHeart.frame = CGRectMake(removeHeart.frame.origin.x,
                                                        removeHeart.frame.origin.y,
                                                        removeHeart.frame.size.width*2,
                                                        removeHeart.frame.size.height*2);
                         removeHeart.alpha = 0;
                     } 
                     completion:^(BOOL finished) {
                         [removeHeart removeFromSuperview];
                         [self generateHearts:[self getRandomPoint:arc4random()%[self getCount]]];
                     }];
}

//shake the background
-(void)bgShaker
{
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGFloat bgY = self.view.center.y;
                         self.view.center = CGPointMake(self.view.center.x, bgY+10);
                     } 
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:2
                                               delay:0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                              CGFloat bgX = self.view.center.x;
                                              self.view.center = CGPointMake(bgX+10,self.view.center.y);
                                          } 
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:2
                                                                    delay:0
                                                                  options:UIViewAnimationOptionAllowUserInteraction
                                                               animations:^{
                                                                   CGFloat bgY = self.view.center.y;
                                                                   self.view.center = CGPointMake(self.view.center.x,bgY-10);
                                                               } 
                                                               completion:^(BOOL finished) {
                                                                   [UIView animateWithDuration:2
                                                                                         delay:0
                                                                                       options:UIViewAnimationOptionAllowUserInteraction
                                                                                    animations:^{
                                                                                        CGFloat bgX = self.view.center.x;
                                                                                        self.view.center = CGPointMake(bgX-10,self.view.center.y);
                                                                                    } 
                                                                                    completion:^(BOOL finished) {
                                                                                        
                                                                                         }];
                                                               }];
                                          }];
                     }];
}

-(void)presentTellHeart
{
    if (!isPresenting) {
        if ([bgPlayer isPlaying]) {
            [bgPlayer stop];
        }
        [animateTimer invalidate];
        [removeTimer invalidate];
        for (HeartView *theHearts in self.view.subviews) {
            [UIView animateWithDuration:1
                             animations:^{
                                 theHearts.alpha = 0;
                                 self.navigationController.navigationBar.alpha = 1;
                             } 
                             completion:^(BOOL finished) {
                                 [theHearts removeFromSuperview];
                                 
                                 TellHeartView *tellView = [[TellHeartView alloc]initWithFrame:[UIScreen mainScreen].bounds];
                                 [UIView transitionFromView:self.view
                                                     toView:tellView
                                                   duration:1
                                                    options:UIViewAnimationOptionTransitionCrossDissolve
                                                 completion:^(BOOL finished) {
                                                
                                                 }];
                             }];
        }
        
    }
    
    isPresenting = YES;
}

#pragma mark -

-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cris_bg.png"]];
    self.navigationController.navigationBar.alpha = 0;

//    UIBarButtonItem *historyBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showHistory)];
//    self.navigationItem.rightBarButtonItem = historyBtn;
//    [historyBtn release];
    
    isShowing = NO;
    
    bgTimer = [NSTimer scheduledTimerWithTimeInterval:8
                                               target:self 
                                             selector:@selector(bgShaker)
                                             userInfo:nil
                                              repeats:YES];
    
    isPresenting = NO;
//    [self performSelector:@selector(presentTellHeart) withObject:nil afterDelay:20];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!isShowing) {
        for (int i=0; i<[self getCount]; i++) {
            [self generateHearts:[self getRandomPoint:i]];
        }
        
        animateTimer = [NSTimer scheduledTimerWithTimeInterval:3
                                                        target:self 
                                                      selector:@selector(animateHeart:) 
                                                      userInfo:nil 
                                                       repeats:YES];
        
        removeTimer = [NSTimer scheduledTimerWithTimeInterval:5
                                                       target:self 
                                                     selector:@selector(removeHearts) 
                                                     userInfo:nil
                                                      repeats:YES];
        
        NSString *bgSound = [[NSBundle mainBundle] pathForResource:@"bg_chris" ofType:@"m4a"];
        NSError *error;
        bgPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:bgSound] error:&error];
        bgPlayer.delegate = self;
        bgPlayer.numberOfLoops = 2;
        [bgPlayer play];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(presentTellHeart)];
        [self.view addGestureRecognizer:pinch];
        [pinch release];
    }
    
    isShowing = YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touch = [[touches anyObject] locationInView:self.view];
    [self generateHearts:touch];
}

#pragma mark - avaudioplayer

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag == YES) {
        [self presentTellHeart];
    }
    else{
        NSLog(@"fail to play");
    }
}

@end

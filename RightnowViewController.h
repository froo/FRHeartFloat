//
//  RightnowViewController.h
//  LikeMe
//
//  Created by Peetry Zhang on 11-12-12.
//  Copyright (c) 2011年 iyaya Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeartView.h"

@interface RightnowViewController : UIViewController
{
    HeartView *heart;
    UIImage *heartImg;
    
    BOOL isShowing;
}

@end

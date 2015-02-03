//
//  TimeViewController.h
//  HanasakaJiisan
//
//  Created by 前本英里香 on 2014/11/22.
//  Copyright (c) 2014年 Erika Maemoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TimeViewController : UIViewController
{
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *hanteiLabel;
    IBOutlet UIImageView *hai;
    
    UIImageView *imageView1;
    UIImageView *imageView2;
    UIImageView *imageView3;
    UIImageView *imageViewStart;    

    NSTimer *timer;
    float time;
    int countdown;
    
    UIButton *startBt;
    
    IBOutlet UIImageView *sakuraJudgeImageView;
    
    IBOutlet UIImageView *currentImageView1;
    IBOutlet UIImageView *currentImageView2;
    IBOutlet UIImageView *currentImageView3;
    
    IBOutlet UIImageView *nextImageView1;
    IBOutlet UIImageView *nextImageView2;
    IBOutlet UIImageView *nextImageView3;
    
    NSArray *currentArray;
    NSArray *nextArray;
    
    int tokuten;
}



@end

//
//  TimeViewController.h
//  HanasakaJiisan
//
//  Created by 前本英里香 on 2014/11/22.
//  Copyright (c) 2014年 Erika Maemoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeViewController : UIViewController
{
    IBOutlet UILabel *timeLabel;
    UILabel *countdownLabel;
    

    NSTimer *timer;
    float time;
    int countdown;
    
    UIButton *startBt;
}


//-(void)start;
//-(void)countDownStart;
//-(void)gameTimerStart;
//-(void)down;


@end

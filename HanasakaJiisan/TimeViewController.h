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
    IBOutlet UILabel *timeLabel ;
    UILabel *countdown_label ;
    

    NSTimer *timer ;
    float time ;
    float countd ;
    int countdown ;
    
    UIButton *startBt ;
    
    
    int s ;
    
    IBOutlet UILabel *label ;
}
-(IBAction)start ;

-(void)up ;

@end

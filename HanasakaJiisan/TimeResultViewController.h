//
//  ResultViewController.h
//  HanasakaJiisan
//
//  Created by 前本英里香 on 2014/11/22.
//  Copyright (c) 2014年 Erika Maemoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TimeResultViewController : UIViewController
{
    NSUserDefaults *userDefaults;
    
    
    int tokuten;
    
    IBOutlet UILabel *scoreLabel;
    
    IBOutlet UILabel *rank1Label;
    IBOutlet UILabel *rank2Label;
    IBOutlet UILabel *rank3Label;
    IBOutlet UILabel *rank4Label;
    IBOutlet UILabel *rank5Label;
    
    NSArray *labels;
    
//    NSInteger rank1;
//    NSInteger rank2;
//    NSInteger rank3;
//    NSInteger rank4;
//    NSInteger rank5;

    NSMutableArray *ranking;
}

@end

//
//  EndlessResultViewController.h
//  HanasakaJiisan
//
//  Created by 前本英里香 on 2015/01/15.
//  Copyright (c) 2015年 Erika Maemoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface EndlessResultViewController : UIViewController
{
    NSUserDefaults *userDefaults;
    
    IBOutlet UILabel *rank1Label;
    IBOutlet UILabel *rank2Label;
    IBOutlet UILabel *rank3Label;
    IBOutlet UILabel *rank4Label;
    IBOutlet UILabel *rank5Label;
    
    
    int tokuten;
    
    NSArray *labels;
    NSMutableArray *ranking;

}

@end

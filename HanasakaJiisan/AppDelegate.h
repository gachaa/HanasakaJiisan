//
//  AppDelegate.h
//  HanasakaJiisan
//
//  Created by 前本英里香 on 2014/11/20.
//  Copyright (c) 2014年 Erika Maemoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    int timeScore;
    int endlessScore;
}

@property (strong, nonatomic) UIWindow *window;
@property int timeScore;
@property int endlessScore;



@end


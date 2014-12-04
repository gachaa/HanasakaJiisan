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
    
    IBOutlet UIImageView *currentImageView1;
    IBOutlet UIImageView *currentImageView2;
    IBOutlet UIImageView *currentImageView3;
    
    IBOutlet UIImageView *nextImageView1;
    IBOutlet UIImageView *nextImageView2;
    IBOutlet UIImageView *nextImageView3;
    
    NSArray *currentArray;
    NSArray *nextArray;
}

//ここに、IBActionもvoidも宣言しなくていい
//-(void)start;
//-(void)countDownStart;
//-(void)gameTimerStart;
//-(void)down;

// 配列が与えられたら、imageviewに画像をセットする
- (void)showTrees:(NSArray *)current and:(NSArray *)next;

// 0, 1がきたら、枯れてる・咲いてる画像を返す
- (UIImage *)treeImageWithNumber:(int)number;


@end

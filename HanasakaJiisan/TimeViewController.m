//
//  TimeViewController.m
//  HanasakaJiisan
//
//  Created by 前本英里香 on 2014/11/22.
//  Copyright (c) 2014年 Erika Maemoto. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController ()

@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //MARK:StartButtonを作ってるよ
    startBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startBt.center = CGPointMake(100,200);
    [startBt setTitle:@"start"
             forState:UIControlStateNormal];
    [startBt sizeToFit];
    [startBt addTarget:self
                action:@selector(start)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBt];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.timeScore = 0;
    
    timeLabel.text = @"" ;
    
    startBt.hidden = NO;
    timeupLabel.text = @"";
    timer = nil;
    sakuraJudgeImageView.image = nil;
    
    //countDownLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:180];
    
    [self resetViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// timerの設定とtimerを始動する
- (void)start{
    countdown = 4;
    
    //タイマー1(3...2...1...のカウント)
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownFirst) userInfo:nil repeats:YES];
    [timer fire];
    startBt.hidden = YES;
}

// startに呼ばれる。カウントダウンが終了したら、timerを止めてgameTimerStartを呼ぶ
- (void)countDownFirst
{
    countdown = countdown - 1;
    if(countdown == 3){CGRect rect = CGRectMake(37, 300, 300, 95);
        imageView3 = [[UIImageView alloc]initWithFrame:rect];
        imageView3.image = [UIImage imageNamed:@"3.png"];
        [self.view addSubview:imageView3];
    }else if(countdown == 2){
        CGRect rect = CGRectMake(37, 300, 300, 95);
        imageView2 = [[UIImageView alloc]initWithFrame:rect];
        imageView2.image = [UIImage imageNamed:@"2.png"];
        [self.view addSubview:imageView2];
        [imageView3 removeFromSuperview];
    }else if(countdown == 1){
        CGRect rect = CGRectMake(37, 300, 300, 95);
        imageView1 = [[UIImageView alloc]initWithFrame:rect];
        imageView1.image = [UIImage imageNamed:@"1.png"];
        [self.view addSubview:imageView1];
        [imageView2 removeFromSuperview];
    }else if (countdown == 0 ) {
        CGRect rect = CGRectMake(37, 300, 300, 95);
        imageViewStart = [[UIImageView alloc]initWithFrame:rect];
        imageViewStart.image = [UIImage imageNamed:@"start.png"];
        [self.view addSubview:imageViewStart];
        [imageView1 removeFromSuperview];
    }else if (countdown == -1) {
        [imageViewStart removeFromSuperview];
        [timer invalidate];
        timer = nil;
        [self gameTimerStart];
        [self gameStart];
    }
}



- (void)gameTimerStart
{
    //MARK:Timer
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                             target:self
                                           selector:@selector(down)
                                           userInfo:nil
                                            repeats:YES
             ];
    time = 10 ;
    [timer fire];
}

// 10秒数える。タイムアップしたらmodalRVCを呼ぶ
- (void)down{
    time = time - 0.01;
    timeLabel.text = [NSString stringWithFormat:@"%.2f",time];
    if(time <= 0){
        timeLabel.text = @"0.00";
        [timer invalidate];
        [self performSelector:@selector(modalTRVC)
                   withObject:nil
                   afterDelay:1.5];
        timeupLabel = [[UILabel alloc] initWithFrame:(CGRectMake(50, 50, 200, 100))];
        timeupLabel.text = @"タイムアップ！";
    }
}

- (void)modalTRVC
{
    [self performSegueWithIdentifier:@"modalTRVC" sender:self];
}

- (void)gameStart
{
    currentArray = [self makeTrees];
    nextArray = [self makeTrees];
    // NSArray *trees = @[[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3]];
    [self showTrees];
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [hai addGestureRecognizer:panGesture];

}

// 1,0,1とか1,1,0とかの配列を作る
- (NSMutableArray *)makeTrees
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@1, @1, @1]];
    int position = arc4random_uniform(3); // 0~2
    array[position] = @0;
    return array; // [0, 1 ,1]
}

// currentImageViewにtreeImageWithNumberでセットされた画像を入れる
- (void)showTrees
{
    currentImageView1.image = [self treeImageWithNumber:[currentArray[0] intValue]];
    currentImageView2.image = [self treeImageWithNumber:[currentArray[1] intValue]];
    currentImageView3.image = [self treeImageWithNumber:[currentArray[2] intValue]];
    
    nextImageView1.image = [self treeImageWithNumber:[nextArray[0] intValue]];
    nextImageView2.image = [self treeImageWithNumber:[nextArray[1] intValue]];
    nextImageView3.image = [self treeImageWithNumber:[nextArray[2] intValue]];
}

//　treeImgeWithNumberにnumberの値によって画像を入れる
- (UIImage *)treeImageWithNumber:(int)number
{
    if (number == 0) {
        return [UIImage imageNamed:@"off"]; //枯れてる画像
    } else {
        return [UIImage imageNamed:@"on"]; //咲いてる画像
    }
}



//動きの認識
- (void)handlePanGesture:(UIPanGestureRecognizer*) sender {
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer*) sender;
    CGPoint translation = [pan translationInView:hai];
    CGFloat x = translation.x;
    CGFloat y = translation.y;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (y < 0) {
            if (-25 <= x && x <= 25) {
                NSLog(@"center");
                [self judge:1];
            }else if (-25 > x) {
                NSLog(@"left");
                [self judge:0];
            }else if (25 < x) {
                NSLog(@"right");
                [self judge:2];
            }else {
                NSLog(@"undefined");
            }
        }
    }
}

- (void)judge:(int)direction
{
    if(time >= 0){
//        currentArray[direction] = @(1 - [currentArray[direction] intValue]); // 反転
        
        if([currentArray[direction] intValue] == 0){
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.timeScore += 1;
            NSLog(@"%d",appDelegate.timeScore);
            sakuraJudgeImageView.image = [UIImage imageNamed:@"saita.png"];
            [self susumu];
        }else{
            sakuraJudgeImageView.image = [UIImage imageNamed:@"saitenai.png"];
//            NSMutableArray *currentArray2 = (NSMutableArray *)currentArray;
//            [currentArray2 replaceObjectAtIndex:direction withObject:@"0"];
//            currentArray = (NSArray *)currentArray2;
//            currentImageView[direction] =
        }
    }
}

// currentArrayにnextArrayを入れて、nextArrayを新しく作って、showTreesを呼ぶ
- (void)susumu
{
    currentArray = nextArray;
    nextArray = [self makeTrees];
    [self showTrees];
}

- (void)resetViews
{
    currentImageView1.image = nil;
    currentImageView2.image = nil;
    currentImageView3.image = nil;
    nextImageView1.image = nil;
    nextImageView2.image = nil;
    nextImageView3.image = nil;
    
}



@end

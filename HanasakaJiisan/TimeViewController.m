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
    
    timeLabel.text = @"" ;
    
    
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

    
    currentArray = [self makeTrees];
    nextArray = [self makeTrees];
    // NSArray *trees = @[[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3]];
    [self showTrees:currentArray and:nextArray];
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
-(void)start{
    countdown = 4;
    countdownLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 10, 100, 100))];
    countdownLabel.text = [NSString stringWithFormat:@"%D", countdown];
    [self.view addSubview:countdownLabel];
    
    //タイマー1(3...2...1...のカウント)
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownFirst) userInfo:nil repeats:YES];
    [timer fire];
    startBt.hidden = YES;
}

// startに呼ばれる。カウントダウンが終了したら、timerを止めてgameTimerStartを呼ぶ
- (void)countDownFirst
{
    countdown = countdown - 1;
    countdownLabel.text = [NSString stringWithFormat:@"%d", countdown];
    
    if (countdown <= 0 ) {
        countdownLabel.text = @"スタート！！";
        if (countdown <= -1) {
            countdownLabel.hidden = YES;
            [timer invalidate];
            timer = nil;
            [self gameTimerStart];
        }
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
-(void)down{
    time = time - 0.01;
    timeLabel.text = [NSString stringWithFormat:@"%.2f",time];
    if(time <= 0){
        timeLabel.text = @"0.00";
        [timer invalidate];
        [self performSelector:@selector(modalRVC)
                   withObject:nil
                   afterDelay:1.5];
        UILabel *timeupLabel = [[UILabel alloc] initWithFrame:(CGRectMake(50, 50, 200, 100))];
        timeupLabel.text = @"タイムアップ！";
        [self.view addSubview:timeupLabel];
        
    }
}

-(void)modalRVC
{
    [self performSegueWithIdentifier:@"modalRVC" sender:self];
}


// currentImageViewにtreeImageWithNumberでセットされた画像を入れる
- (void)showTrees:(NSArray *)current and:(NSArray *)next
{
    currentImageView1.image = [self treeImageWithNumber:[current[0] intValue]];
    currentImageView2.image = [self treeImageWithNumber:[current[1] intValue]];
    currentImageView3.image = [self treeImageWithNumber:[current[2] intValue]];
    
    nextImageView1.image = [self treeImageWithNumber:[next[0] intValue]];
    nextImageView2.image = [self treeImageWithNumber:[next[1] intValue]];
    nextImageView3.image = [self treeImageWithNumber:[next[2] intValue]];
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

// currentArrayにnextArrayを入れて、nextArrayを新しく作って、shouTreesを呼ぶ
- (void)susumu
{
    currentArray = nextArray;
    nextArray = [self makeTrees];
    [self showTrees:currentArray and:nextArray];
}

- (IBAction)susunde
{
    [self susumu];
}

// 1,0,1とか1,1,0とかの配列を作る
- (NSArray *)makeTrees
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@1, @1, @1]];

    int position = arc4random_uniform(3); // 0~2
    
    array[position] = @0;
    
    return array; // [0, 1 ,1]
}





@end

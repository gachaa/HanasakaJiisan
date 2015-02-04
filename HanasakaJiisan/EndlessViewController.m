//
//  EndlessViewController.m
//  HanasakaJiisan
//
//  Created by 前本英里香 on 2014/11/22.
//  Copyright (c) 2014年 Erika Maemoto. All rights reserved.
//

#import "EndlessViewController.h"

@interface EndlessViewController ()

@end

@implementation EndlessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    startBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startBt.center = CGPointMake(100,200);
    [startBt setTitle:@"start"
             forState:UIControlStateNormal];
    [startBt sizeToFit];
    [startBt addTarget:self
                action:@selector(start)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBt];
    
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [hai addGestureRecognizer:panGesture];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.endlessScore = 0;
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

- (void)start{
    countdown = 4;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownFirst) userInfo:nil repeats:YES];
    [timer fire];
    startBt.hidden = YES;
}

// startに呼ばれる。カウントダウンが終了したら、timerを止めてgameTimerStartを呼ぶ
- (void)countDownFirst
{
    countdown = countdown - 1;
    if(countdown == 3){
        CGRect rect = CGRectMake(10, 50, 250, 250);
        imageView3 = [[UIImageView alloc]initWithFrame:rect];
        imageView3.image = [UIImage imageNamed:@"3.png"];
        [self.view addSubview:imageView3];
    }else if(countdown == 2){
        CGRect rect = CGRectMake(10, 50, 250, 250);
        imageView2 = [[UIImageView alloc]initWithFrame:rect];
        imageView2.image = [UIImage imageNamed:@"2.png"];
        [self.view addSubview:imageView2];
        [imageView3 removeFromSuperview];
    }else if(countdown == 1){
        CGRect rect = CGRectMake(10, 50, 250, 250);
        imageView1 = [[UIImageView alloc]initWithFrame:rect];
        imageView1.image = [UIImage imageNamed:@"1.png"];
        [self.view addSubview:imageView1];
        [imageView2 removeFromSuperview];
    }else if (countdown == 0 ) {
        [imageView1 removeFromSuperview];
        CGRect rect = CGRectMake(10, 50, 250, 250);
        imageViewStart = [[UIImageView alloc]initWithFrame:rect];
        imageViewStart.image = [UIImage imageNamed:@"start_sign.png"];
        [self.view addSubview:imageViewStart];
    }else if (countdown == -1) {
        [imageViewStart removeFromSuperview];
        [timer invalidate];
        timer = nil;
        [self gameStart];
    }
}

- (void)gameStart
{
    [imageViewStart removeFromSuperview];
    currentArray = [self makeTrees];
    nextArray = [self makeTrees];
    [self showTrees:currentArray and:nextArray];
    
}

// 1,0,1とか1,1,0とかの配列を作る
- (NSArray *)makeTrees
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@1, @1, @1]];
    int position = arc4random_uniform(3); // 0~2
    array[position] = @0;
    return array; // [0, 1 ,1]
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



- (void)handlePanGesture:(UIPanGestureRecognizer*) sender {
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer*) sender;
    // CGPoint location = [pan locationInView:hai];
    CGPoint translation = [pan translationInView:hai];
    // NSLog(@"pan location :  x=%f, y=%f", location.x, location.y);
    //NSLog(@"pan translation : x=%f, y=%f", translation.x, translation.y);
    //NSLog(@"pan translation : x=%f, y=%f", translation.x, translation.y);
    CGFloat x = translation.x;
    CGFloat y = translation.y;
    
    // NSLog(@"state : %@", @(pan.state));
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (y < 0) {
            if (-15 < x && x < 15) {
                NSLog(@"center");
                // [self center];
                [self judge:1];
            }else if (-15 > x) {
                NSLog(@"left");
                // [self left];
                [self judge:0];
            }else if (15 < x) {
                NSLog(@"right");
                // [self right];
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
        if([currentArray[direction] intValue] == 0){
            hanteiLabel.text = @"せいこう";
            sakuraJudgeImageView.image = [UIImage imageNamed:@"saita.png"];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.endlessScore += 1;
            NSLog(@"%d",appDelegate.endlessScore);
            [self susumu];
        }else{
            hanteiLabel.text = @"しっぱい";
            sakuraJudgeImageView.image = [UIImage imageNamed:@"saitenai.png"];
            [self performSelector:@selector(modalERVC)
                       withObject:nil
                       afterDelay:1.5];
        }
    }
}


// currentArrayにnextArrayを入れて、nextArrayを新しく作って、showTreesを呼ぶ
- (void)susumu
{
    currentArray = nextArray;
    nextArray = [self makeTrees];
    [self showTrees:currentArray and:nextArray];
}

- (void)modalERVC
{
    [self performSegueWithIdentifier:@"modalERVC" sender:self];
}



@end

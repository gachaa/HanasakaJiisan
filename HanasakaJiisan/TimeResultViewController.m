//
//  ResultViewController.m
//  HanasakaJiisan
//
//  Created by 前本英里香 on 2014/11/22.
//  Copyright (c) 2014年 Erika Maemoto. All rights reserved.
//

#import "TimeResultViewController.h"

@interface TimeResultViewController ()

@end

@implementation TimeResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
//    rank1 = [userDefaults integerForKey:@"rank1"];
//    rank2 = [userDefaults integerForKey:@"rank2"];
//    rank3 = [userDefaults integerForKey:@"rank3"];
//    rank4 = [userDefaults integerForKey:@"rank4"];
//    rank5 = [userDefaults integerForKey:@"rank5"];
    
    // ラベルを配列にまとめる
    labels = @[rank1Label, rank2Label, rank3Label, rank4Label, rank5Label];
    
    // いままでのランキングを取得
    ranking = (NSMutableArray *)[userDefaults arrayForKey:@"ranking"]; //userDefaultsに入ってる配列は、全部NSArrayになっちゃう
    
    // 最初は、0の配列を用意
    if (ranking == nil || ranking.count == 0) { // rankingの配列の中が空
        ranking = [[NSMutableArray alloc] initWithArray:@[@0, @0, @0, @0, @0]];
    }

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tokuten = appDelegate.timeScore;
    
    scoreLabel.text = [NSString stringWithFormat:@"%d",tokuten];
    
    // 得点を更新
    for (int i = 0; i < 5; i++) {
        int score = [ranking[i] intValue];
        if (tokuten > score) {
            [ranking insertObject:@(tokuten) atIndex:i]; //tokutenをNSNumberにして、挿入
            break; //for文を出る
        }
    }
    
    // NSLog(@"added : %@", ranking);
    
    // rankingの上から五個だけ保存
    NSMutableArray *newRanking = [[NSMutableArray alloc] init]; // 空の配列
    for (int i = 0; i < 5; i++) {
        [newRanking addObject:ranking[i]]; // 高い得点から付け加える
    }
    
    NSLog(@"new : %@", newRanking);
    
    // 保存
    [userDefaults setObject:newRanking forKey:@"ranking"];
    
    [self ranking];
    // [self rank1];
    
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


//-(void)rank1
//{
//    if(tokuten >= rank1){
//        [userDefaults setInteger:rank4 forKey:@"rank5"];
//        [userDefaults setInteger:rank3 forKey:@"rank4"];
//        [userDefaults setInteger:rank2 forKey:@"rank3"];
//        [userDefaults setInteger:rank1 forKey:@"rank2"];
//        [userDefaults setInteger:tokuten forKey:@"rank1"];
//        [self ranking];
//    }else{
//        [self rank2];
//    }
//}
//
//
//-(void)rank2
//{
//    if(tokuten >= rank2){
//        [userDefaults setInteger:rank4 forKey:@"rank5"];
//        [userDefaults setInteger:rank3 forKey:@"rank4"];
//        [userDefaults setInteger:rank2 forKey:@"rank3"];
//        [userDefaults setInteger:tokuten forKey:@"rank2"];
//        [self ranking];
//    }else{
//        [self rank3];
//    }
//}
//
//-(void)rank3
//{
//    if(tokuten >= rank3){
//        [userDefaults setInteger:rank4 forKey:@"rank5"];
//        [userDefaults setInteger:rank3 forKey:@"rank4"];
//        [userDefaults setInteger:tokuten forKey:@"rank3"];
//        [self ranking];
//    }else{
//        [self rank4];
//    }
//}
//
//-(void)rank4
//{
//    if(tokuten >= rank4){
//        [userDefaults setInteger:rank4 forKey:@"rank5"];
//        [userDefaults setInteger:tokuten forKey:@"rank4"];
//        [self ranking];
//    }else{
//        [self rank5];
//    }
//        
//}
//
//-(void)rank5
//{
//    if(tokuten >= rank5){
//        [userDefaults setInteger:tokuten forKey:@"rank5"];
//    }
//    [self ranking];
//}

- (void)ranking
{
//    rank1 = [userDefaults integerForKey:@"rank1"];
//    rank2 = [userDefaults integerForKey:@"rank2"];
//    rank3 = [userDefaults integerForKey:@"rank3"];
//    rank4 = [userDefaults integerForKey:@"rank4"];
//    rank5 = [userDefaults integerForKey:@"rank5"];
    
//    rank1Label.text = [NSString stringWithFormat:@"%d",rank1];
//    rank2Label.text = [NSString stringWithFormat:@"%d",rank2];
//    rank3Label.text = [NSString stringWithFormat:@"%d",rank3];
//    rank4Label.text = [NSString stringWithFormat:@"%d",rank4];
//    rank5Label.text = [NSString stringWithFormat:@"%d",rank5];
    
    // 更新されたランキングを取得
    NSArray *ranking_ = [userDefaults arrayForKey:@"ranking"];
    
    NSLog(@"get : %@", ranking_);
    // NSArray *ranking_ = @[@12, @11, @9, @8, @7];
    
    // ラベルに表示
    for (int i = 0; i < 5; i++) {
        int score = [ranking_[i] intValue];
        ((UILabel *)labels[i]).text = [NSString stringWithFormat:@"%d", score];
    }
}

-(IBAction)delete
{
//    [userDefaults removeObjectForKey:@"rank1"];
//    [userDefaults removeObjectForKey:@"rank2"];
//    [userDefaults removeObjectForKey:@"rank3"];
//    [userDefaults removeObjectForKey:@"rank4"];
//    [userDefaults removeObjectForKey:@"rank5"];
    [userDefaults removeObjectForKey:@"ranking"];
}





@end

//
//  EndlessResultViewController.m
//  HanasakaJiisan
//
//  Created by 前本英里香 on 2015/01/15.
//  Copyright (c) 2015年 Erika Maemoto. All rights reserved.
//

#import "EndlessResultViewController.h"

@interface EndlessResultViewController ()

@end

@implementation EndlessResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    userDefaults = [NSUserDefaults standardUserDefaults];

    // ラベルを配列にまとめる
    labels = @[rank1Label, rank2Label, rank3Label, rank4Label, rank5Label];
    
    // いままでのランキングを取得
    ranking = (NSMutableArray *)[userDefaults arrayForKey:@"ranking"]; //userDefaultsに入ってる配列は、全部NSArrayになっちゃう
    
    // 最初は、0の配列を用意
    if (ranking == nil || ranking.count == 0) { // rankingの配列の中が空
        ranking = [[NSMutableArray alloc] initWithArray:@[@0, @0, @0, @0, @0]];
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tokuten = appDelegate.endlessScore;
    
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


- (void)ranking
{
    
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

@end

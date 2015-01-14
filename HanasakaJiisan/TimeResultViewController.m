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
    
    rank1 = [userDefaults integerForKey:@"rank1"];
    rank2 = [userDefaults integerForKey:@"rank2"];
    rank3 = [userDefaults integerForKey:@"rank3"];
    rank4 = [userDefaults integerForKey:@"rank4"];
    rank5 = [userDefaults integerForKey:@"rank5"];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tokuten = appDelegate.TimeScore;
    
    [self rank1];
    
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


-(void)rank1
{
    if(tokuten >= rank1){
        [userDefaults setInteger:rank4 forKey:@"rank5"];
        [userDefaults setInteger:rank3 forKey:@"rank4"];
        [userDefaults setInteger:rank2 forKey:@"rank3"];
        [userDefaults setInteger:rank1 forKey:@"rank2"];
        [userDefaults setInteger:tokuten forKey:@"rank1"];
        [self ranking];
    }else{
        [self rank2];
    }
}


-(void)rank2
{
    if(tokuten >= rank2){
        [userDefaults setInteger:rank4 forKey:@"rank5"];
        [userDefaults setInteger:rank3 forKey:@"rank4"];
        [userDefaults setInteger:rank2 forKey:@"rank3"];
        [userDefaults setInteger:tokuten forKey:@"rank2"];
        [self ranking];
    }else{
        [self rank3];
    }
}

-(void)rank3
{
    if(tokuten >= rank3){
        [userDefaults setInteger:rank4 forKey:@"rank5"];
        [userDefaults setInteger:rank3 forKey:@"rank4"];
        [userDefaults setInteger:tokuten forKey:@"rank3"];
        [self ranking];
    }else{
        [self rank4];
    }
}

-(void)rank4
{
    if(tokuten >= rank4){
        [userDefaults setInteger:rank4 forKey:@"rank5"];
        [userDefaults setInteger:tokuten forKey:@"rank4"];
        [self ranking];
    }else{
        [self rank5];
    }
        
}

-(void)rank5
{
    if(tokuten >= rank5){
        [userDefaults setInteger:tokuten forKey:@"rank5"];
    }
    [self ranking];
}

- (void)ranking
{
    rank1 = [userDefaults integerForKey:@"rank1"];
    rank2 = [userDefaults integerForKey:@"rank2"];
    rank3 = [userDefaults integerForKey:@"rank3"];
    rank4 = [userDefaults integerForKey:@"rank4"];
    rank5 = [userDefaults integerForKey:@"rank5"];
    
    rank1Label.text = [NSString stringWithFormat:@"%d",rank1];
    rank2Label.text = [NSString stringWithFormat:@"%d",rank2];
    rank3Label.text = [NSString stringWithFormat:@"%d",rank3];
    rank4Label.text = [NSString stringWithFormat:@"%d",rank4];
    rank5Label.text = [NSString stringWithFormat:@"%d",rank5];
}

-(IBAction)delete
{
    [userDefaults removeObjectForKey:@"rank1"];
    [userDefaults removeObjectForKey:@"rank2"];
    [userDefaults removeObjectForKey:@"rank3"];
    [userDefaults removeObjectForKey:@"rank4"];
    [userDefaults removeObjectForKey:@"rank5"];
}





@end

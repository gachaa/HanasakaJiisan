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
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                             target:self
                                           selector:@selector(up)
                                           userInfo:nil
                                            repeats:YES
             ];
    
    
    
    
    startBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startBt.center = CGPointMake(100,200);
    [startBt setTitle:@"start"
             forState:UIControlStateNormal];
    [startBt sizeToFit];
    [startBt addTarget:self
                action:@selector(start)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBt];
    
    timeLabel.text = @"" ;
    
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

-(void)up{
    if(s == 1){
        countd += 0.01 ;
        countdown = 4 - countd ;
        if(countd <= 3){
            countdown_label.text = [NSString stringWithFormat:@"%d",countdown];
        }else if(3 < countd && countd <= 3.2){
            countdown_label.text = @"すたーと！";
        }else{
            countdown_label.alpha = 0 ;
            time = 10 ;
            s = 2 ;
        }
    }else if(s == 2){
        time = time - 0.01f ;
        timeLabel.text = [NSString stringWithFormat:@"%.2f",time];
        if(time < 0){
            [timer invalidate];
        }
    }
}

-(IBAction)start{
    startBt.alpha = 0 ;
    s = 1 ;
    countdown_label = [[UILabel alloc] initWithFrame:(CGRectMake(10, 10, 100, 100))];
    [self.view addSubview:countdown_label];
}

















@end

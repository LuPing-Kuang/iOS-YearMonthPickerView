//
//  ViewController.m
//  iOS 自定义日期年月
//
//  Created by luo_Mac on 2017/4/20.
//  Copyright © 2017年 luo_Mac. All rights reserved.
//

#import "ViewController.h"
#import "YearMonthPikerView.h"

@interface ViewController ()

@property (nonatomic,strong) YearMonthPikerView *ymPikerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.ymPikerView = [[[NSBundle mainBundle] loadNibNamed:@"YearMonthPikerView" owner:nil options:nil] objectAtIndex:0];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.ymPikerView.frame = CGRectMake(0, 100, frame.size.width, self.ymPikerView.frame.size.height);
    [self.view addSubview:self.ymPikerView];
    
    self.ymPikerView.sureBlock = ^(NSString *year, NSString *month) {
        NSLog(@"year:%@,month:%@",year,month);
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  YearMonthPikerView.m
//  iOS 自定义日期年月
//
//  Created by luo_Mac on 2017/4/20.
//  Copyright © 2017年 luo_Mac. All rights reserved.
//

#import "YearMonthPikerView.h"

static const int loop = 20;

@interface YearMonthPikerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UIPickerView *ymPikerView;

@property (nonatomic,strong) NSArray *monthsArr;   //月份的数组

@property (nonatomic,strong) NSArray *yearsArr;    //年份的数组

@property (nonatomic,strong) NSDateFormatter *formatter;

@property (nonatomic,strong) NSString *currentYear;

@property (nonatomic,strong) NSString *currentMonth;

@property (nonatomic,assign) BOOL isCurrentYear;

@property (nonatomic,strong) NSString *selectYear;

@property (nonatomic,strong) NSString *selectMonth;

@end

@implementation YearMonthPikerView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.ymPikerView.delegate = self;
    self.ymPikerView.dataSource = self;
    
    //初始化
    self.monthsArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    
    [self.formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    NSDate *currentDate = [NSDate date];
    
    [self.formatter setDateFormat:@"MM"];
    self.currentMonth = [self.formatter stringFromDate:currentDate];
    self.selectMonth = self.monthsArr[(self.currentMonth.integerValue-1)];
    
    [self.formatter setDateFormat:@"yyyy"];
    self.currentYear = [self.formatter stringFromDate:currentDate];
    self.selectYear = self.currentYear;
    
    NSMutableArray <NSString*>*yearsArr = [NSMutableArray array];
    [yearsArr addObject:self.currentYear];
    
    int nowYear = [self.currentYear intValue];
    for (int i=0; i<loop; i++) {
        nowYear = nowYear - 1;
        NSString *nowYearStr = [NSString stringWithFormat:@"%d",nowYear];
        [yearsArr insertObject:nowYearStr atIndex:0];
    }
    self.yearsArr = yearsArr;
    self.isCurrentYear = YES;
    [self.ymPikerView selectRow:(self.yearsArr.count-1) inComponent:0 animated:YES];
    [self.ymPikerView selectRow:(self.currentMonth.intValue-1) inComponent:1 animated:YES];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return self.yearsArr.count;
    }else if (component==1){
        if (self.isCurrentYear) {
            return self.currentMonth.integerValue;
        }else{
            return self.monthsArr.count;
        }
    }else{
        return 0;
    }
}


- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        NSString *year = self.yearsArr[row];
        year = [year stringByAppendingString:@"年"];
        return year;
    }else if (component==1){
        NSString *month = self.monthsArr[row];
        month = [month stringByAppendingString:@"月"];
        return month;
    }else{
        return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0 && row==self.yearsArr.count-1) {
        self.isCurrentYear = YES;
        [self.ymPikerView reloadComponent:1];
        
        self.selectYear = self.yearsArr[row];
    }else if (component==0){
        self.isCurrentYear = NO;
        [self.ymPikerView reloadComponent:1];
        
        self.selectYear = self.yearsArr[row];
    }else if (component==1){
        self.selectMonth = self.monthsArr[row];
    }
}






- (IBAction)cancelBtnClick:(UIButton *)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}


- (IBAction)sureBtnClick:(UIButton *)sender {
    if (self.sureBlock) {
        self.sureBlock(self.selectYear, self.selectMonth);
    }
}


#pragma mark - 懒加载
- (NSDateFormatter*)formatter{
    if (_formatter==nil) {
        _formatter = [[NSDateFormatter alloc]init];
    }
    return _formatter;
}

@end

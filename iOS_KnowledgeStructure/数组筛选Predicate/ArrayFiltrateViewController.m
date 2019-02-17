//
//  ArrayFiltrateViewController.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/15.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "ArrayFiltrateViewController.h"
#import "ArrayFiltrateViewModel.h"

@interface ArrayFiltrateViewController ()

@end

@implementation ArrayFiltrateViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setupUI];
    
    //NSDate分为两部分，日期(Date)和时间(Time)
    NSDate* now = [NSDate date];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    //属性设置
    //    typedef CF_ENUM(CFIndex, CFDateFormatterStyle) {    // date and time format styles
    //        kCFDateFormatterNoStyle = 0,       // 无输出
    //        kCFDateFormatterShortStyle = 1,    // 12-10-29 下午2:52
    //        kCFDateFormatterMediumStyle = 2,   // 2012-10-29 下午2:51:43
    //        kCFDateFormatterLongStyle = 3,     // 2012年10月29日 GMT+0800下午2时51分08秒
    //        kCFDateFormatterFullStyle = 4      // 2012年10月29日星期一 中国标准时间下午2时46分49秒
    //    };
    fmt.dateStyle = kCFDateFormatterShortStyle;
    fmt.timeStyle = kCFDateFormatterShortStyle;
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//英文en_US
    //时间格式
    fmt.dateFormat = @"yyyy-MM-dd";
    fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";//2012-10-29T16:08:40
    fmt.dateFormat = @"yyyy-MM-dd a HH:mm:ss EEEE";//2012-10-29 下午 16:25:27 星期一
    fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";//@"2017-05-15T16:00:00.000+0000"

    
    NSString* dateString = [fmt stringFromDate:now];
    NSString *dateStr = @"2018-04-10";
    NSDate *date1 = [fmt dateFromString:dateStr];
    

}
//UTC时区，世界统一时间、0时区时间。
//将UTC时区时间转化为本地时区时间
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

#pragma mark - Getter, Setter

#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method
- (void)setupUI {
    NSPredicate *predice =[NSPredicate predicateWithFormat:@"age<%d",30];
    NSPredicate *predice1 =[NSPredicate predicateWithFormat:@"name='tom' && age<%d",30];
    NSPredicate *predice2 =[NSPredicate predicateWithFormat:@"self.name IN {'tom','rose'} || self.age IN {20,30}"];
    //以a开头
    NSPredicate *predice3 =[NSPredicate predicateWithFormat:@"name beginswith 'a'"];
    //以b结尾
    NSPredicate *predice4 =[NSPredicate predicateWithFormat:@"name endswith 'b'"];
    //包含c
    NSPredicate *predice5 =[NSPredicate predicateWithFormat:@"name contains 'c'"];
    //like匹配多字符
    //只要有s字母就满足
    NSPredicate *predice6 =[NSPredicate predicateWithFormat:@"name like 's'"];
    //第二个字符为s就满足,?代表一个字符
    NSPredicate *predice7 =[NSPredicate predicateWithFormat:@"name like '?s'"];
    
    NSArray *dataSource = [ArrayFiltrateViewModel dataSource];
    NSLog(@"result:%@",[dataSource filteredArrayUsingPredicate:predice]);
    
    

}


@end

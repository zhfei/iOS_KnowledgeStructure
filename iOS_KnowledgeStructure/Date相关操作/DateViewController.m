//
//  DateViewController.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/4/15.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "DateViewController.h"

@interface DateViewController ()

@end

@implementation DateViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addUI];
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self calendarAction];
}

#pragma mark - Private Method
- (void)addUI {
    
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupLayout {
    
}

- (void)setupData {
    
}

//MARK: Calendar 操作
- (void)calendarAction {
    NSCalendar *calender = [NSCalendar currentCalendar];
    //first date
    NSDateComponents *dateComp = [NSDateComponents new];
    dateComp.year = 2019;
    dateComp.month = 4;
    dateComp.day = 15;
    dateComp.hour = 13;
    dateComp.minute = 58;
    dateComp.second = 20;
    NSDate *firstDate = [calender dateFromComponents:dateComp];
    
    //second date
    //firstDate时间对应月中第几天
    NSRange dayRange = [calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstDate];
    dateComp.day = dayRange.length;
    dateComp.hour = 23;
    dateComp.minute = 59;
    dateComp.second = 59;
    NSDate *secondDate = [calender dateFromComponents:dateComp];
    
    //date 转 string
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *firstDateStr = [dateFormatter stringFromDate:firstDate];
    NSString *secondDateStr = [dateFormatter stringFromDate:secondDate];
    
    
//    //当前时间对应的周是一年中的第几周
//    [[NSCalendar currentCalendar] ordinalityOfUnit:NSWeekCalendarUnit inUnit:NSYearCalendarUnit forDate:[NSDate date]];
//    //firstDate时间对应月中第几天
//    NSRange dayRange1 = [calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstDate];

}

- (void)dateFormatterAction {
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
    //默认打印出的字符串是本地时区的时间；也可以通过下面直到到具体时区
    fmt.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    
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



#pragma mark - Public Method

#pragma mark - Event

#pragma mark - Delegate

#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject


@end

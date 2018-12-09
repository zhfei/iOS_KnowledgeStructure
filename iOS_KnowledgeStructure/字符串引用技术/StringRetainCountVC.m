//
//  StringRetainCountVC.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/12/9.
//  Copyright © 2018年 zhf. All rights reserved.
//

#import "StringRetainCountVC.h"

@interface StringRetainCountVC ()

@end

@implementation StringRetainCountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *str1=@"Kenshin";
    NSLog(@"retainCount(str1)=%i",(unsigned long)str1.retainCount); //结果：-1
    [str1 retain];
    NSLog(@"retainCount(str1)=%i",(unsigned long)str1.retainCount); //结果：-1
    
    NSString *str2=[NSString stringWithString:@"Kaoru"];
    NSLog(@"retainCount(str2)=%i",str2.retainCount); //结果：-1
    [str1 retain];
    NSLog(@"retainCount(str2)=%i",str2.retainCount); //结果：-1
    NSString *str2_1=[NSString stringWithString:[NSString stringWithFormat:@"Kaoru %@",@"sun"]];
    NSLog(@"retainCount(str2_1)=%i",str2_1.retainCount);//结果：2
    [str2_1 release];
    [str2_1 release];
    
    
    
    NSString *str3=[NSString stringWithFormat:@"Rosa %@",@"Sun"];
    NSLog(@"retainCount(str3)=%i",str3.retainCount); //结果：1
    [str3 retain];
    NSLog(@"retainCount(str3)=%i",str3.retainCount); //结果：2
    [str3 release];
    [str3 release];
    
    NSString *str4=[NSString stringWithUTF8String:"Jack"];
    NSLog(@"retainCount(str4)=%i",str4.retainCount); //结果：1
    [str4 retain];
    NSLog(@"retainCount(str4)=%i",str4.retainCount); //结果：2
    [str4 release];
    [str4 release];
    
    NSString *str5=[NSString stringWithCString:"Tom" encoding:NSUTF8StringEncoding];
    NSLog(@"retainCount(str5)=%i",str5.retainCount); //结果：1
    [str5 retain];
    NSLog(@"retainCount(str5)=%i",str5.retainCount); //结果：2
    [str5 release];
    [str5 release];
    
    
    
    NSMutableString *str6=@"Jerry";
    NSLog(@"retainCount(str6)=%i",str6.retainCount); //结果：-1
    [str6 retain];
    NSLog(@"retainCount(str6)=%i",str6.retainCount); //结果：-1
    [str6 release];
    [str6 release];
    
    NSMutableArray *str7=[NSMutableString stringWithString:@"Lily"];
    NSLog(@"retainCount(str7)=%i",str7.retainCount); //结果：1
    [str7 retain];
    NSLog(@"retainCount(str7)=%i",str7.retainCount); //结果：2
    [str7 release];
    [str7 release];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

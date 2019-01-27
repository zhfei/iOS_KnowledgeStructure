//
//  PhotoSaveAndVisitVc.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/1/27.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "PhotoSaveAndVisitVc.h"
#import <BottomComponentLib/UIImage+Custom.h>

@interface PhotoSaveAndVisitVc ()

@end

@implementation PhotoSaveAndVisitVc
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

#pragma mark - Getter, Setter

#pragma mark - Event
- (IBAction)saveAndVisitPhoto:(UIButton *)sender {
    UIImageWriteToSavedPhotosAlbum([UIImage screenshotInView:self.view], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (IBAction)photoLookOver:(UIButton *)sender {
    
}
#pragma mark - Public Method

#pragma mark - Private Method
- (void)setupUI {
    
}

- (void)setupLayout {
    
}

- (void)setupData {
    
}

- (void)resetUI {
    
}

- (void)resetLayout {
    
}

- (void)resetData {
    
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *)error contextInfo: (void *) contextInfo {
    NSString *msg = nil;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    NSLog(@"%@",msg);
}

#pragma mark - Delegate

#pragma mark - NSCopying

#pragma mark - NSObject

@end

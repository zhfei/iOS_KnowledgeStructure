//
//  CoreText_CoreImageVC.m
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/2/26.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "CoreText_CoreImageVC.h"

@interface CoreText_CoreImageVC ()
@property (nonatomic, weak) IBOutlet UIImageView *imageview;
@end

@implementation CoreText_CoreImageVC
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addUI];
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

#pragma mark - Getter, Setter

#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method


- (void)addUI {
    UIImage *image = self.imageview.image;
    //后台线程渲染，防止阻塞主线程
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
                   ^(void){
                       //获取图片资源,imageview.image是原图
                       CIImage *Ciimage = [[CIImage alloc]initWithImage:image];
                       //根据滤镜名称创建滤镜
                       CIFilter *fiter = [CIFilter filterWithName:@"CIPhotoEffectMono" keysAndValues:kCIInputImageKey,Ciimage, nil];
                       //这里使用的是默认参数，也可自己设置
                       [fiter setDefaults];
                       
                       //创建绘制上下文，默认使用GPU绘制
                       //创建基于 GPU 的 CIContext 对象
                       CIContext *context = [CIContext contextWithOptions:nil];
                       
                       //或者使用这种方法创建基于 GPU 的 CIContext 对象
                       //                       EAGLContext *gpucontext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
                       //                       CIContext *context = [CIContext contextWithEAGLContext: gpucontext];
                       
                       
                       //创建基于 CPU 的 CIContext 对象
                       //                       CIContext *context = [CIContext contextWithOptions: [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:kCIContextUseSoftwareRenderer]];
                       
                       // 渲染并输出CIImage
                       CIImage *outputImage = [fiter outputImage];
                       // 创建CGImage句柄
                       CGImageRef Cgimage = [context createCGImage:outputImage fromRect:[outputImage extent]];
                       UIImage *showimage = [UIImage imageWithCGImage:Cgimage];
                       // 释放CGImage句柄
                       CGImageRelease(Cgimage);
                       dispatch_async(dispatch_get_main_queue(), ^(void){
                           //回到主线程给控件赋值（渲染之后的图片）
                           self.imageview.image = showimage;
                       });
                   });
}

- (void)setupUI {
    
}

- (void)setupLayout {
    
}

- (void)setupData {
    
}



#pragma mark - Delegate

#pragma mark - NSCopying

#pragma mark - NSObject

@end

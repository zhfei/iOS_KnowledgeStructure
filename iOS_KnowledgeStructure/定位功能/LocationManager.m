//
//  LocationManager.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/26.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <BottomComponentLib/BCAlertController.h>

@interface LocationManager () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSNumber *longitude;//经度
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) CLGeocoder *geocoder;//反向地理编码，地址转经纬度/经纬度转地址
@property (nonatomic, copy) LocationBlock block;
@end

@implementation LocationManager
SingletonM(LocationManager)
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)startLocation {
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization....");
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void)startLocation:(LocationBlock)block {
    self.block = block;
    [self startLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"locations:%@",locations);
    CLLocation *locat = [locations lastObject];
    CLLocationCoordinate2D coordinate = locat.coordinate;
    NSLog(@"经度：%f, 纬度：%f",coordinate.longitude, coordinate.latitude);
    
    self.longitude = [NSNumber numberWithFloat:coordinate.longitude];
    self.latitude = [NSNumber numberWithFloat:coordinate.latitude];
    
    [self.locationManager stopUpdatingLocation];
    
    [self latitudeStr:self.latitude LongitudeStr:self.longitude];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error:%@",error);
    [BCAlertController showWithTitle:@"定位失败" message:@"" btn1Title:@"确定" btn1Handle:^(UIAlertAction * _Nullable action) {
        
    }];
}

#pragma mark 根据地名确定地理坐标
//地址转经纬度方法（_longitude，_latitude就是地址解析后的经纬度）
//如：@"上海市徐汇区漕溪北路41号"
-(void)getCoordinateByAddress:(NSString *)address{
    
    //地理编码
    WeakSelf
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        StrongSelf
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark=[placemarks firstObject];
        CLLocation *location=placemark.location;//位置
        CLRegion *region=placemark.region;//区域
        NSDictionary *addressDic= placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
//        NSString *name=placemark.name;//地名
//        NSString *thoroughfare=placemark.thoroughfare;//街道
//        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
//        NSString *locality=placemark.locality; // 城市
//        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
//        NSString *administrativeArea=placemark.administrativeArea; // 州
//        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
//        NSString *postalCode=placemark.postalCode; //邮编
//        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
//        NSString *country=placemark.country; //国家
//        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
//        NSString *ocean=placemark.ocean; // 海洋
//        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
        NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);

        CLLocationDegrees latitude=location.coordinate.latitude;
        CLLocationDegrees longitude=location.coordinate.longitude;
        NSLog(@"纬度-->%lf,经度-->%lf",latitude,longitude);
        //传给接口的纬度和经度
        self.latitude=[NSString stringWithFormat:@"%lf",latitude];
        self.longitude=[NSString stringWithFormat:@"%lf",longitude];
    }];
    
}

//根据经纬度转地址
-(NSString*)latitudeStr:(NSNumber*)Latitude LongitudeStr:(NSNumber*)Longitude {
    static NSString *addstroing = @"";

    float a = [Latitude floatValue];
    float b = [Longitude floatValue];
    CLLocation* location = [[CLLocation alloc] initWithLatitude:a longitude:b];
    //位置反编码, IOS5.0之后CL
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray*placemarks,NSError*error) {
        for(CLPlacemark *placemark in placemarks) {
            //CLPlacemark 地标
//            NSLog(@"位置:%@", placemark.name);
//            NSLog(@"街道:%@", placemark.thoroughfare);
//            NSLog(@"子街道:%@", placemark.subThoroughfare);
//            NSLog(@"市:%@", placemark.locality);
//            NSLog(@"区\\县:%@", placemark.subLocality);
//            NSLog(@"行政区:%@", placemark.administrativeArea);
//            NSLog(@"国家:%@", placemark.country);
            addstroing = [NSString stringWithFormat:@"%@%@%@%@%@",placemark.administrativeArea,placemark.locality,placemark.subLocality,placemark.thoroughfare,placemark.subThoroughfare];
        }
        
        if (self.block) {
            self.block(addstroing);
        }
    }];
    NSLog(@"地址：%@",addstroing);
    return addstroing;
}
@end

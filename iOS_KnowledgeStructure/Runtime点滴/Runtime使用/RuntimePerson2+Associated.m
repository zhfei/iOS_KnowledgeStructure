//
//  RuntimePerson2+Associated.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/1/30.
//  Copyright © 2019年 zhf. All rights reserved.
//

#import "RuntimePerson2+Associated.h"
#import <objc/runtime.h>
#import <objc/message.h>

const char * bustkey = "bustkey";
const char * callBackkey = "callBackkey";


@implementation RuntimePerson2 (Associated)
- (NSNumber *)associatedBust {
    return objc_getAssociatedObject(self, bustkey);
}

- (void)setAssociatedBust:(NSNumber *)associatedBust {
    objc_setAssociatedObject(self, bustkey, associatedBust, OBJC_ASSOCIATION_RETAIN);
}

- (void)setAssociatedCallBack:(CodingCallBack)associatedCallBack {
    objc_setAssociatedObject(self, callBackkey, associatedCallBack, OBJC_ASSOCIATION_COPY);
}

- (CodingCallBack)associatedCallBack {
    return objc_getAssociatedObject(self, callBackkey);
}

@end

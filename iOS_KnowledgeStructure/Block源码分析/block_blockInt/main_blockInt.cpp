//
//#ifndef BLOCK_IMPL
//#define BLOCK_IMPL
//struct __block_impl {
//    void *isa;
//    int Flags;
//    int Reserved;
//    void *FuncPtr;
//};
//
//struct __Block_byref_age_0 {
//    void *__isa;
//    __Block_byref_age_0 *__forwarding;
//    int __flags;
//    int __size;
//    NSInteger age;
//};
//
//struct __main_block_impl_0 {
//    struct __block_impl impl;
//    struct __main_block_desc_0* Desc;
//    __Block_byref_age_0 *age; // by ref
//    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_age_0 *_age, int flags=0) : age(_age->__forwarding) {
//        impl.isa = &_NSConcreteStackBlock;
//        impl.Flags = flags;
//        impl.FuncPtr = fp;
//        Desc = desc;
//    }
//};
//static void __main_block_func_0(struct __main_block_impl_0 *__cself, NSString *name) {
//    __Block_byref_age_0 *age = __cself->age; // bound by ref
//
//    NSLog((NSString *)&__NSConstantStringImpl__var_folders_4y_ks8945f50k51_0j95ytw7ss80000gn_T_main_7acc63_mi_0,name,(age->__forwarding->age));
//}
//static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->age, (void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);}
//
//static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);}
//
//static struct __main_block_desc_0 {
//    size_t reserved;
//    size_t Block_size;
//    void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
//    void (*dispose)(struct __main_block_impl_0*);
//} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};
//int main(int argc, char * argv[]) {
//    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
//
//        __attribute__((__blocks__(byref))) __Block_byref_age_0 age = {(void*)0,(__Block_byref_age_0 *)&age, 0, sizeof(__Block_byref_age_0), 10};
//        void(*completeBlock)(NSString *) = ((void (*)(NSString *))&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_age_0 *)&age, 570425344));
//
//        ((void (*)(__block_impl *, NSString *))((__block_impl *)completeBlock)->FuncPtr)((__block_impl *)completeBlock, (NSString *)&__NSConstantStringImpl__var_folders_4y_ks8945f50k51_0j95ytw7ss80000gn_T_main_7acc63_mi_1);
//
//        return UIApplicationMain(argc, argv, __null, NSStringFromClass(((Class (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("AppDelegate"), sel_registerName("class"))));
//    }
//}
//static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };

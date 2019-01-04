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
//struct __main_block_impl_0 {
//    struct __block_impl impl;
//    struct __main_block_desc_0* Desc;
//    NSInteger age;
//    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, NSInteger _age, int flags=0) : age(_age) {
//        impl.isa = &_NSConcreteStackBlock;
//        impl.Flags = flags;
//        impl.FuncPtr = fp;
//        Desc = desc;
//    }
//};
//static void __main_block_func_0(struct __main_block_impl_0 *__cself, NSString *name) {
//    NSInteger age = __cself->age; // bound by copy
//
//    NSString *info = ((NSString * _Nonnull (*)(id, SEL, NSString * _Nonnull, ...))(void *)objc_msgSend)((id)objc_getClass("NSString"), sel_registerName("stringWithFormat:"), (NSString *)&__NSConstantStringImpl__var_folders_4y_ks8945f50k51_0j95ytw7ss80000gn_T_main_83d55e_mi_0, (NSString *)name, (NSInteger)age);
//    NSLog((NSString *)&__NSConstantStringImpl__var_folders_4y_ks8945f50k51_0j95ytw7ss80000gn_T_main_83d55e_mi_1,info);
//}
//
//static struct __main_block_desc_0 {
//    size_t reserved;
//    size_t Block_size;
//} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};
//int main(int argc, char * argv[]) {
//    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
//
//        NSInteger age = 10;
//        void(*completeBlock)(NSString *) = ((void (*)(NSString *))&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, age));
//
//        ((void (*)(__block_impl *, NSString *))((__block_impl *)completeBlock)->FuncPtr)((__block_impl *)completeBlock, (NSString *)&__NSConstantStringImpl__var_folders_4y_ks8945f50k51_0j95ytw7ss80000gn_T_main_83d55e_mi_2);
//
//        return UIApplicationMain(argc, argv, __null, NSStringFromClass(((Class (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("AppDelegate"), sel_registerName("class"))));
//    }
//}
//static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };

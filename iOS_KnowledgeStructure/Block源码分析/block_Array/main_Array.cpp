//
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
//    NSMutableArray *friends;
//    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, NSMutableArray *_friends, int flags=0) : friends(_friends) {
//        impl.isa = &_NSConcreteStackBlock;
//        impl.Flags = flags;
//        impl.FuncPtr = fp;
//        Desc = desc;
//    }
//};
//static void __main_block_func_0(struct __main_block_impl_0 *__cself, NSString *name) {
//    NSMutableArray *friends = __cself->friends; // bound by copy
//
//    NSLog((NSString *)&__NSConstantStringImpl__var_folders_4y_ks8945f50k51_0j95ytw7ss80000gn_T_main_1b4a2f_mi_0,name,friends);
//}
//static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->friends, (void*)src->friends, 3/*BLOCK_FIELD_IS_OBJECT*/);}
//
//static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->friends, 3/*BLOCK_FIELD_IS_OBJECT*/);}
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
//        NSMutableArray *friends = ((NSMutableArray * _Nonnull (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSMutableArray"), sel_registerName("array"));;
//        void(*completeBlock)(NSString *) = ((void (*)(NSString *))&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, friends, 570425344));
//
//        ((void (*)(__block_impl *, NSString *))((__block_impl *)completeBlock)->FuncPtr)((__block_impl *)completeBlock, (NSString *)&__NSConstantStringImpl__var_folders_4y_ks8945f50k51_0j95ytw7ss80000gn_T_main_1b4a2f_mi_1);
//
//        return UIApplicationMain(argc, argv, __null, NSStringFromClass(((Class (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("AppDelegate"), sel_registerName("class"))));
//    }
//}
//static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };
//


#### 核心原则
一、代码要简洁易懂，逻辑清晰
（代码是给人看的；简洁的代码让bug无处藏身）
二、面向变化编程，而不是面向需求编程
（需求是暂时的，本次迭代不能仅仅为了当前需求；写出扩展性强，易修改的代码才是王道）。
三、先保证程序的正确性，防止过度设计。
（先把当前的问题解决好，再考虑扩展，重用）。

#### 通用规范
**运算符**
一元运算符无空格
二元运算符前后都空格
多种运算符用（）表示优先级

**变量**
变量功能单一
变量要初始化
变量挨着使用的地方

**If语句**
用{}列出所有的分支，每个分支有明确的结果
用return提前返回，减少多余的分支
if的条件过长时，先合并到一个bool上
if中的count == 6，常数前后问题
每个分支要被{}包裹
条件、参数过多（>=3）需要折行

**for语句**
For语句内不要修改循环变量
避免使用break, contain；break判断放到循环外，contain条件取反

**switch语句**
每个分支用{}括起来
枚举不能用default，其他都用

**函数**
函数高度不能超过50行(一屏)
一个函数只做一件事
有返回值的函数，每个分支都有返回值
对于传如的参数 首先判断，有问题提前返回。
复杂函数、公共功能，抽出来做单独方法。

**注释**
暴露接口要注释

**iOS规范**
变量
类名、协议名用大驼峰。
局部变量名用小驼峰
描述名+类型简写
系统常用类要在后面加上简短标示
```
UIViewController    VC
UIView    View
UIButton    Btn
UIImage    Img
```

**常量**
常量以类名为前缀
```
static const NSTimeInterval ZOCSignInViewControllerFadeOutAnimationDuration = 0.4;
```
多用常量，少用#define预处理指令
常量对外公开时.h声明，.m实现
```
//头文件
extern NSString *const ZOCCacheControllerDidClearCacheNotification;

//实现文件
static NSString * const ZOCCacheControllerDidClearCacheNotification = @"ZOCCacheControllerDidClearCacheNotification";
static const CGFloat ZOCImageThumbnailHeight = 50.0f;

```

**宏**
宏使用大写字母，并用“_”分割。
```
#define URL_GAIN_QUOTE_LIST @"/v1/quote/list"
#define URL_UPDATE_QUOTE_LIST @"/v1/quote/update"
#define URL_LOGIN  @"/v1/user/login”
宏中定义的表达式，用()包起来
#define MY_MIN(A, B)  ((A)>(B)?(B):(A))
```

**CGRect函数**
多用rect获取frame
```
CGRect frame = self.view.frame; 
CGFloat x = CGRectGetMinX(frame); 
CGFloat y = CGRectGetMinY(frame); 
CGFloat width = CGRectGetWidth(frame); 
CGFloat height = CGRectGetHeight(frame); 
CGRect frame = CGRectMake(0.0, 0.0, width, height);
```


**范型**
定义NSArray, NSDictroy多使用范型
```
NSArray<NSString *> *testArr = [NSArray arrayWithObjects:@"Hello", @"world", nil];
NSDictionary<NSString *, NSNumber *> *dic = @{@"key":@(1), @"age":@(10)};
```

**Block**
为常用的Block定义typedef
`typedef int(^EOCSomeBlock)(BOOL flag, int value);`

**字面量语法**
尽量使用字面量语法创建NSString, NSNumber。便于直观看到。
```
NSArray *names = @[@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul"];
NSDictionary *productManagers = @{@"iPhone" : @"Kate", @"iPad" : @"Kamal", @"Mobile Web" : @"Bill"}; 
NSNumber *shouldUseLiterals = @YES;NSNumber *buildingZIPCode = @10018; 

```
**属性**
除了init和dealloc，其他都用’.’语法
使用内存管理语意，kvo监听。
方法与’.’语法严格使用。
.h中属性要不可变。

**方法**
方法中方法签名与参数保持一致
方法参数超过三个要折行显示，以：对齐

**面向协议编程，保持对下扩展**
iOS中委托协议中，代理与数据源的区分
代理：事件流从委托者->代理者
数据源：数据流从代理者->委托者

**类**
以三个大写字母为前缀开头
子类独有名称是添加在前缀与父类名称前。
```
//父类
ZOCSalesListViewController

//子类
ZOCDaySalesListViewController
ZOCMonthSalesListViewController
```
各种逻辑要有固定的排序
类提供的初始化方法中，一个全能初始化方法+多个便利初始化方法。
所有返回对象的方法中，都要以instancetype为返回类型。

**分类**
方法以前缀+“_”开始
如果类的业务量大，根据类的业务不同，划分到不同分类中

单例
单例不是容器，它是处理某一类任务的工具。
```
+ (instancetype)sharedInstance 
{ 
static id sharedInstance = nil; 
static dispatch_once_t onceToken = 0;
dispatch_once(&onceToken, ^{ 
sharedInstance = [[self alloc] init];
}); 
return sharedInstance; 
} 

```
**相等性判断**
重写相等判断方法
`-  (BOOL)isEqual:(id)object`

**方法说明**
无法用自命名说明的函数，需要用字符串说明。
对外暴露的公共接口，需要用字符串说明。

**多线程资源争夺**
少用锁
使用串行队列
```
_syncQueue = dispatch_queue_create("com.effectiveobjectivec.syncQueue", NULL);

//设置字符串
- (void)setSomeString:(NSString*)someString  {
dispatch_sync(_syncQueue, ^{
_someString = someString;
});
}
```
使用异步栅栏函数
```
//设置字符串
- (void)setSomeString:(NSString*)someString {
dispatch_barrier_async(_syncQueue, ^{
_someString = someString;
});
}
```

**重写description描述方法**
```
- (NSString*)description  {
return [NSString stringWithFormat:@"<%@: %p, %@ %@>", [self class], self, firstName, lastName];
}
```

**集合操作**
NSArray, NSDictory存取时，添加判断nil, 判断下标越界问题。
使用firstObj, lastObj安全访问方法。

**缓存**
优先使用NSCache, 而不是NSDictory

**通知**
将通知名声明为常量，放在单独文件中管理

**其他**
文件逻辑路径与物理路径保持一致
使用编译指令，忽略警告和无用方法
```
- (NSInteger)giveMeFive 
{ 
NSString *foo; 
#pragma unused (foo) 
return 5; 
} 

- (float)divide:(float)dividend by:(float)divisor 
{ 
#warning Dude, don't compare floating point numbers like this! 
if (divisor != 0.0) { 
return (dividend / divisor); 
} else {  
return NAN; 
} 
} 
```

手动创建一个错误
```
- (NSInteger)divide:(NSInteger)dividend by:(NSInteger)divisor 
{ 
#error Whoa, buddy, you need to check for zero here! 
return (dividend / divisor); 
} 

```



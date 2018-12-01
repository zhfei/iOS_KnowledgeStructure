####  混过开发
什么时候用混合开发？
- 排版复杂，包含了复杂的图文混排
- 界面变化需求频繁
- 界面对用户交互需求不复杂

模版渲染：本地网页数据难免有数据二次加工处理，写在一个字符串中很不灵活

```
- (NSString *)htmlString {

NSString *str = @"<html>"
"<head>"
"<meta charset='UTF-8'>"
"</head>"
"<body>"
"<h1>%@</h1>"
"<p>%@</p>"
"</body>"
"</html>";

return [NSString stringWithFormat:str,[UIDevice currentDevice].model,[UIDevice currentDevice].systemName];
}

```
目前使用比较多的模版引擎

####  MGTemplateEngine
```
<!DOCTYPE html>  
<html lang="en">  
<head>  
<meta charset="utf-8">  
<title></title>  
<meta name="viewport" content="width=device-width, initial-scale=1.0">  
<link href="./detail.css" rel="stylesheet">  
</head>  
<body>  
<div id='container' name="container">  
<div class="title">{{ title }}</div>  
<div class="date">{{ date }}</div>  
<div class="content">{{ content }}</div>  
</div>  
</body>  
</html>  
```

```
// Set up template engine with your chosen matcher.  
MGTemplateEngine *engine = [MGTemplateEngine templateEngine];  
//[engine setDelegate:self];  
[engine setMatcher:[ICUTemplateMatcher matcherWithTemplateEngine:engine]];  

// 这里就是设置，或者里边塞变量的地方。其实也可以设置一个数组，这样模板的灵活也会更强。这里我就不演示了官方有例子  
[engine setObject:self.detailData[@"title"] forKey:@"title"];  
[engine setObject:self.detailData[@"content"] forKey:@"content"];  

// MGTemplateEngine/Detail/detail.html  
// MGTemplateEngine/Detail/detail.css  
NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"detail" ofType:@"html"];  

// Process the template and display the results.  
NSString *html = [engine processTemplateInFileAtPath:templatePath withVariables:nil];  

// 获得HTML  
self.htmlWebView = [[UIWebView alloc] initWithFrame:CGRectMake(8, 5, 304, 320)];  
self.htmlWebView.delegate = self;  
self.htmlWebView.userInteractionEnabled = NO;  

// 你就能加载到HTML里面的.css文件  
NSString *baseURL = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Detail"];  
[self.htmlWebView loadHTMLString:html baseURL:[NSURL fileURLWithPath:baseURL]];  
[self.detailView addSubview:self.htmlWebView]; 
```


#### GRMustache

```
NSString *fileName = @"template.html";
NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
NSString *templete = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];


NSDictionary *dict = @{@"name":@"hello", @"content":@"wooooood"};
NSString *content = [GRMustacheTemplate renderObject:dict fromString:templete error:nil];
```

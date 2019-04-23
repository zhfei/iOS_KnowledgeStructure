//
//  RichTextViewController.m
//  iOS_KnowledgeStructure
//
//  Created by zhoufei on 2019/4/19.
//  Copyright © 2019年 zhf. All rights reserved.
//

/*NSForegroundColorAttributeName设置字体颜色，对象UIColor;
 NSParagraphStyleAttributeName设置段落格式，对象NSMutableParagraphStyle;
 NSFontAttributeName设置字体，对象UIFont;
 NSBackgroundColorAttributeName设置背景颜色，对象UIColor;
 NSKernAttributeName设置字符间距，对象NSNumber
 NSStrikethroughStyleAttributeName是指删除线样式 对象NSUnderlineStyle
 NSStrikethroughColorAttributeName删除线颜色，对象UIColor
 NSUnderlineStyleAttributeName设置下划线，参考删除线
 NSUnderlineColorAttributeName设置下划线颜色
 NSStrokeWidthAttributeName设置笔画宽度，对象NSNumber，负值填充效果，正值中空效果
 NSStrokeColorAttributeName当文字中空或者填充设置文字的描边颜色，对象UIColor；
 NSShadowAttributeName 设置阴影，NSShadow对象
 NSBaselineOffsetAttributeName设置基线偏移值，对象NSNumber （float）,正值上偏，负值下偏
 NSObliquenessAttributeName设置字形倾斜度，对象NSNumber （float）,正值右倾，负值左倾
 NSExpansionAttributeName 设置文本横向拉伸属性，对象NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
 NSVerticalGlyphFormAttributeName   设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
 NSLinkAttributeName设置链接属性，点击后调用浏览器打开指定URL地址,对象NSString，NSUrl，这个只能UITextView可用UITextView的代理方法中shouldInteractWithURL返回true可用
 NSTextEffectAttributeName设置文本特殊效果，目前只有一个可用效果  NSTextEffectLetterpressStyle（凸版印刷效果
 设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符//没有测出效果
 */

#import "RichTextViewController.h"
#import <YYLabel.h>
#import <YYText.h>

@interface RichTextViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
@property (strong, nonatomic) YYLabel *yyLabel;

@end

@implementation RichTextViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addUI];
    [self setupUI];
    [self setupLayout];
    [self setupData];
    [self initData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showText];
    [self paragraphStyleText];
    
    CGSize size = [self contextLabelSize];
    NSLog(@"size:%@",NSStringFromCGSize(size));
    
    self.yyLabel.attributedText = [self stopConsulteHintText];

}

#pragma mark - Private Method


- (void)addUI {
    [self.view addSubview:self.yyLabel];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)setupLayout {
    
}

- (void)initData {
    
}

- (void)setupData {
//    self.yyLabel.attributedText = [self stopConsulteHintText];
}

- (void)showText {
    NSString *text = @"池塘大桥下，游过一群鸭，快来快来数一数，二四六七八，嘎嘎嘎嘎，真呀真多呀，fly，数不清到底多少鸭";
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距为
    [paragraphStyle setLineSpacing:8];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName :  [UIColor blueColor], NSParagraphStyleAttributeName: paragraphStyle,  NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}] ;
    
    //设置特殊字体文本格式
    NSRange range = [text rangeOfString:@"池塘大桥下"];
    [string addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                            NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSBackgroundColorAttributeName:[UIColor yellowColor],NSKernAttributeName:@(12),NSStrikethroughStyleAttributeName:@(NSUnderlineStyleDouble),NSStrikethroughColorAttributeName:[UIColor purpleColor]} range:range];//添加属性
    
    NSRange range1 = [text rangeOfString:@"游过"];
    [string addAttributes:@{NSStrokeWidthAttributeName:@(-2),NSStrokeColorAttributeName:[UIColor redColor]} range:range1];//添加属性
    
    
    NSRange range2 = [text rangeOfString:@"一群鸭"];
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor:[UIColor redColor]];
    [shadow setShadowOffset:CGSizeMake(5.0f, 5.0f)];//设置x，y轴偏移量
    [shadow setShadowBlurRadius:1.0];//设置模糊度
    [string addAttributes:@{NSShadowAttributeName:shadow} range:range2];//添加属性
    
    NSRange range3 = [text rangeOfString:@"快来快来"];
    [string addAttributes:@{NSBaselineOffsetAttributeName:@(10)} range:range3];//添加属性
    
    NSRange range4 = [text rangeOfString:@"数一数"];
    [string addAttributes:@{NSObliquenessAttributeName:@(0.5)} range:range4];//添加属性
    NSRange range5 = [text rangeOfString:@"二四"];
    [string addAttributes:@{NSExpansionAttributeName:@(0.8)} range:range5];//添加属性
    NSRange range6 = [text rangeOfString:@"六七八"];
    [string addAttributes:@{NSExpansionAttributeName:@(-0.8)} range:range6];//添加属性
    
    /**
     没有测出具体的区别
     NSWritingDirectionAttributeName    设置文字书写方向，从左向右书写或者从右向左书写
     @[@(NSWritingDirectionLeftToRight | NSWritingDirectionEmbedding)]
     @[@(NSWritingDirectionLeftToRight | NSWritingDirectionOverride)]
     @[@(NSWritingDirectionRightToLeft | NSWritingDirectionEmbedding)]
     @[@(NSWritingDirectionRightToLeft | NSWritingDirectionOverride)]
     */
    
    [string addAttributes:@{NSWritingDirectionAttributeName:@[@(NSWritingDirectionRightToLeft | NSWritingDirectionEmbedding)]} range:NSMakeRange(0, text.length)];//添加属性
    
    [string addAttributes:@{NSVerticalGlyphFormAttributeName:@1} range:NSMakeRange(0, text.length)];//添加属性
    
    NSRange range8 = [text rangeOfString:@"嘎嘎嘎嘎"];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    [string addAttributes:@{NSLinkAttributeName:url} range:range8];//添加属性
    NSRange range9 = [text rangeOfString:@"真呀真多呀"];
    [string addAttributes:@{NSTextEffectAttributeName:NSTextEffectLetterpressStyle} range:range9];//添加属性
    NSRange range10 = [text rangeOfString:@"fly"];
    [string addAttributes:@{NSLigatureAttributeName:@0} range:range10];//添加属性
    
    self.contextLabel.attributedText = string;
}

// !!!: 段落样式
- (void)paragraphStyleText {
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    
    //使用一张图片作为Attachment数据
    
    attachment.image = [UIImage imageNamed:@"chepaihao"];
    
    //这里bounds的x值并不会产生影响
    
    attachment.bounds = CGRectMake(5,  (self.contextLabel.font.lineHeight - self.contextLabel.font.pointSize) / 2, 20, 10);
    
    
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle1 setLineSpacing:20];
    
    //首行缩进
    
    [paragraphStyle1 setFirstLineHeadIndent:20];
    
    [paragraphStyle1 setLineBreakMode:NSLineBreakByTruncatingMiddle];
    
    //两端对齐的）文本对齐方式
    
    paragraphStyle1.minimumLineHeight = 10;//最低行高
    
    paragraphStyle1.maximumLineHeight = 20;//最大行高
    
    paragraphStyle1.paragraphSpacing = 45;//段与段之间的间距
    
    //    paragraphStyle1.paragraphSpacingBefore = 1000;//段首行空白空间
    
    paragraphStyle1.baseWritingDirection = NSWritingDirectionLeftToRight;//从左到右的书写方向（一共➡️三种）
    
    //        paragraphStyle1.lineHeightMultiple = -100;没有测出效果
    
    //    paragraphStyle1.hyphenationFactor = 1;//连字属性 在iOS，唯一支持的值分别为0和1
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"你是一个好人,你是一个好人,你是一个好人,你是一个好人,你是一个好人,你是一个好人,你是一个好人,你是一个好人,你是一个好人,你是一个好人" attributes:@{NSParagraphStyleAttributeName: paragraphStyle1}];
    
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    
    [attributedString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n你是一个好人,你是一个好人,你是一个好人,你是一个好人,你是一个好人,你是一个好人,你是一个好人,你是一个好人,你是一个好人,你是一个好人" attributes:@{NSParagraphStyleAttributeName: paragraphStyle1}]];
    
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    
//    self.label1.backgroundColor = [UIColor redColor];
    
    //    self.label1.textAlignment = NSTextAlignmentCenter;
    
//    self.label1.attributedText = attributedString;
    
    //    self.label1.lineBreakMode = NSLineBreakByCharWrapping;
    
    [attributedString appendAttributedString:self.contextLabel.attributedText];
    self.contextLabel.attributedText = attributedString;
    
}

- (CGSize)contextLabelSize {
    CGSize attSize = [self.contextLabel.text boundingRectWithSize:CGSizeMake(self.contextLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
    return attSize;

}

- (void)addClickAction {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    self.contextLabel.userInteractionEnabled = YES;
    [self.contextLabel addGestureRecognizer:tap];
}

- (NSMutableAttributedString *)stopConsulteHintText {
    
    NSString *string = @"下班时间到了，当前时间为\n 2019年3月30日——2019年3月31日\n 如想继续上班请联系客服：16898990";
    NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:string];
    attri_str.yy_alignment = NSTextAlignmentCenter;
    attri_str.yy_font = [UIFont systemFontOfSize:16];
    attri_str.yy_color = [UIColor colorWithRed:0.1 green:0.2 blue:0.3 alpha:1];
    
    [attri_str yy_setColor:[UIColor redColor] range:[string rangeOfString:@"16898990"]];
    
    [attri_str yy_setTextHighlightRange:[string rangeOfString:@"16898990"] color:[UIColor redColor] backgroundColor:[UIColor orangeColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"被点击");
    }];
    return attri_str;
}


#pragma mark - Public Method

#pragma mark - Event
- (void)tapAction:(UITapGestureRecognizer *)tap {
    UILabel *label = (UILabel *)tap.view;
    NSRange range = [label.text rangeOfString:@"嘎嘎嘎嘎"];
    
}


#pragma mark - Delegate

#pragma mark - Getter, Setter
- (YYLabel *)yyLabel {
    if (!_yyLabel) {
        CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
        CGFloat heightS = [UIScreen mainScreen].bounds.size.height;
        
        _yyLabel = [YYLabel new];
        _yyLabel.textAlignment = NSTextAlignmentCenter;
        _yyLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _yyLabel.numberOfLines = 0;
        _yyLabel.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
        _yyLabel.displaysAsynchronously = YES;   //比较耗时的渲染操作在后台运行
        _yyLabel.clearContentsBeforeAsynchronouslyDisplay = NO;  //在进行后台渲染前是否清除掉之前的内容，如果YES就会先清除之前的内容，可能会出现空白
        //    YYTextContainer  *titleContarer = [YYTextContainer new];
        //    //限制宽度
        //    titleContarer.size = CGSizeMake(SCREEN_WIDTH,CGFLOAT_MAX);
        //    label.textLayout = [YYTextLayout layoutWithContainer:titleContarer text:text];
        //    CGFloat titleLabelHeight = label.textLayout.textBoundingSize.height;
        // YYLabel要想自动换行，必须设置最大换行的宽度
        _yyLabel.preferredMaxLayoutWidth = widthS-40;
        
        _yyLabel.frame = CGRectMake(10, CGRectGetMaxY(self.contextLabel.frame), widthS-20, 100);
    }
    return _yyLabel;
}

#pragma mark - NSCopying

#pragma mark - NSObject


@end

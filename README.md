# PZTheme
## 背景
苹果iOS 13推出了暗黑模式，通过UITraitEnvironment协议让UIView 、UIViewController 、UIScreen和UIWindow 都具有一个traitCollection来控制自身的颜色模式。比较典型的适配方式，比如UIColor通过colorWithDynamicProvider，UIImage可以通过xcassets添加dark类型来自动支持模式的切换。

但是作为开发者而言，任何一款APP都不可能只支持最新iOS版本，如果你的APP以前只有一个颜色模式，按照苹果指导的方式适配即可。但是如果原来就有黑白两种模式的话，适配起来就会变得困难。因此PZTheme旨在通过一套代码去适配iOS13的暗黑模式和iOS13以下自定义的黑白模式。

## 使用介绍
### 引入方式
```
pod 'PZTheme', '~> 0.2.0'
```

### PZTheme
PZTheme是一个单例模式，有一个自身的theme属性来控制黑白样式，该属性改变时会发对对应的NSNotification去触发handleTheme。PZTheme 可以通过THEME_PICKER(light,dark,theme)来配置样式选择和当前样式。

PZTheme定义了三种主题模式：

```
PZThemeStyle_Auto	自动模式，只能用于设置单个控件的主题，不可用于全局主题的设置。
PZThemeStyle_Light	明亮模式
PZThemeStyle_Dark   暗黑模式
```

### PZWindow
PZWindow 主要通过traitCollectionDidChange回调方法去修改PZTheme的全局设置，从而实现iOS13以上的动态切换功能。

### PZObject
通过Runtime方式给NSObject添加了一个名为pz的PZObject对象（pz可以视为NSObject的一个助理，其生命周期与NSObject保持一致）。同时PZObject自带了一个PZThemeStyle类型的属性theme，用于定制单个控件的主题。

PZObject主要支持下面两个方法：

```
- (T)customize:(void(^)(T x))block;

- (void)handleTheme:(void(^)(T x))block;
```

customize 方法主要完成NSObject初始化之后自身定制化工作，该方法只会执行一次。customize本身没有什么特性逻辑，其实质上一个语法糖，借鉴于L闭包的概念，使代码更加清晰，CV操作更方便。同时返回NSObject自身，使其能达到链式表达的效果。customize方法使用示例如下：

```
UIButton *btn = [[UIButton new].pz customize:^(UIButton *button) {
    button.frame = CGRectMake(0, 0, 127, 53);
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button setTitle:@"Test" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jumpNext:) forControlEvents:UIControlEventTouchUpInside];
}];
[self addSubview:btn];
```

handleTheme方法则实现动态切换的关键，助理pz会为NSObject保存这个block，在执行时先默认调用一次，后面收到特定的NSNotification会再次调用这个block，从而达到动态切换效果。实际上，按照这种模式你还可以定义出handleTheme2，handleTheme3的方法来对应不同NSNotification来实现任何需要动态切换场景，比如切换字体大小等。handleTheme的使用示例如下

```
[btn.pz handleTheme:^(UIButton *btn) {
    [btn setBackgroundImage:THEME_PICKER([UIImage imageNamed:@"bg"],[UIImage imageNamed:@"bg_dark"],theme) forState:UIControlStateNormal];
    [btn setTitleColor:THEME_PICKER([UIColor blackColor],[UIColor whiteColor],theme) forState:UIControlStateNormal];
}];
```




# PZTheme
## 背景
苹果iOS 13推出了暗黑模式，通过UITraitEnvironment协议让UIView 、UIViewController 、UIScreen和UIWindow 都具有一个traitCollection来控制自身的颜色模式。比较典型的适配方式，比如UIColor通过colorWithDynamicProvider，UIImage可以通过xcassets添加dark类型来自动支持模式的切换。

但是作为开发者而言，任何一款APP都不可能只支持最新iOS版本，如果你的APP以前只有一个颜色模式，按照苹果指导的方式适配即可。但是如果原来就有黑白两种模式的话，适配起来就会变得困难。因此PZTheme旨在通过一套代码去适配iOS13的暗黑模式和iOS13以下自定义的黑白模式。

## 使用介绍
### 引入方式
```
pod 'PZTheme', '~> 0.1'
```

### PZObject
通过Runtime方式给NSObject添加了一个名为pz的PZObject对象（pz可以视为NSObject的一个助理，其生命周期与NSObject保持一致）。PZObject主要支持下面两个方法：

```
- (T)customize:(void(^)(T x))block;

- (void)handleTheme:(void(^)(T x))block;
```

customize 方法主要完成NSObject初始化之后自身定制化工作，该方法只会执行一次。customize本身没有什么特性逻辑，其实质上一个语法糖，借鉴于L闭包的概念，使代码更加清晰，CV操作更方便。同时返回NSObject自身，使其能达到链式表达的效果。customize方法使用示例如下：

```
_btnNext = [[UIButton new].pz customize:^(UIButton *btn) {
    btn.frame = CGRectMake(100, 200, 127, 53);
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [btn addTarget:self action:@selector(jumpNext:) forControlEvents:UIControlEventTouchUpInside];
}];
[self.view addSubview:_btnNext];
```

handleTheme方法则实现动态切换的关键，助理pz会为NSObject保存这个block，在执行时先默认调用一次，后面收到特定的NSNotification会再次调用这个block，从而达到动态切换效果。实际上，按照这种模式你还可以定义出handleTheme2，handleTheme3的方法来对应不同NSNotification来实现任何需要动态切换场景，比如切换字体大小等。handleTheme的使用示例如下

```
[_btnNext.pz handleTheme:^(UIButton *btn) {
    [btn setBackgroundImage:kThemeImagePicker(@"bg") forState:UIControlStateNormal];
    [btn setTitle:kThemeObjectPicker(@"明亮模式",@"暗黑模式") forState:UIControlStateNormal];
    [btn setTitleColor:kThemeColorPicker([UIColor blackColor],[UIColor whiteColor]) forState:UIControlStateNormal];
}];
```
### PZTheme
PZTheme是一个单例模式，有一个自身的theme属性来控制黑白样式（该属性只在iOS13以下系统中才有实际意义），该属性改变时会发对对应的NSNotification去触发handleTheme。PZTheme主要通过以下宏定义来控制对应样式的目标选择。

```
#define kThemePicker(light,dark)                ([PZTheme sharedInstance].theme==PZThemeStyle_Dark?dark:light)
#define kThemeObjectPicker(lightObj,darkObj)    ([PZTheme objectForLight:(lightObj) dark:(darkObj)])
#define kThemeColorPicker(lightColor,darkColor) ([PZTheme colorForLight:(lightColor) dark:(darkColor)])
#define kThemeImagePicker(imgName)              ([PZTheme imageNamed:imgName])
```

另外PZTheme在iOS13中，屏蔽了NSNotification的发送，通过苹果提供给colorWithDynamicProvider等方式去适配iOS13的主题。
（这里也可以考虑完全使用handleTheme，在监听traitCollection变化后去发出NSNotification达到动态切换的目的，可以做到完全不依赖苹果iOS 13的新方法。这种方式在Demo中暂未去实现。）

## 补充说明
目前方案中，只考虑整个APP所有界面都是同时支持黑白样式的，并没有考虑单独某个界面定制为固定的暗黑或者明亮模式。后续版本将会支持单个VC的定制化功能。
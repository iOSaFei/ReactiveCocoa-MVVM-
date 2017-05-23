# ReactiveCocoa+MVVM实践篇
### 实现一个完整的登陆界面

效果如下：
![Alt text](./屏幕快照 2017-05-23 下午11.39.39.png)
看到QQ现在的登陆界面自己也想抄袭一下，背景用几张图片合成了一个Gif动画，但是清晰度不够，QQ的背景视频应该是视频合成的Gif。我的这个效果不是那么的好。

### 一、项目目的：
1、练习使用MVVM+RAC写项目；
2、重构自己之前的代码；

### 二、项目技术：
使用MVVM的架构并结合ReactiveCocoa；
自定登陆框WFTextField，结合CAShapelayer、贝塞尔曲线实现波浪动画，并使用策略模式初步验证输入内容。

### 三、项目步骤：
1、使用cocoapod导入必要的第三方库：
```
#ifndef WZXYHeader_h
#define WZXYHeader_h

#import <SVProgressHUD/SVProgressHUD.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>

#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define kWindowWidth ([[UIScreen mainScreen] bounds].size.width)
#define kWindowHeight ([[UIScreen mainScreen] bounds].size.height)

#define MainColor ([UIColor colorWithRed:61/255.0 green:137/255.0 blue:222/255.0 alpha:1.0])

#endif /* WZXYHeader_h */
```

2、V的构建（具体的下载Demo）
```
 [self wf_setUpViews];
 [self wf_makeConstraints];
 [self wf_requestData];
 [self wf_makeAnimations];
```

3、VM和M的构建、这里和上篇文章的讲的一致，采用了双向绑定，Model变化-ViewModel自动变化-View更新。这里没有在AFNetworking上封装一层、项目中一般需要、添加一些公共的设置，这里思路还是将每个网络请求封装成一个类。这里是在Model请求了验证码并更新了NSDictionary，在ViewModel取出了URL的字符串给V使用。

4、WFTextField的构造：
这个不是重点，只提几个重要的几点：1、添加一个CAShapeLayer，这个CAShapeLayer的path属性使用贝塞尔曲线的来设置，画一个直线型的贝塞尔曲线很简单。
使用：
```
[[self rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(id x){
        [self.superview addGestureRecognizer:_tapViewDown];
        [self wf_waveAnimation];
    }];
```
Rac的这个方法监听TextField的Begin事件，然后创建一个CABasicAnimation，这个动画很简单：动什么？ 动多久？ 从哪里？ 到哪里？
动path属性，动1.5秒，从原来的path，到后来的path，然后执行完后就回到原来的path（隐式动画）。
后来的path指定的是一个三元贝塞尔曲线，就是需要添加两个控制点，这里就不详细说了。

5、策略模式：
	首先创建一个抽象的策略，具体的验证策略在子类中实现。界面上一共三个TextFied，分别创建了三个策略，验证TextField输入是否合法，如学号是八位，如果不是八位就告诉用户。


### RAC使用的总结
这才是重点！
这里只是给出项目中用到的一些东西。

1、代替KVO：当观察的属性改变就可以通过下面的Block取得变化后的新值，这里获取到的是改变后的字符串temp。
```
[[_username rac_valuesAndChangesForKeyPath:@"illegalMessage" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(id x) {
        NSString *temp = [x[1] valueForKey:NSKeyValueChangeNewKey];
        [SVProgressHUD showErrorWithStatus:temp];
 }];
```

2、代替代理：一定要记住：它只能代替返回值为void的代理方法，我就栽倒这里过
```
 [[self rac_signalForSelector:@selector(textFieldDidBeginEditing:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^ (id x) {
        
  }];
```

3、代替target-action：
```
[[self rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(id x){
        [self.superview addGestureRecognizer:_tapViewDown];
        [self wf_waveAnimation];
    }];
```

4、代替通知：
```
[[NSNotificationCenter defaultCenter] postNotificationName:@"WZXY" object:object];

 [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"WZXY" object:nil] subscribeNext:^(NSNotification *notification) {
        NSLog(@"%@", notification.name);
        NSLog(@"%@", notification.object);
    }];
```

5、监听UITextField的文字改变：
```
    [self.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"TextField的文字改变了%@",x);
    }];
```

6、手势的RAC
```
    _tapViewDown = [[UITapGestureRecognizer alloc] init];
    _tapViewDown.cancelsTouchesInView = NO;
    [[_tapViewDown rac_gestureSignal] subscribeNext:^(id x) {
        [self resignFirstResponder];
    }];
```

7、宏定义：这段代码的意思是当三个TextField的inputLegal属性都为@“legal”的时候Button才可以点击。
```
    RAC(self.loadButton,enabled) = [RACSignal combineLatest:@[ RACObserve(self.username, inputLegal), RACObserve(self.password, inputLegal), RACObserve(self.vercode, inputLegal)]
    reduce:^id(NSString* usernameLegal, NSString* passwordLegal, NSString* vercodeLegal ){
        
        return @([usernameLegal isEqualToString:@"legal"] && [passwordLegal isEqualToString:@"legal"] && [vercodeLegal isEqualToString:@"legal"]);
    }];
```
这段代码解析：
```RAC(self.loadButton,enabled)```给Button的enabled的属性绑定一个信号，信号改变则属性改变。

```RACObserve(self.username, inputLegal)```监听TextField的属性，返回的是信号。

```combineLatest```将多个信号合并起来，每个信号至少都有过一次sendNext，才会触发合并的信号。

```reduce```把信号发出元组的值聚合成一个值

如果要想深入学习：https://kevinhm.gitbooks.io/functionalreactiveprogrammingonios/ 拿去不谢。

把复杂留给自己，把简洁留给他人。



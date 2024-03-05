## dart入门

这不是一个纯粹的教程，这是我学习dart时记录下来的要点或难理解的知识点，作为笔记使用。
大家可以综合参考官方教程和我的学习笔记作为学习资料，官方教程在这里 https://dart.cn/language

本研究项目的章节和教程一致。学习研究时对比java特性比较多。

因为dart的官方教程过于简陋也比较跳跃，而且大多是英文，所以在这里把重要一些的概念和知识点弄清楚。



### 1. dart sdk的安装

#### 1.1 windows

有点忘了是安装flutter顺带装的还是单独装的。使用了choco命令安装的，忘了choco是什么时候装的，但是能用就好。自动安装在c:/tools/dart-sdk。


操作参照 https://dart.cn/tools/jetbrains-plugin

#### 1.2 mac

目前没有在mac上操作，先不搞。

### 2. 在intellij idea中运行第一个程序：helloWorld 

在intellij idea中安装dart插件，配置之前的路径c:/tools/dart-sdk作为dart sdk path。

打开idea-->new project--dart，输入项目名称dartStudy，选择命令行程序。idea为我们自动生成了pubspec.yaml和bin/dartstudy.dart文件。

在.dart文件中有一段hello world程序，点击文件右键run，可以看到控制台打印出了“Hello, World!”。

~~~dart
void main() {
  print('Hello, World!');
}
~~~

### 3. dart开发语言基础

不一一列出，基本上dart和typeScript很类似。只有在需要注意或者需要深入一点研究的时候才在这里列出。


#### 3.1 变量

##### 空安全

java或其它语言中的空指针异常在dart中不会出现。Dart的编译器禁止这些操作。所以Dart应用程序不会引发运行时错误。

变量可空。

##### 延迟初始化变量

late 修饰符有两种用法：

* 声明一个非空变量，但不在声明时初始化。

* 延迟初始化一个变量。

这和java在定义类变量时不赋值意思差不多。

#### 3.2 操作符

##### 赋值操作符

仅对值为null的变量赋值用？？=赋值，类似如：
```dart
// Assign value to a
a = value;
// Assign value to b if b is null; otherwise, b stays the same
b ??= value;
```
只有b为null时才赋值，否则b的值保持不变。

##### 算术运算

~/	除法，返回整数结果，如：
```dart
assert(5 ~/ 2 == 2); //取5/2结果的整数部分
```



##### as、is和运算is!操作符

 * as：类型转换，如(employee as Person).firstName = 'Bob';
 * is：如果对象具有指定类型，则为 True ，如：employee is Person
 * is!：如果对象没有指定的类型，则为 True，可视为is操作的非操作

##### 级联表达式
通过..或者?..对同一个对象(不是简单类型哦)进行多次方法或属性的调用：
```dart
var paint = Paint()
  ..color = Colors.black
  ..strokeCap = StrokeCap.round
  ..strokeWidth = 5.0;
```
等同于：
```dart
var paint = Paint();
paint.color = Colors.black;
paint.strokeCap = StrokeCap.round;
paint.strokeWidth = 5.0;
```

嵌套级联：
```dart
//伪代码
final addressBook = (AddressBookBuilder()
      ..name = 'jenny'
      ..email = 'jenny@example.com'
      ..phone = (PhoneNumberBuilder()
            ..number = '415-555-0100'
            ..label = 'home')
          .build())
    .build();
```
严格来说，级联的“双点”符号不是运算符。它只是 Dart 语法的一部分。

#### 3.3. 注释

跟java比多了一个///注释。它注释单行时相当于单行注释，用在连续多行时就相当于/**注释，比较灵活。

#### 3.4 metadata

元数据，与java的注解类似，但是有不同的作用，在以后的使用时积累和注意。

#### 3.5 Libraries & imports

导入库，如
```dart
import 'dart:html';
import 'package:test/test.dart';
import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;
// Import only foo.
import 'package:lib1/lib1.dart' show foo;

// Import all names EXCEPT foo.
import 'package:lib2/lib2.dart' hide foo;

//deferred means lazy import
import 'package:greetings/hello.dart' deferred as hello;
// Uses Element from lib1.
Element element1 = Element();

// Uses Element from lib2.
lib2.Element element2 = lib2.Element();
```

### 4. 类型

java将类型分为基本数据类型和对象类型，dart没有基本数据类型，它的内置类型(built-in types)都是对象类型。

dart支持如下类型：

* Numbers (int, double)，没有float，带小数点的字面量就是double
* Strings (String),单或双引号使用字面量，单或双的三引号创建多行字符串，原始字符串，字面量中使用变量
* Booleans (bool)
* Records ((value1, value2))
* Lists (List, also known as arrays)
* Sets (Set)
* Maps (Map)
* Runes (Runes; often replaced by the characters API)
* Symbols (Symbol)
* The value null (Null)

#### 4.1 Numbers

跟java比没有float，只有int和double。然而int和float在java中是基本数据类型，不是对象类型所以不具备成员方法。
而在dart中则不是，它们都继承自num类(或接口)，类似于java中的Integer和Double类。
它们可以调用类型上的方法，比如int.parse("4")。

```dart
    var x = 1;
    var hex = 0xDEADBEEF;
    var y = 1.1;
    var exponents = 1.42e5;
    num x = 1; // x can have both int and double values
    x += 2.5;
    double z = 1; // Equivalent to double z = 1.0.
    // String -> int
    var one = int.parse('1');
    assert(one == 1);
    
    // String -> double
    var onePointOne = double.parse('1.1');
    assert(onePointOne == 1.1);
    
    // int -> String
    String oneAsString = 1.toString();
    assert(oneAsString == '1');
    
    // double -> String
    String piAsString = 3.14159.toStringAsFixed(2);
    assert(piAsString == '3.14');
```

#### 4.2 Strings

相等用==判断，而不是java中的equals方法。



```dart
var s1 = 'Single quotes work well for string literals.';
var s2 = "Double quotes work just as well.";
var s3 = 'It\'s easy to escape the string delimiter.';
var s4 = "It's even easier to use the other delimiter.";
```

可以在字面量中使用${expression}插入变量值，expression可以是非字符串类型。如果expression是个变量(即不是计算值)，连{}都可以省略。
```dart
  var s = 'string interpolation';
  print('Dart has $s, which is very handy.');
```
相邻的字符串连接可以使用+也可以不使用。
```dart
var s1 = 'String '
    'concatenation'
    " works even over line breaks.";
assert(s1 ==
    'String concatenation works even over '
        'line breaks.');

var s2 = 'The + operator ' + 'works, as well.';
assert(s2 == 'The + operator works, as well.');
```
要创建多行字符串，请使用带有单引号或双引号的三引号：
```dart
var s1 = '''
You can create
multi-line strings like this one.
''';

var s2 = """This is also a
multi-line string.""";
```
您可以通过添加前缀来创建“原始”字符串r：
```dart
//原始字符串不会被转义
var s = r'In a raw string, not even \n gets special treatment.';
```
字符串变量变量不能连接为字符串常量：
```dart
// These work in a const string.
const aConstNum = 0;
const aConstBool = true;
const aConstString = 'a constant string';

// These do NOT work in a const string.
var aNum = 0;
var aBool = true;
var aString = 'a string';
const aConstList = [1, 2, 3];

const validConstString = '$aConstNum $aConstBool $aConstString';
// const invalidConstString = '$aNum $aBool $aString $aConstList';
```

#### 4.3 Booleans

bool,没什么好讲的

#### 4.4 Records

记录(Record)是括号里面用逗号分开的一些值，值可以像json一样命名，也可以不命名。记录的成员数量是固定的(fixed-sized)，
成员类型可以不同(heterogeneous),成员的类型不能变(typed)。
```dart
  var record0 = ('first', a: 2, b: true, 'last');
```
上面的代码声明并实例化了一个记录，实际上它的每个成员的类型都已经定了下来了，即String,int,bool,String，而且第二个和第三个成员分别命名为a和b。
你可以重新赋值，但必须按照同样的成员数量，类型以及命名重新赋值：
```dart
record1 =  ('firsts', a: 2, b: true, 'last');//重新赋值
```
我们也可以在申明变量时指定记录的类型：
```dart
//类型为(int,int)
(int,int) record2 = (11,22);
(int a,int b) record3 = (11,22);//a,b只是给位置命了个名，似乎没什么意义
//错误示范，('firsts', a: 2, b: true, 'last')类型不是(String,int,bool,String):
(String,int,bool,String) record4 = ('firsts', a: 2, b: true, 'last');
```

##### 4.4.1 带命名成员的记录的类型

如果记录中的成员被命名，它们会被移到位置的最后面，变为一个json。上面的错误例子中，a和b移到最后成了{int a, bool b}这种类型，所以声明它类型的代码
应该如下：
```dart
(String, String, {int a, bool b}) record5=('first', a: 2, b: true, 'last');
```
##### 4.4.2 访问记录的成员(Record fields)

前面说了命名的成员(字段)被移到最后构成了一个json，所以未命名的成员的实际位置下表是重新排序后的下表，要获得它们的值，示例如下：
```dart
print(record5.$1); // Prints 'first'
print(record5.a); // Prints 2
print(record5.b); // Prints true
print(record5.$2); // Prints 'last'
```
##### 4.4.3 记录的类型(Record types)

5.1中有过研究了。没有针对单个记录类型的类型声明。记录是基于其字段的类型进行结构化的。记录的形状(字段的集合、字段的类型和它们的名称，如果有的话)唯一地决定了记录的类型。
记录中的每个字段都有自己的类型。同一记录中的字段类型可以不同。无论从记录中访问哪个字段，类型系统都知道每个字段的类型:
```dart
(num, Object) pair = (42, 'a');

var first = pair.$1; // Static type `num`, runtime type `int`.
var second = pair.$2; // Static type `Object`, runtime type `String`.
```

##### 4.4.4 Record equality

有相同的形状和值则相等(==)

所谓形状相同，不但字段的顺序、类型、值要相同，其包含的json的命名也要相同。但是声明类型时作为给位置命名的形参可以不相同。

```dart
(int x, int y, int z) point1 = (1, 2, 3);
(int r, int g, int b) color1 = (1, 2, 3);

print(point1 == color1); // Prints 'true'.


({int x, int y, int z}) point2 = (x: 1, y: 2, z: 3);
({int r, int g, int b}) color2 = (r: 1, g: 2, b: 3);

print(point2 == color2); // Prints 'false'. Lint: Equals on unrelated types.
```
##### 4.4.5 解构

不太好用语言描述，看看下面这个例子，将函数的返回值赋值给2个变量：
```dart
    // Returns multiple values in a record:
    (String, int) userInfo(Map<String, dynamic> json) {
      return (json['name'] as String, json['age'] as int);
    }
    
    final json = <String, dynamic>{
      'name': 'Dash',
      'age': 10,
      'color': 'blue',
    };
    
    // Destructures using a record pattern:
    var (name, age) = userInfo(json);
    
    /* Equivalent to:
      var info = userInfo(json);
      var name = info.$1;
      var age  = info.$2;
    */
```

##### 4.4.6 思考：记录做什么用比较合适

5.5中让一个函数返回多个值的例子是个不错的应用场景。

另外数据库中查询到的值是否用记录封装也是比较合适的场景呢？

我想可以吧，记录从字面上理解就是为了记录单条数据，表单数据等用的，而集合则是记录多条记录用的。

只是粗浅的思考。


#### 4.2 集合(Collections)

Dart has built-in support for list, set, and map collections。

我想dart应该倾向于认为集合中的每一个元素都具有相同类型，这样想能够理解为什么dart会推测集合的泛型类型。

##### 4.2.1 lists

和java的List不一样，dart的list语法上更像数组，但却又有java list的一些特性，如泛型。

因为学习目的只是快速入门，所以看代码学习最直观：

```dart
    var list = [
      'Car',
      'Boat',
      'Plane',
    ];
```
```dart
    var list = [1, 2, 3];
    assert(list.length == 3);
    assert(list[1] == 2);
    
    list[1] = 1;
    assert(list[1] == 1);
```
```dart
var constantList = const [1, 2, 3];
// constantList[1] = 1; // This line will cause an error.
```

##### 4.2.2 sets

无序不重复集合，这和java相同。

```dart
  var names = <String>{};
  // Set<String> names = {}; // This works, too.
  // var names = {}; // Creates a map, not a set.
```
注意：用字面量初始化空的Set变量和空的Map变量都是用一对花括号{}，所以dart如何确定它的运行时实际类型呢？答案是Map，因为Map优先。
这在使用中应该很容易解决，Set泛型类型只有一个，而Map则有key和value两个泛型类型。

一些Set的用法示例：
```dart
    var elements = <String>{};
    elements.add('fluorine');
    elements.addAll(halogens);
    assert(elements.length == 5);
    final constantSet = const {
      'fluorine',
      'chlorine',
      'bromine',
      'iodine',
      'astatine',
    };
    // constantSet.add('helium'); // This line will cause an error.
```
##### 4.2.3 maps

```dart
var gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings'
};

var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};

var gifts = Map<String, String>();//在Dart中，new关键字是可选的
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';
assert(gifts.length == 2);
//var nobleGases = Map<int, String>();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';
```
##### 4.2.4 集合的操作

###### 4.2.4.1 Spread operators

谷歌翻译为“价差运算符”，我不知道准不准确。它是用3个点(...)连接两个同类型集合(list,set,map)。

```dart
    var list = [1, 2, 3];
    var list2 = [0, ...list];
    assert(list2.length == 4);
```

###### 4.2.4.2 Control-flow operators

流程控制操作符，有if和for两种。

```dart
      var promoActive = true;
      var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
      print(nav);//[Home, Furniture, Plants, Outlet]
      promoActive= false;
      nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
      print(nav);//[Home, Furniture, Plants]

      var login = 'Manager';
      nav = ['Home', 'Furniture', 'Plants', if (login case 'Manager') 'Inventory'];
      print(nav);//[Home, Furniture, Plants, Inventory]
      login='staff';
      nav = ['Home', 'Furniture', 'Plants', if (login case 'Manager') 'Inventory'];
      print(nav);//[Home, Furniture, Plants]
```
疑问：else条件支持吗？

```dart
    var listOfInts = [1, 2, 3];
    var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
    assert(listOfStrings[1] == '#1');
```
#### 4.3. 泛型

dart的泛型似乎设计得比java的要好，因为java的泛型是编译时现象，在虚拟机中并不存在泛型这个东西，造成了很多理解上的困扰。
比如用反射就不能直接得到泛型类的参数类型。

粗略看了一遍，发现在使用上，dart的泛型似乎与java差异不大，所以不过多研究了。

#### 4.4. 类型定义(typedef,别名)

类型别名（通常称为typedef，因为它是用关键字声明的typedef）是一种引用类型的简洁方式。

在其它语言中没见过这东西，可增加代码的简洁度和可读性，而且也挺简单的，看代码就明白了。
```dart
    typedef IntList = List<int>;
    IntList il = [1, 2, 3];
    
    typedef ListMapper<X> = Map<X, List<X>>;
    Map<String, List<String>> m1 = {}; // Verbose.
    ListMapper<String> m2 = {}; // Same thing but shorter and clearer.

```
#### 4.5. Dart 语言里的类型体系

动态分配，类型推断，静态类型检查和运行时检查等。不申明变量类型的语言需要的手段。

### 5. 模式匹配

#### 5.1 一些概念

模式：一组值的形状。所谓形状，在之前的集合中有过提及。

解构：把一组值分别赋值到不同变量。


#### 5.2 理解模式

虽然在dart中2个或以上的值才有匹配的意义，但是我们在心里可以认为单个值也可以算最简单的模式：

```dart
    ///最简单的声明变量就可以认为是一种模式，虽然没意义。它的模式就是a。
    ///如何理解呢？就是一个值的形状。
    var a = 'b';


    ///再看看下面的代码，这个常量1也是一个模式，不过这中模式会给我理解模式造成一点点困扰
    var number = 1;
    switch (number) {
      // Constant pattern matches if 1 == number.
      case 1:
        print('one');
    }
```

我想，匹配就是要解决集合中变量相关的一些问题，所以单个值的变量不是dart的匹配要做的事情，不过常量除外。

再复杂一丢丢，2个变量：
```dart
///对java来说是很新颖的赋值方式，不用指定类型为List,还给两个元素定义了变量名。
  var [a,b] = [1,2];
```
这就是一个有意义的模式了，[a,b]就是模式。

我们知道，方括号是dart中的List。所以上面的模式表示一种形状，即2个元素的列表，变量名分别为a和b。

结合常量模式,我们是不是认为下面也是一种模式呢？我尝试着写了如下代码：
```dart
///我的原意是搞出一个模式，列表第一个是常量1，但是编译器给出了错误，信息是
///Refutable patterns can't be used in an irrefutable context.
///Try using an if-case, a 'switch' statement, or a 'switch' expression instead.
///意思是：可辩驳模式不能在不可辩驳的上下文中使用。并让我在if-case, a 'switch' statement, or a 'switch'中使用。
///Refutable patterns不明觉厉，我看看下面的学习是否能给我启示
 var[1,a,b] = [1,2,3];
```

下面有个更好理解模式的例子：
```dart
    const a = 'a';
    const b = 'b';
    switch (obj) {
      // List pattern [a, b] matches obj first if obj is a list with two fields,
      // then if its fields match the constant subpatterns 'a' and 'b'.
      case [a, b]:
        print('$a, $b');
    }
```
在Java中case后面接一个常量或值，在dart里，用了[a,b]这个模式。突然脑经一转，前面看到的Refutable patterns是不是在这里能用呢？

试了下：
```dart
      const a = 'a';
      const b = 'b';
      var obj = [1,a,b];
      switch (obj) {
        case [1,a, b]:
          print('$a, $b');
      }
```
it works!!所以[1,a, b]这种常量结合变量的模式是合法的，只不过不能拿来声明变量。

现在大概能理解，所谓形状，包含了类型，如[]为List，{}为Map或Set，还包含了元素的变量名，如果是常量就是常量的值，
也隐式的包含了元素的数量，即形状中变量和常量的总数。

模式可以出现在：

* Local variable declarations and assignments
* for and for-in loops
* if-case and switch-case
* Control flow in collection literals


#### 5.3 解构(Destructuring)

当对象和模式匹配时，模式可以访问对象的数据并将其部分提取。换句话说，该模式解构了对象：
```dart
    var numList = [1, 2, 3];
    // List pattern [a, b, c] destructures the three elements from numList...
    var [a, b, c] = numList;
    // ...and assigns them to new variables.
    print(a + b + c);
```

下面这个也叫解构：
```dart
    switch (list) {
      case ['a' || 'b', var c]:
        print(c);
    }
```
在case后面接的模式中'a' || 'b'也构成形状的一部分，表示值是'a'或'b'，而var c则给第三个元素赋值给了变量c。

#### 5.4 赋值
```dart
    var (a, b) = ('left', 'right');
    (b, a) = (a, b); // Swap.
    print('$a $b'); // Prints "right left".
```
上面(b,a)是一个不同于(a,b)的新模式，模式是不需要声明的，变量才需要。

#### 5.5 switch中的模式

看代码，就不解释了：
```dart
switch (obj) {
  // Matches if 1 == obj.
  case 1:
    print('one');

  // Matches if the value of obj is between the
  // constant values of 'first' and 'last'.
  case >= first && <= last:
    print('in range');

  // Matches if obj is a record with two fields,
  // then assigns the fields to 'a' and 'b'.
  case (var a, var b):
    print('a = $a, b = $b');

  default:
}
```

下面这个还看不懂，dart的官方教程有点跳跃，知识点还没讲到就给我例子：
```dart
    var isPrimary = switch (color) {
      Color.red || Color.yellow || Color.blue => true,
      _ => false
    };
```

#### 5.6 for 和 for-in 循环

dart官网用到了MapEntry对象，说实在的有点跳跃，但是不得不去参考java的MapEntry强行理解了一下，先看代码：
```dart
    Map<String, int> hist = {
      'a': 23,
      'b': 100,
    };
    
    for (var MapEntry(key: key, value: count) in hist.entries) {
      print('$key occurred $count times');
    }
```
重点在var MapEntry(key: key, value: count)这里。这应该是在循环中将hist.entries获得的一个MapEntry赋值给了一个模式，
这个模式就是MapEntry(key: key, value: count)。

模式括号里，冒号左边的key和value是关键字吗?不是的，它是调用了该MapEntry的key和value的getter方法。冒号右边的key和count才是变量名。

前面的例子里，模式包含的类型是通过[]，{}或者别的字面量确定，这里直接指定类型，也算是模式的一种表达法吧。

现在就好理解了，print语句中解构了两个变量(可能不是这样表达，你懂就行^_^)。

另外dart中getter方法若和变量名相同，可以这样赋值：
```dart
///简化key: key为:key。
    for (var MapEntry(:key, value: count) in hist.entries) {
      print('$key occurred $count times');
    }
```
#### 5.7 模式的用例

模式应该挺有用的，但是我不太像说太多了，看看代码都可以明白，就只贴代码了。

```dart

///Destructuring multiple returns

var info = userInfo(json);
//啰嗦
var name = info.$1;
var age = info.$2;
//简单
var (name, age) = userInfo(json);


///Destructuring class instances
final Foo myFoo = Foo(one: 'one', two: 2);
var Foo(:one, :two) = myFoo;
print('one $one, two $two');


///Algebraic data types，跳跃内容目前不懂
sealed class Shape {}

class Square implements Shape {
  final double length;
  Square(this.length);
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);
}

double calculateArea(Shape shape) => switch (shape) {
      Square(length: var l) => l * l,
      Circle(radius: var r) => math.pi * r * r
    };




///Validating incoming JSON
var json = {
  'user': ['Lily', 13]
};
var {'user': [name, age]} = json;
if (json case {'user': [String name, int age]}) {
  print('User $name is $age years old.');
}
//如果没有模式，代码将如下面般恐怖：
if (json is Map<String, Object?> &&
    json.length == 1 &&
    json.containsKey('user')) {
  var user = json['user'];
  if (user is List<Object> &&
      user.length == 2 &&
      user[0] is String &&
      user[1] is int) {
    var name = user[0] as String;
    var age = user[1] as int;
    print('User $name is $age years old.');
  }
}
```
#### 5.8 模式匹配类型

##### 5.8.1 优先级
略
##### 5.8.2 类型转换

```dart
(num, Object) record = (1, 's');
var (i as int, s as String) = record;
```

##### 5.8.3 Null-check

chrome的翻译真是糟糕，下面这一段我看了很久并结合代码才搞明白：

Null-check patterns match first if the value is not null, and then match the inner pattern against that same value. 
They let you bind a variable whose type is the non-nullable base type of the nullable value being matched.

To treat null values as match failures without throwing, use the null-check pattern.

我加了一句打印语句，便于观察结果：
```dart
String? maybeString = 'nullable with base type String';
switch (maybeString) {
  case var s?:print(s);
  // 's' has type non-nullable String here.
}
```
没有意外，打印了nullable with base type String。把代码改改，String? maybeString = null;控制台没有打印，说明模式没有匹配。
就是说s?这个模式只对非空值有效，就如上面英文说的Null-check patterns match first if the value is not null,空检查模式先匹配非空值，
然后才把值赋值给s。如果值为空则不匹配。如果想case一个null的模式，就要加一句case null:print('it is null');

稍微多说一句，?也是模式的一部分,应该就叫subpattern吧。

##### 5.8.3 Null-assert

用我粗浅的英语看了一下，这个模式允许含有空值的对象流入，但是对象中含有空的值(field)，或者一个集合中的一个元素是null,并且要和模式去匹配时，模式会扔掉(throw)它。

```dart
List<String?> row = ['user', null];
switch (row) {
  case ['user', var name!]: // ...
  // 'name' is a non-nullable string here.
  //在变量后面加个!暂时不知道什么操作，是取反值吗？但是现在模式要把null赋值给name是模式不允许的，模式会忽略
  //后来看了一下操作符这一节，!放在表达式后面应该叫空断言运算符，在这里它断言name不为空。
}
```
还有很多，不想一一列出了，在这里看 https://dart.cn/language/pattern-types

### 6. 函数（Functions）


函数实际上是一个Function对象。

对于仅包含一个表达式的函数，您可以使用一种简写语法：
```dart
  bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
```

 => expr 是 { return expr; }的简写。=> 有时被称为箭头语法。
 
 函数可以省略返回值。
 
 一个函数可以有任意数量的所需位置参数。这些参数之后可以是命名参数，也可以是可选的位置参数(但不能两者都有)。
 
 在向函数传递参数或定义函数形参时，可以使用尾随逗号。

#### 6.1 命名参数

https://dart.cn/language/functions

java中，所有方法的签名必须有形参的类型和名称，比如一个java中的方法可能是这样：
```java
//firstName和lastName是两个形参的名字，在java中是必须的
 public String fullName(String firstName,String lastName){...}
```
在dart中，定义函数的参数也可以像java一样，而且还可以用?进行非空检查，即调用时传入null函数不会被调用：
```dart
/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool? bold, bool? hidden}) {...}
```
注意，定义函数的参数外面是被花括号括起来的，不表示它是一个Map或Set，而是dart定义函数命名参数的语法要求，
所有的命名参数都写在花括号内。所以在调用时不要误认为它是需要一个Map而传入一个Map:
```dart
//正确
enableFlags(bold: true, hidden: false);
//只传一个参数也是对的
enableFlags(bold: true);
//错误
enableFlags({bold: true, hidden: false});
```
小提示：在模式中的非空检查"?"和这里的"?"操作符不是一回事，模式中表示这个子模式为空则不检查，而这里表示参数可以为空。
这个问题如果有时间可以仔细看看操作符一节（https://dart.cn/language/operators），不过我比较懒，准备碰到问题再去研究。

可以定义函数参数的默认值：
```dart
void enableFlags({bool bold = false, bool hidden = false}) {...}
```

用关键字required定义函数参数，表示强制参数是必须的：
```dart
//这是文档上的例子，我有点疑惑怎么可以这样定义，这个const想搞什么，怎么没有方法体。
const Scrollbar({super.key, required Widget child});
```

#### 6.2 位置参数

基于该文档一贯的跳跃思维作风，文档中没有特别介绍和定义位置参数，可能觉得太简单了吧。但是我觉得应该指出一下。

前面我们看到花括号用来指定命名参数，在调用时也要指定参数名字。这不比以啰嗦闻名的java更啰嗦了吗？当然不是，
你可以定义java那种风格的函数，在函数的参数列表的圆括号里不把参数放在花括号里，就成了位置参数.
我改写了一下上面的例子：
```dart
void enableFlags(String description,{bool? bold=true, bool? hidden=false}) {
  if(bold!=null&&bold){
    print('bold');
  }else print('not bold');
  if(hidden!=null&&hidden){
    print('hidden');
  }else print('not hidden');
  print(description);
}
```
String description占据了参数列表的第一个位置，在调用时第一个参数必须是传入一个字符串，但不必指明函数定义的参数名称。

我尝试在调用函数时把位置参数写在命名参数后面，程序没问题：
```dart
//在调用时位置参数可以放在命名参数后面
enableFlags(bold: true, hidden: true,'bold and hidden',);
```
但是在定义函数时，位置参数就不能放命名参数后面了：
```dart
///结尾在花括号处出现错误提示为Expected to find ')'.
///表示dart期望在花括号后面结束参数，即表示命名参数需要在参数列表的最后面
void enableFlags({bool? bold=true, bool? hidden=false},String description,) {...}
```

#### 6.3 可选位置参数

不管是位置参数还是命名参数，在调用时都必须传入值。而可选位置参数则可传也可不传。可选位置参数用方括号[]括起来，
并且它们的默认值是null。
```dart
String say(String from, String msg, [String? device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
```
调用该函数：
```dart
assert(say('Bob', 'Howdy') == 'Bob says Howdy');
assert(say('Bob', 'Howdy', 'smoke signal') ==
    'Bob says Howdy with a smoke signal');
```
思考：如果同时有可选位置参数和命名参数，dart会不会造成混淆呢？我认定应该不会，我也不会去研究了，要相信dart设计者的智商。

#### 6.4 main() 函数

程序的入口函数，其实它定义了List<String>类型的可选参数。目前我使用的intellij idea无法点进去看main函数的定义代码。

#### 6.5 Functions as first-class objects

chrome翻译为“作为一流对象的功能”，我想应该是“作为一级对象的函数”。


函数可以作为参数传递给另一个函数，文档给了一个例子：
```dart
void printElement(int element) {
  print(element);
}

var list = [1, 2, 3];

// Pass printElement as a parameter.
list.forEach(printElement);
```

比较遗憾，之前并没有学习list的forEach方法的用法，我很好奇printElement是怎么知道传入的参数就是list迭代到的值呢？

好在我在api文档上
https://api.dart.dev/stable/3.3.0/dart-core/Iterable/forEach.html 找到了List的forEach实现，如下：
```dart
void forEach(void action(E element)) {
  for (E element in this) action(element);
}
```
对于习惯java语法的我来说，我愣是看了半天没看懂。根据刚学的知识，很明显void action(E element)是forEach方法定义的位置参数，
类型是void，action是形参名吗？为什么形参还可以带个参数E element呢？算了不研究了，时间紧要，留个念想吧。

我们可以把函数赋值给一个变量：
```dart
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') == '!!! HELLO !!!');
```
这样函数就是匿名的了。关于这个下小节会讲更多。

#### 6.6 匿名函数(Anonymous functions)

匿名函数，有时也称为lambda或闭包。

匿名函数这样声明：
```text
([[Type] param1[, …]]) {
  codeBlock;
};
```

##### 6.6.1 研究下List.map先

后面的例子用到了List的map方法，所以先研究一下API，地址在这里： 

https://api.dart.cn/stable/3.3.0/dart-core/Iterable/map.html

方法签名：
```dart
Iterable<T> map<T>(
    T toElement(
      E e
    )
)
```
下面是api的翻译加上我的注释，我的注释放在括号里。
```text
这个可迭代对象的当前元素(E e)被toElement修改。
返回一个新的lazy Iterable，其中的元素是通过按迭代顺序对该Iterable的每个元素调用toElement创建的。

返回的可迭代对象是惰性的，所以它不会迭代这个可迭代对象的元素，直到它自己被迭代(比如forEach被调用)，
然后它将应用toElement(toElement是一个函数)来一次创建一个元素。
转换后的元素不会被缓存。

对返回的Iterable进行多次迭代将在每次迭代中对每个元素调用一次提供的toElement函数。

返回的可迭代对象上的方法可以在不需要结果的任何元素上省略调用toElement。
例如，elementAt只能调用一次toElement。
```

这里要理解的是参数。map方法要求我们传入一个函数toElement，这个函数参数是E类型的。E和T类型之间有什么关系吗？
我们查看List的定义，它是List<E> class，所以E是List的元素类型。而T则是另一种类型。所以map方法可以返回一个另外一个泛型类型的List<T>。

理解了API，我们使用map方法时就不能随便传一个函数，函数的参数的类型是List的元素类型E，函数的返回值类型是你想要的类型T。

##### 6.6.2 使用示例

```dart
const list = ['apples', 'bananas', 'oranges'];
list.map((item) {
  return item.toUpperCase();
}).forEach((item) {
  print('$item: ${item.length}');
});
```
这个例子里，map方法和forEach方法分别传入了匿名函数。不过这个例子不太助于我们理解刚学过的api，我把它改一改：
```dart
  const list = ['apples', 'bananas', 'oranges'];
  list.map((item) {
    return item.length;
  }).forEach((item) {
    print('$item *2=${item*2}');
  });

```
现在再来分析一下。map方法传入了一个匿名函数，它的参数item必须是和list元素一样的String类型。
我们知道map方法返回一个由匿名函数返回类型决定的新的List。我把代码改为return item.length，返回值类型变为了int，
那么map方法就返回一个List<int>。然后我们在这个新的List<int>调用forEach方法，这个时候传入forEach的匿名函数的参数item，
它的类型这个时候是int，所以可以使用乘法运算。

可以使用箭头函数简写代码：
```dart
list
    .map((item) => item.toUpperCase())
    .forEach((item) => print('$item: ${item.length}'));
```

##### 6.6.3 变量作用域 (Lexical scope)

Lexical是词汇的意思，但是我觉得这里应该是变量作用域。

和java一样，花括号里面的代码块包含的变量不会在它外面生效，但外面的可以在里面使用。

##### 6.6.4 闭包（Lexical closures）

如果看文档上的例子，你不会理解闭包。在网上找了一篇《深入理解 Dart Function & Closure》的文章，对我理解很有帮助，但解释得有点繁琐。
不如看我三言两语解释透彻。


我自己写了个例子：
```dart
void main() {

  var print1 = setDiscountToCal(0.8);
  print1(100);
  var print2 = setDiscountToCal(0.5);
  print1(50);
  print2(500);
}

Function setDiscountToCal(double discount){
  print('设置折扣为：$discount');
  var printCost = (int price){
    double cost = price*discount;
    print('当前商品价格：$price,折扣：${discount},折后价：$cost');
  };
  return printCost;
}
```
先弄清一下词汇作用域。最顶层的变量是total变量,setDiscountToCal函数和main函数。
我们只关注和闭包相关的作用域，setDiscountToCal内包含一个作用域，
它包括discount double型变量和printCost这个函数变量。在printCost函数内部也封闭了一个作用域，
包含变量 int price。

我们在main中调用setDiscountToCal(0.8)，实际上是将printCost这个函数赋值给了print1，
但是printCost函数用到了它上一级作用域setDiscountToCal中的变量discount。为了能让程序能够运行，
赋值给print1的函数必须要包含discount的信息。

再看看闭包的定义：
```text
闭包是一个函数对象，它可以访问其词法作用域中的变量，即使该函数在其原始作用域之外使用也是如此。
```
现在是不是一目了然了呢？这里闭包是一个函数对象，即printCost这个函数，它可以访问其词法作用域中的变量discount，
即使该函数main作用域中，也是如此。

##### 6.6.5 一个Java程序员对闭包的思考

闭包现象存在是一个合乎设计原则的东西吗？我的回答是no。当我们想抽取一个函数放入工具集的时候，你会发现这个函数跟它的环境耦合了，
无法成为一个纯函数。

##### 6.6.6 函数的相等性
```dart
void foo() {} // A top-level function

class A {
  static void bar() {} // A static method
  void baz() {} // An instance method
}

void main() {
  Function x;

  // Comparing top-level functions.
  x = foo;
  assert(foo == x);

  // Comparing static methods.
  x = A.bar;
  assert(A.bar == x);

  // Comparing instance methods.
  var v = A(); // Instance #1 of A
  var w = A(); // Instance #2 of A
  var y = w;
  x = w.baz;

  // These closures refer to the same instance (#2),
  // so they're equal.
  assert(y.baz == x);

  // These closures refer to different instances,
  // so they're unequal.
  assert(v.baz != w.baz);
}
```
不同实例的函数是不相等的。相等需要相同实例的同一个函数。

##### 6.6.7 返回值

所有函数都会返回一个值。如果未指定返回值，则该语句return null;将隐式附加到函数体中。

要在函数中返回多个值，请聚合记录中的值。
```dart
(String, int) foo() {
  return ('something', 42);
}
```
##### 6.6.8 计数器(Generators)
当您需要惰性地生成一系列值时，请考虑使用生成器函数。Dart内置支持两种生成器函数:
* 同步生成器:返回一个Iterable对象。
* 异步生成器:返回一个流对象。

要实现同步生成器函数，将函数体标记为sync*，并使用yield语句来传递值:
```dart
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}
```
要实现异步生成器函数，请将函数体标记为async*，并使用yield语句来传递值:
```dart
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}
```
官网的实例就这么简单，如果不解释估计没人知道它是干什么用的,不过解释也很简单：
```dart
void main() {
  print(naturalsTo(4));//(0, 1, 2, 3)

  print(naturalsTo(2)); // (0, 1)


}
```
如果您的生成器是递归的，您可以通过使用以下方法来提高其性能yield*：
```dart
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}
```
yield关键字是专门为计数器设计的(因为我在文档的关键字yield上点击直接跳到了这里)，从已经研究过的内容看，
它的作用是：把结果加入Iterable对象或流对象中。但是yield*似乎不是，因为yield* naturalsDownFrom(n - 1)这句代码如果按照这个理解，
是把一个Iterable<int>加入Iterable<int>对象中，是不是合并结果的意思呢？我做个测试：
```dart
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
//    yield* naturalsDownFrom(n - 1);
  yield* li;
  }
}
List<int> li=[-1,-2,-3];
```
打印结果是：(8, -1, -2, -3)，证实了我的想法正确。

yield它不同于return，一个函数中可以有多个yield。

异步的Stream是啥先不研究了，碰到问题再说。

### 7.控制流
控制流和模式结合很紧密，要先搞清模式这一章。

#### 7.1 循环

和别的语言控制流没啥区别，只说几点不一样的。

##### 7.1.1 Dart for循环内的闭包捕获索引的值
```dart
    var callbacks = [];
    for (var i = 0; i < 2; i++) {
      callbacks.add(() => print(i));
    }
    
    for (final c in callbacks) {
      c();
    }
```
结果按预期本就应该是0和1，不过据说在JavaScript中都会输出2，是因为js的陷阱。

##### 7.1.2 using an Iterable such as a list or set

用forEach循环可以便利Iterable，而且在循环之前可以用where方法进行条件筛选，如：
```dart
candidates
    .where((c) => c.yearsExperience >= 5)
    .forEach((c) => c.interview());
```
#### 7.2 条件

##### 7.2.1 if case语句

这个可以判断模式：
```dart
if (pair case [int x, int y]) return Point(x, y);
```
##### 7.2.1 switch语句
case匹配值和模式。其实值也是一个常量模式。

switch在case中一旦匹配就会在执行完case中的子句后跳到Switch块的最后，就是说它只会匹配一个case。
类似于if...else if...else。

可以用下划线“_”代替default:。default类似于else。

可以给一组case命名一个label,并使用continue label跳到这组case中。这和java中给for一个标签类似，用continue label或break label跳过指定的循环。 

```dart
  int age=66;
  String? x;
  switch(age){
    case(>0&&<3):
      x='$age years old is baby' ;
    case(>=3&&<=10):
      x='$age years old is kid';
    case(>10&&<18):
      x='$age years old is teenage';
    case(>18):
      print('$age years old is adult,and ');
      continue adult;
   adult:
    case(>=18&&<60):
     x='$age years old is yong person';
    case(>=60&&<150):
      x='$age years old is old person';
    case(>=150):
      x='$age years old is not a person';
  }
  print(x);
```
上面的代码跟我的期待有出入哦。我期待在continue adult后进入>=60&&<150匹配的case，打印出66 years old is old person，
然而打印的是66 years old is yong person。所以，continue adult进入adult case组后，不是和新的匹配进行and操作，
而是和新的case进行or操作。所以只要跳到adult，会无条件进入第一个case,即程序判断为>18||(>=20&&<60)。


##### 7.2.2 Switch表达式

通俗说就是让整个switch语句获取一个值，可以赋值给另一变量，可以打印，可以作为返回值。但是语句直接用switch开头就不是switch表达式，
而是switch语句。Switch表达式的核心是要返回一个值。


```dart
var x = switch (y) { ... };

print(switch (x) { ... });

return switch (x) { ... };
```
switch表达式跟switch语句比，可以简化一下写法，比如下面这个switch语句：
```dart
// Where slash, star, comma, semicolon, etc., are constant variables...
switch (charCode) {
  case slash || star || plus || minus: // Logical-or pattern
    token = operator(charCode);
  case comma || semicolon: // Logical-or pattern
    token = punctuation(charCode);
  case >= digit0 && <= digit9: // Relational and logical-and patterns
    token = number();
  default:
    throw FormatException('Invalid');
}
```
变成switch表达式后：
```dart
token = switch (charCode) {
  slash || star || plus || minus => operator(charCode),
  comma || semicolon => punctuation(charCode),
  >= digit0 && <= digit9 => number(),
  _ => throw FormatException('Invalid')
};
```
case关键字省略了，直接写模式，后面不带冒号(":")了。因为要返回一个值，变成了箭头语法。多个case之间用逗号分隔。
另外，所有的case要包含所有的情况，甚至连异常都要包括，异常写在defalut块里，而且必须用“_”写法

我的代码改为switch表达式如下：
```dart
  int age=66;
  String? x;
  x=switch(age){
    >0=&&<3=>
      '$age years old is baby' ,
    >=3&&<=10
      =>'$age years old is kid',
    (>10&&<18)
  =>'$age years old is teenage',
    (>=18&&<60)
  =>'$age years old is yong person',
    (>=60&&<150)
  =>'$age years old is old person',
    (>=150)
  =>'$age years old is not a person',
  _ => throw FormatException('Invalid')
  };
  print(x);

```
##### 7.2.3 Switch表达式的详尽性检查

前面说过，所有的case要包含所有的情况。这是用我自己的话说的，意思也是详尽性检查的意思。
这不是我提前学习的，我知道这个是因为编译器给了我错误提示，我不写_ => throw FormatException('Invalid')这句，提示如下：
“The type 'int' is not exhaustively matched by the switch cases since it doesn't match 'int()'.”。

还有，上面的age我填写一个负数，编译时错误就不存在了。但是会产生运行时错误,不过这个错误时我主动抛出的。我完全可以改为_ => 'bad age format'。

枚举如果漏了一条dart是知道的。还有一种用sealed修饰符修饰的类，它有确定数量的子类，也可以被详尽检查。

sealed类例子：
```dart
sealed class Shape {}

class Square implements Shape {
  final double length;
  Square(this.length);
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);
}

double calculateArea(Shape shape) => switch (shape) {
      Square(length: var l) => l * l,
      Circle(radius: var r) => math.pi * r * r
    };
```

Square(length: var l)和Circle(radius: var r)应该是类的模式吧。

##### 7.2.3 Guard clause

翻译为保护条款还是保护从句呢？从句吧。

```dart
// Switch statement:
switch (something) {
  case somePattern when some || boolean || expression:
    //             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Guard clause.
    body;
}

// Switch expression:
var value = switch (something) {
  somePattern when some || boolean || expression => body,
  //               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Guard clause.
}

// If-case statement:
if (something case somePattern when some || boolean || expression) {
  //                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Guard clause.
  body;
}
```
作用是不是相当于逻辑与操作呢？应该是吧，没道理不是，等碰到应用场景再说。case只能匹配模式，加上when就可以加入任何布尔表达式了。

### 8.错误处理

知识点不多，理解不难就随便记录下。

#### 8.1 异常

除了抛出异常，您还可以抛出任意对象：
```dart
  throw 'Out of llamas!';
```

因为抛出异常是一个表达式，所以您可以在 => 语句以及任何其他允许表达式的地方抛出异常：
```dart
void distanceTo(Point other) => throw UnimplementedError();
```
用on捕获异常(严格说on只是知道异常类型，后面的catch才叫真正的捕获吧)：
```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  buyMoreLlamas();
}
```

用catch捕获异常的实例：
```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // A specific exception,知道确切的异常类型
  buyMoreLlamas();
} on Exception catch (e) {
  // Anything else that is an exception，不太确定异常类型，但catch(e)可以获得异常实例
  print('Unknown exception: $e');
} catch (e) {
  // No specified type, handles all。对什么异常一无所知的时候
  print('Something really unknown: $e');
}
```
catch可以带两个参数，第一个是异常实例，第二个是堆栈跟踪对象(a StackTrace object)：
```dart
catch (e, s) {
  print('Exception details:\n $e');
  print('Stack trace:\n $s');
}
```
在catch块中使用rethrow关键字可重新抛出异常：
```dart
    catch (e) {
        print('misbehave() partially handled ${e.runtimeType}.');
        rethrow; // Allow callers to see the exception.
    }
```
为了确保无论是否抛出异常，某些代码都会运行，请使用finally子句。

#### 8.2 断言

断言语法：
```dart
assert(<condition>, <optionalMessage>);
```

断言失败引发异常(an AssertionError)，程序中止。

断言到底什么时候起作用？这取决于您使用的工具和框架：

* Flutter 在调试模式下启用断言。
* 仅限开发的工具（例如webdev serve 通常默认启用断言）。
* 一些工具，例如dart run和dart compile js 支持通过命令行标志进行断言：--enable-asserts。

assert在生产代码中将被忽略，并且不会评估参数。

### 9. 类

终于要学真正的核心内容了。
```text
Dart is an object-oriented language with classes and mixin-based inheritance.
Dart是一种面向对象的语言，具有类和基于混合的继承。

Every object is an instance of a class, and all classes except Null descend from Object.
每个对象都是一个类的实例，除了Null以外的所有类都继承自object。

Mixin-based inheritance means that although every class (except for the top class, Object?) has exactly one superclass, a class body can be reused in multiple class hierarchies.
基于混合的继承意味着，尽管每个类(除了顶级类，Object?)只有一个超类，但类体可以在多个类层次结构中重用。

Extension methods are a way to add functionality to a class without changing the class or creating a subclass.
扩展方法是一种在不改变类或创建子类的情况下向类添加功能的方法。

Class modifiers allow you to control how libraries can subtype a class.
类修饰符允许您控制库如何对类进行子类型化。
```

#### 9.1 使用类成员(Using class members)

dart的函数取代了java中的方法。

访问类成员时，用?.避免对象为空。

#### 9.2 使用构造函数

无需new关键字,用也可以。文档中使用了一个fromJson方法创建对象，不知道这个方法是不是继承自Object：
```dart
var p1 = Point(2, 2);
var p2 = Point.fromJson({'x': 1, 'y': 2});
```
##### 9.2.1 常量构造函数

有些类提供常量构造函数。要使用常量构造函数创建编译时常量，请将const关键字放在构造函数名称之前：
```dart
var p = const ImmutablePoint(2, 2);
```
构造两个相同的编译时常量会产生一个规范实例：
```dart
    ar a = const ImmutablePoint(1, 1);
    var b = const ImmutablePoint(1, 1);
    
    assert(identical(a, b)); // They are the same instance!
```
在常量上下文中，您可以省略构造函数或文字之前的const 。
省略前：
```dart
// Lots of const keywords here.
const pointAndLine = const {
  'point': const [const ImmutablePoint(0, 0)],
  'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};
```
省略后：
```dart
// Only one const, which establishes the constant context.
const pointAndLine = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};
```
如果常量构造函数位于常量上下文之外并且在没有const的情况下调用，它将创建一个非常量对象：
```dart
var a = const ImmutablePoint(1, 1); // Creates a constant
var b = ImmutablePoint(1, 1); // Does NOT create a constant

assert(!identical(a, b)); // NOT the same instance!
```

#### 9.3 获取对象的类型
To get an object’s type at runtime, you can use the Object property runtimeType, which returns a Type object.
```dart
print('The type of a is ${a.runtimeType}');
```
#### 9.4 实例变量(Instance variables)

实例就是通过类的构造函数生成的这个类的一个“产品”，或者说对象什么的吧，我表达能力不好，你能理解就好。

实例变量就是给这个类的一个个实例单独使用的变量。与实例变量对应的，在java中叫类变量，即静态变量，在dart中还没研究到。

不过java中的实例变量不建议直接访问，它会被设置为私有(private)，然后通过访问器getter方法获得。

```dart
class Point {
  double? x; // Declare instance variable x, initially null.
  double? y; // Declare y, initially null.
  double z = 0; // Declare z, initially 0.
}
```
所有实例变量都会生成隐式getter方法，非final实例变量和未初始化的late final实例变量也生成隐式setter方法。

换句话说，final变量不生成隐式setter方法，因为final变量不能被重新赋值，这也是当然的，但late final可以重新赋值。

至于late变量是什么，可以看看关键字一节。late 修饰符有两种用法：
* 声明一个非空变量，但不在声明时初始化。
* 延迟初始化一个变量。

不过从文档看起来,late变量使用时是否被赋值是不保险的。

If you initialize a non-late instance variable where it’s declared, the value is set when the instance is created,
which is before the constructor and its initializer list execute.

如果在声明的地方初始化非延迟实例变量，则在创建实例时设置该值，即在构造函数及其初始化列表执行之前。

As a result, non-late instance variable initializers can’t access this.

因此，非延迟实例变量初始化器不能访问this。

初始化器（initializers）是指构造方法吗？我理解的是在构造方法中不能使用this来访问本实例。这在java中是允许的，所以为了证实我的想法我写了个例子：
```dart
class A{
  int b = 100;
  int a=10;
  A(){
    this.b=this.a;
  }

}
main(){
  A a = A();
  print(a.b);
}

```
程序没有错误而且也是可以打印出10的，所以只能是initializer不是构造函数，constructor才是。

下面是java的一个带参数的构造函数的写法：
```java
public class A {
  private int a;
  public A(){}//java的无参构造函数
  public A(int a){//这是java的带参数的构造函数
    this.a=a;
  }

}
```
在dart中，我们的称呼和语法都要做点改变，当然dart比java简化了，例：
```dart
class A {
  int a;//dart中似乎不习惯加private在实例上，不过本质上实例访问这个成员隐式调用getter方法
  public A();//方法体都省了
  public A(this.a);//无需手动赋值，简化了很多


}
```
文档中也有个例子。ProfileMark.unnamed() : name = '';说实在的，这一句完全看不懂：
```dart
class ProfileMark {
  final String name;
  final DateTime start = DateTime.now();

  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}
```

如果你定义了一个late final，你可以像使用非final变量一样赋值超过一次，编译器并不报错，但是会产生运行时错误。

#### 9.5 隐式接口

为什么叫隐式接口呢？其实每个类都隐式包含一个接口。

```dart
// A person. The implicit interface contains greet().
class Person {
  // In the interface, but visible only in this library.
  //子类必须要实现它的getter方法
  final String _name;

  // Not in the interface, since this is a constructor.
  Person(this._name);

  // In the interface.
  //方法体并不是方法的默认实现，而是当它作为一个类而不是接口时用的
  String greet(String who) => 'Hello, $who. I am $_name.';
}

// An implementation of the Person interface.
class Impostor implements Person {
  //实现接口定义的_name属性的getter方法
  //关键字get表示getter方法
  String get _name => '';

  //实现类必须重写接口的方法
  String greet(String who) => 'Hi $who. Do you know who I am?';
}

String greetBob(Person person) => person.greet('Bob');

void main() {
  print(greetBob(Person('Kathy')));
  print(greetBob(Impostor()));
}
```

#### 9.6 类变量和方法

大致和java没什么区别

#### 9.7 构造方法

初始化形参：
```dart
class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
  // Sets the x and y instance variables
  // before the constructor body runs.
}
```
构造函数不会被继承。


##### 9.7.1 命名构造函数

命名构造函数，就是前面没搞懂的那句ProfileMark.unnamed() : name = '';就是命名构造函数。
冒号后面不能是带花括号语句块，不能有多个分号，就是说只能是一句代码，可以用逗号分隔给多个实例变量赋值。
```dart
const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  final double x;
  final double y;
 //这个构造函数的参数列表应该就是是前面提到的初始化列表吧,在构造函数主体执行前它就初始化了实例变量。
  Point(this.x, this.y);

  // Named constructor
  Point.origin()
      : x = xOrigin,
        y = yOrigin;
}
```
超类的构造函数和命名构造函数都不会被子类继承。


##### 9.7.2 调用非默认超类构造函数
```dart
class Person {
  String? firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson().
  Employee.fromJson(super.data) : super.fromJson() {
    print('in Employee');
  }
}

void main() {
  var employee = Employee.fromJson({});
  print(employee);
  // Prints:
  // in Person
  // in Employee
  // Instance of 'Employee'
}

```
问题在下面这句不好懂：
```dart
  Employee.fromJson(super.data) : super.fromJson() {
    print('in Employee');
  }
```
在java中，一个类如果不定义任何构造函数，是默认存在一个无参构造函数的。但是如果类提供了一个或多个有参构造函数，那个默认的构造函数就不存在了。
如果需要无参构造函数，则要显示的定义出来。就是说构造函数要么不写(存在一个默认无参的)，要么全写。
当子类继承这个类时，如果父类没有提供任何构造函数(实际上存在一个默认构造函数)。这个时候，子类也可以不提供构造函数。子类在实例化时，
会调用父类的默认构造函数同时实例化出一个父类对象。但当父类只定义了一个或多个有参构造函数，并未定义一个无参构造函数，
那么java强制要求子类提供一个构造函数，并用super(...)来调用父类的构造函数，否则子类不知道如何实例化一个父类对象。

下面是java代码示例：
```java
//Person.java定义了两个构造函数，没有无参构造函数
public class Person {
    private String firstName;
    private String lastName;
    public Person(String firstName) {
        this.firstName = firstName;
    }
    public Person(String firstName,String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }
}
//因为父类存在多个构造函数，所以Employee.java必须显式调用父类的构造函数来实例化一个父类对象
public class Employee extends Person{
    public Employee(String firstName) {
        super(firstName,"Mr. ");
    }
}

```

这里插一个小tip，即dart如何定义和调用父类的带参非命名构造函数，和java写法不一样，这个这么重要的知识点在文档中根本不提，太跳跃了。
下面的代码是我构造函数的参考初始化列表的写法自己套出来的，真的无语。

```dart
//这是在子类中定义和调用父类构造方法的dart写法，比java简化了
Employee(super.data);
```

dart和java类似，不同的是dart可以使用命名构造函数，即不使用类名而是使用方法名的一种方式：
```dart
//这是dart的命名构造函数，和java一样，如果存在其它构造函数，默认构造函数就不存在了，除非显式的定义出来。
//在这个例子里，Person只有一个这一个构造函数，而且是命名构造函数
Person.fromJson(Map data) {
    print('in Person');
  }
```
那么这个时候在子类中，dart如何定义一个构造函数来调用父类构造函数呢？

假设现在我按照java的语法来写dart中的Employee子类，像这样：
```dart
class Employee extends Person {
  //下面不行，Error: The superclass, 'Person', has no unnamed constructor that takes no arguments.
  //从报错信息来看，这是表示父类中没有未命名构造函数，显然这是dart想调用父类的未命名构造函数但却找不到,
  //所以我要想办法去调用父类中的fromJson方法。
  Employee(super.data);
}
```
在dart中调用父类的命名构造函数有自己的语法规定，现在再看下前面那段看不懂的代码，我在注释中解释了，现在应该很清楚了：
```dart
//冒号前面的这段Employee.fromJson(super.data)，表示子类Employee也定义了一个fromJson命名构造函数也叫fromJson，
// 当然也可以是别的名字，并且传入父类构造方法需要的参数类型和形参名称(super.data)。
//冒号后面super.fromJson() {...}这一句蛮有讲究的，
// super.fromJson()这一段表示调用父类的构造方法，而花括号内是重写父类的构造方法。
//花括号是可以省略的，表示不重写父类的构造方法。
// 不过super.fromJson()为什么没有参数呢？
  Employee.fromJson(super.data) : super.fromJson() {
    print('in Employee');//这里重写了父类的fromJson方法
    //我试着加了下面这句,是报错的，
    ////Error: The getter 'data' isn't defined for the class 'Employee'.
    // 它去找Employee的成员data去了，明显不是我设想的要访问传入的变量。
    // 那么如何在子类中访问传入的这个参数呢？希望后面有提及。
    print(data);//报错

  }
```
上面是Employee也定义了一个fromJson命名构造函数，如果不想定义命名构造函数而是想定义非命名构造函数，应该这样写：

* 1.Employee定义无参构造函数
```dart
  Employee():super.fromJson({}){
    print('in Employee');
  }
```

* 2.Employee定义一个参数的参构造函数，并且参数传入父类中：

```dart
  Employee(super.data):super.fromJson(){
    print('in Employee');
  }
```
* 3.Employee定义一个参数的参构造函数，并且参数不传入父类中：
```dart
  Employee(Map data):super.fromJson({}){
    print('in Employee');
  }
```
* 4.Employee定义2个参数的参构造函数，并且参数不传入父类中：
```dart
  Employee(Map data,String y):super.fromJson({}){
    print(y);
  }
```
有意思的是，上面4种情况单独使用都是OK的，但4个随便组合放在一起，即定义多个构造方法，则报错：
 Error: 'Employee' is already declared in this scope.
 这个问题暂时没有头绪，继续研究下去看看。

##### 9.7.3 Super parameters

我把它翻译为：超类参数。

我们之前看到过下面这样的构造函数：
```dart
Point(this.x, this.y);
```
如果用java写类似的代码，应该是这样：
```java
public class Point{
    private int x;
    private int y;
    public Point(int x,int y) {
        this.x = x;
        this.y = y;
    }
}
```
dart中的构造函数的参数类型，赋值语句都省略了。这种省略并不引起歧义，this.x表示这是给类实例属性x赋值，
this.y给属性y赋值，所以数据类型可以不指定，赋值语句也可以省略。

实际上，如果需要我们可以给该构造函数加上方法体：
```dart
  Point(this.x, this.y){
    print('x:$x,y:$y');
  }

```

与此类似的，当一个类继承另一个类，比如叫Vector3d的类继承自Vector2d，在Vector2d中，
我们需要在Vector3d的构造函数中调用Vector2d的构造函数，
则可以用如下的示例代码：
```dart
class Vector2d {
  final double x;
  final double y;

  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;

  // Forward the x and y parameters to the default super constructor like:
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  Vector3d(super.x, super.y, this.z);
}
```
super.x, super.y表示这两个参数是传递给父类并赋值的，而this.z表示这是传递给自己的z属性的。
super.x, super.y就叫super parameters。

下面是父类使用命名构造函数加命名参数定义构造函数的方式，注意子类传递构造函数的参数的方式：
```dart
class Vector2d {
  // ...

  Vector2d.named({required this.x, required this.y});
}

class Vector3d extends Vector2d {
  // ...

  // Forward the y parameter to the named super constructor like:
  // Vector3d.yzPlane({required double y, required this.z})
  //       : super.named(x: 0, y: y);
  //父类的x和y在子类定义的命名构造函数yzPlane用关键字super.x,super.y传递，
  // 而需要的x则在调用冒号右边的super.named(x: 0)调用时传入
  Vector3d.yzPlane({required super.y, required this.z}) : super.named(x: 0);
}
```

学到这里我猛的浮现了一幕，这种冒号的写法似乎在哪里见过。仔细想想似乎是c#和c++中有这种语法。

几个名词提一下，是我本人的翻译和理解，不是标准答案：
* initializer：初始化器，像Vector3d.yzPlane({required super.y, required this.z})这句代码的括号内（注意强调是括号内）是用来初始化父类或本类的值的，所以叫初始化器
* super-initializer：带super的初始化器就是父类初始化器，它专门用来初始化父类的实例变量
* initializer list：初始化器列表，即多个初始化器，也就是yzPlane方法里的多个参数
* super-constructor：父类构造函数，Vector2d.named就是Vector3d的父类构造函数

搞清这两个概念是为了理解这句话：

Super-initializer parameters cannot be positional if the super-constructor invocation already has positional arguments,
but they can always be named.

我意译一下：如果父类构造函数调用时使用了位置参数，那么父类初始化器的参数就不能是位置参数，不过呢，如果参数都是命名参数就无所谓了。

我再结合代码解释一下，例子是上面这段代码。父类构造函数调用是指的: super.named(x: 0)这段代码，它调用了父类的构造函数named,使用了命名参数x:0,
所以父类初始化器Vector3d.yzPlane的参数就可以是位置参数也可以是命名参数。例子里都用了位置参数，所以研究是不全面的，我试了试做点研究。

```dart
class Vector2d {
  double x=0;
  double y=0;
  Vector2d.named(this.x,this.y);
}
class Vector3d extends Vector2d {
  double z=0;
  //第一个参数是super.y，是表示是给父类的y赋值吗？
  Vector3d.xyPlane(super.y,super.x,this.z):super.named();
  Vector3d.xyPlane(super.a,super.b,this.z):super.named();
}

main(){
  Vector3d v1 = Vector3d.xyPlane(11,2,3);
  print(v1.x);//print 11.0
}

```

上面我写的例子里，Vector3d.xyPlane，xyPlane的第一个参数super.y（它是一个父类初始化器：super-initializer）并不是初始化父类的x属性的值的，
因为是子类是调用父类的named方法，而named方法是定义了两个位置参数Vector2d.named(this.x,this.y)。所以该构造函数的第一个参数就是为了给x属性赋值的，
第二个给y赋值。在子类定义自己的构造函数xyPlane时，同时利用初始化列表给父类赋值。因为父类构造函数定义的参数是位置参数，那么这个初始化列表就会按照位置顺序赋值。
Vector3d.xyPlane(super.y,super.x,this.z)这段代码中，它的第一第二个参数已经被父类的构造函数固定了，y,x这几个变量名只不过是形式参数而已，你换成啥变量名都可以。
但是第三个就必须是this.z了吗？也不是，我们可以这样写：
```dart
class Vector2d {
  double x=0;
  double y=0;
  Vector2d.named(this.x,this.y){
    print('invoke in super');
  }
}
class Vector3d extends Vector2d {
  double z=0;
  //第一个参数是super.y，是表示是给父类的y赋值吗？
  Vector3d.xyPlane(super.y,super.x,this.z):super.named(){
    print('x:$x,y:$y,z:$z');
  }
  Vector3d.xyzPlane(super.a,super.b,double c):super.named() {
    this.z=c;
    print('invoke in sub,z:$z');
  }
}

main(){
  Vector3d v1 = Vector3d.xyzPlane(11,2,3);
  print(v1.x);
  print(v1.y);
  print(v1.z);
//打印
//invoke in super
//invoke in sub,z:3.0
//11.0
//2.0
//3.0
}
```
这里看到打印invoke in super后再打印invoke in sub,z:3.0，表示父类和子类的构造函数都执行了，所以子类构造函数的方法体并不是重写父类构造函数，
而是自己拥有的这个构造函数的方法体。

我后来又突发奇想，也忘了是出于什么目的写的，似乎是为了模仿java风格写的，意外的是下面的构造方法的写法也是OK的：
```dart
  Vector3d.xyzPlaneAsJava(double a,double b,double c):super.named(a,b) {
    this.z=c;
    print('invoke in sub,z:$z,x=$x,y=$y');
  }
```
通过上面这段xyzPlaneAsJava我发现了不少玄机，不过又不好用语言表达，可能是目前掌握的dart术语不够，大家先自己领会吧。

xyPlane这个构造函数的形参的顺序是先要满足父类构造函数的要求，父类构造函数如果定义了位置参数，那就先要满足父类的要求先传入父类的初始化参数，剩下的位置可以留给自己用。

##### 9.7.4 Initializer list

初始化器列表,原来教程还有专门的章节介绍，我感觉在上一节都研究透了。看看还有什么新东西可研究。

```dart
// Initializer list sets instance variables before
// the constructor body runs.
Point.fromJson(Map<String, double> json)
    : x = json['x']!,
      y = json['y']! {
  print('In Point.fromJson(): ($x, $y)');
}
```
上面这段是构造函数的另一种写法，这个冒号和前面子类命名构造函数调用父类命名构造函数使用的冒号不是一回事，它是给命名构造函数函数执行前运行一段赋值语句。
实例中Point的x成员变量被赋予json中x下标的值，后面这个叹号(!)是非空断言，如果被赋值为null则会抛出异常。

下面是只做非空断言的写法，仅在开发阶段生效：
```dart
Point.withAssert(this.x, this.y) : assert(x >= 0) {
  print('In Point.withAssert(): ($x, $y)');
}
```

还有就是可以在初始化器列表初始化常量，所以常量实例属性可以在声明是先不赋值，延迟到在初始化器中赋值：
```dart
import 'dart:math';

class Point {
  final double x;
  final double y;
  final double distanceFromOrigin;

  Point(double x, double y)
      : x = x,
        y = y,
        distanceFromOrigin = sqrt(x * x + y * y);
  //实际上这个构造函数可以更简化一点像下面这样：
  //Point(this.x,this.y):distanceFromOrigin = sqrt(x * x + y * y);
}

void main() {
  var p = Point(2, 3);
  print(p.distanceFromOrigin);
}
```

##### 9.7.5 Redirecting constructors

重定向构造函数，就是同一个类中构造函数调用另一个构造函数，可以使用在冒号分割的那种命名构造函数中。
重定向构造函数的主体为空，构造函数调用(使用this而不是类名)出现在冒号(:)之后。
```dart
class Point {
  double x, y;

  // The main constructor for this class.
  Point(this.x, this.y);

  // Delegates to the main constructor.
  Point.alongXAxis(double x) : this(x, 0);
}
```
为什么alongXAxis不能有方法体？这是语法规定的，暂时不理解有什么玄机，等领悟了在后面领悟到的地方解释。

##### 9.7.6 Constant constructors

常量构造器。

If your class produces objects that never change, you can make these objects compile-time constants.

如果你的类产生的对象永远不会改变，你可以让这些对象成为编译时常量。

To do this, define a const constructor and make sure that all instance variables are final.

为此，定义一个const构造函数，并确保所有实例变量都是final。

```dart
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);

  final double x, y;

  const ImmutablePoint(this.x, this.y);
}
```
这样，我们就可以使用一个常量来接收实例化产生的实例：
```dart
main(){
  const ip1 = ImmutablePoint(0,0);
  const ip4 = ImmutablePoint(0,0);
  var ip5 = ImmutablePoint(0,0);
  print('ip1 x=${ip1.x},ip4 x=${ip4.x},ip1=ip4 is ${ip1==ip4},ip1=ip5 is ${ip1==ip5}');
}
```
打印出“ip1 x=0.0,ip4 x=0.0,ip1=ip4 is true,ip1=ip5 is false”，这个结果说明用const接收的变量，只要参数想等就是同一个实例。
而使用var接收的实例则是另一个不同的实例。

##### 9.7.7 Factory constructors

这小节终于不用动脑子研究了，直接翻译即可。

Use the factory keyword when implementing a constructor that doesn’t always create a new instance of its class.

当实现不总是创建其类的新实例的构造函数时，使用factory关键字。

For example, a factory constructor might return an instance from a cache, or it might return an instance of a subtype.

例如，工厂构造函数可能从缓存返回实例，也可能返回子类型的实例。

Another use case for factory constructors is initializing a final variable using logic that can’t be handled in the initializer list.

工厂构造函数的另一个用例是使用初始化列表中无法处理的逻辑初始化final变量。

```dart
class Logger {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}
```
```text
 备注: Factory constructors have no access to this.
```

nvoke a factory constructor just like you would any other constructor:

像调用其他构造函数一样调用工厂构造函数:
```dart
var logger = Logger('UI');
logger.log('Button clicked');

var logMap = {'name': 'UI'};
var loggerJson = Logger.fromJson(logMap);
```

#### 9.8 成员方法

概念上对应java的成员方法，dart的成员方法本质上是一个函数。

##### 9.8.1 Instance methods
无难点，照抄文档即可，翻译免。

Instance methods on objects can access instance variables and this.
The distanceTo() method in the following sample is an example of an instance method:
```dart
import 'dart:math';

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}
```
##### 9.8.2 Operators
操作符，这个很有新意。在dart中定义一些操作符如加减乘除(+,-,*,/),这样我们就可以让两个或多个类的实例进行加减乘除，
不过这个加减乘除并不是数学上的算数，而是定义一个函数进行计算，这个计算被赋予了操作符。

虽然很有新意，但是例子并不难懂，我暂时也不想深入这个主题，所以看看例子就过了。
```dart
class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  @override
  bool operator ==(Object other) =>
      other is Vector && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}

void main() {
  final v = Vector(2, 3);
  final w = Vector(2, 2);

  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));
}
```
##### 9.8.3 Getters and setters

简单，仅翻译。

Getters and setters are special methods that provide read and write access to an object’s properties.

getter和setter是提供对对象属性的读写访问的特殊方法。

Recall that each instance variable has an implicit getter, plus a setter if appropriate.

回想一下，每个实例变量都有一个隐式的getter，如果合适的话还会加上一个setter。

You can create additional properties by implementing getters and setters, using the get and set keywords:

你可以通过使用get和set关键字实现getter和setter来创建额外的属性:
```dart
ass Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // Define two calculated properties: right and bottom.
  double get right => left + width;
  set right(double value) => left = value - width;
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

void main() {
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}
```
With getters and setters, you can start with instance variables, later wrapping them with methods, all without changing client code.

使用getter和setter，您可以从实例变量开始，然后用方法包装它们，而无需更改客户端代码。

##### 9.8.4 Abstract methods
简单，仅翻译。

instance, getter, and setter methods can be abstract, defining an interface but leaving its implementation up to other classes.

实例、getter和setter方法可以是抽象的，它们定义了一个接口，但将其实现留给其他类。

Abstract methods can only exist in abstract classes or mixins.

抽象方法只能存在于抽象类或混合中。

To make a method abstract, use a semicolon (;) instead of a method body:

要使方法抽象，使用分号(;)代替方法体:

```dart
abstract class Doer {
  // Define instance variables and methods...

  void doSomething(); // Define an abstract method.
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // Provide an implementation, so the method is not abstract here...
  }
}
```
#### 9.9 继承

虽然继承在面向对象语言比如java中，是一个非常庞大的话题，但是dart的继承设计似乎跟java区别不大，所以如果懂java则没必要长篇大论讲了。
如果有值得提出来的问题我就贴出来研究一下。

java中，重写父类方法可以改变返回类型为父类方法返回类型的子类，但参数不可以这样做。在dart中不但返回类型可以缩小，
如果代码可以保证不会发生类型错误，参数的类型也可以缩小。

##### noSuchMethod()

To detect or react whenever code attempts to use a non-existent method or instance variable, you can override noSuchMethod():

要在代码试图使用不存在的方法或实例变量时检测或做出反应，您可以重写noSuchMethod():
```dart
class A {
  // Unless you override noSuchMethod, using a
  // non-existent member results in a NoSuchMethodError.
  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: '
        '${invocation.memberName}');
  }
}
```

You can’t invoke an unimplemented method unless one of the following is true:

除非下列条件之一为真，否则不能调用未实现的方法:

The receiver has the static type dynamic.

接收者具有静态类型的动态（这个“有静态类型的动态”是啥个意思啊？）。

The receiver has a static type that defines the unimplemented method (abstract is OK), 
and the dynamic type of the receiver has an implementation of noSuchMethod() that’s different from the one in class Object.

接收者有一个定义未实现方法的静态类型(抽象是可以的)，接收者的动态类型有一个noSuchMethod()的实现，它与Object类中的实现不同。

#### 9.10 混入(mixin)

Mixins are a way of defining code that can be reused in multiple class hierarchies.

Mixins是一种定义可以在多个类层次结构中重用的代码的方法。


They are intended to provide member implementations en masse.

它们旨在提供整体的成员实现。


To use a mixin, use the with keyword followed by one or more mixin names.

要使用mixin，使用with关键字，后跟一个或多个mixin名称。


The following example shows two classes that use mixins:

下面的例子展示了两个使用mixins的类:
```dart
class Person{

}
class Performer{}
//Musical是一个mixin，with关键字表示使用mixin
class Musician extends Performer with Musical {
  // ···
}

class Maestro extends Person with Musical, Aggressive, Demented {
  String? name;
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}
mixin Aggressive{}
mixin Demented{}
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}

```
试试怎么用：
```dart
main(){
  var me =Maestro("Mike");
  me.entertainMe();
}

```
打印出了“Waving hands”。可以看出mixin有点像java中的接口和抽象类的复合体，dart中的类可以使用多个mixin，mixin中的方法可以有方法体。


To define a mixin, use the mixin declaration.

要定义mixin，请使用mixin声明。

In the rare case where you need to define both a mixin and a class, 
you can use the mixin class declaration.

在需要同时定义mixin和类的极少数情况下，可以使用mixin类声明。

Mixins and mixin classes cannot have an extends clause, and must not declare any generative constructors.

mixin和mixin类不能有extends子句(mixin类是指with了mixin的类吗？前面的Maestro不是extends Person了吗？不要突然冒出一个概念来唬我好不好)，
也不能声明任何生成构造函数。



For example:
```dart
//有方法有变量，看上去像一个类，Musical不能extends另一个mixin
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}

```
从目前的了解，mixin之间是没有继承关系的，dart如何组织这些mixin之间的关系应该会使用别的手段，我们继续看下去。

Sometimes you might want to restrict the types that can use a mixin.

有时你可能想限制可以使用mixin的类型。

For example, the mixin might depend on being able to invoke a method that the mixin doesn’t define.

例如，mixin可能依赖于能够调用mixin没有定义的方法。

As the following example shows, you can restrict a mixin’s use by using the on keyword to specify the required superclass:

如下面的例子所示，你可以通过使用on关键字来指定所需的父类来限制mixin的使用:
```dart
class Musician {
  // ...
}
mixin MusicalPerformer on Musician {
  // ...
}
class SingerDancer extends Musician with MusicalPerformer {
  // ...
}
```

说得不是很明确，我自己改了改代码试了下：

```dart
//Musician并不能 with MusicalPerformer
class Musician {
  // ...
}

mixin Performer {
  // ...
}
//此处的on关键字表示该mixin只能用在extends Musician的类，即Musician的子类上，并不包括Musician本身
mixin MusicalPerformer on Musician {
  // ...
}
//MusicalPerformer只能用在继承了Musician的类上
class SingerDancer extends Musician with MusicalPerformer {
  // ...
}
//Athletes可以with Performer但是不可以with MusicalPerformer
class Athletes with Performer{}

```

In the preceding code, only classes that extend or implement the Musician class can use the mixin MusicalPerformer.
在前面的代码中，只有扩展或实现了Musician类的类才能使用mixin MusicalPerformer。

Because SingerDancer extends Musician, SingerDancer can mix in MusicalPerformer.
因为SingerDancer扩展了Musician，所以SingerDancer可以混合在MusicalPerformer中。


##### 9.10.1 class, mixin, or mixin class?

A mixin declaration defines a mixin.

mixin声明定义了一个mixin。

A class declaration defines a class.

类声明定义了一个类。

A mixin class declaration defines a class that is usable as both a regular class and a mixin, with the same name and the same type.

mixin类声明定义了一个既可用作常规类又可用作mixin的类，具有相同的名称和类型。

Any restrictions that apply to classes or mixins also apply to mixin classes:

任何适用于类或mixin的限制也适用于mixin类:

* Mixins can’t have extends or with clauses, so neither can a mixin class.

mixin不能有extends或with子句，所以mixin类也不能。

* Classes can’t have an on clause, so neither can a mixin class.

类不能有on子句，mixin类也不能。

```dart
mixin class MixinClass{}
```

##### 9.10.2 abstract mixin class

You can achieve similar behavior to the on directive for a mixin class.

你可以在mixin类中实现与on指令类似的行为。

Make the mixin class abstract and define the abstract methods its behavior depends on:

使mixin类抽象，并定义其行为所依赖的抽象方法:
```dart
abstract mixin class Musician {
  // No 'on' clause, but an abstract method that other types must define if 
  // they want to use (mix in or extend) Musician: 
  void playInstrument(String instrumentName);

  void playPiano() {
    playInstrument('Piano');
  }
  void playFlute() {
    playInstrument('Flute');
  }
}

class Virtuoso with Musician { // Use Musician as a mixin
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName beautifully');
  }  
} 

class Novice extends Musician { // Use Musician as a class
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName poorly');
  }  
} 
```

实际上，mixin也是可以定义抽象方法的，即无方法体。所以是不是认为mixin是另一套语法规则的抽象类呢？

By declaring the Musician mixin as abstract, you force any type that uses it to define the abstract method upon which its behavior depends.

通过将音乐家mixin声明为抽象的，可以强制使用它的任何类型定义其行为所依赖的抽象方法。

This is similar to how the on directive ensures a mixin has access to any interfaces it depends on by specifying the superclass of that interface.

这类似于on指令通过指定接口的超类来确保mixin可以访问它所依赖的任何接口。

#### 9.11 枚举

声明一个枚举:
```dart
enum Color { red, green, blue }
```
#### 9.11.1 Declaring enhanced enums

本章都没有难点，略。

#### 9.12 扩展方法

本章都没有难点，略。

#### 9.12 可调用对象

```dart
class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}

var wf = WannabeFunction();
var out = wf('Hi', 'there,', 'gang');

void main() => print(out);
```
本章都没有难点，略。

### 10 类型修饰符

类修饰符控制如何从类或mixin自己的库中以及从定义类或mixin的库外部使用类或mixin。
修饰符关键字出现在类或mixin声明之前。
例如，abstract class定义了一个抽象类。可以出现在类声明之前的修饰符的完整集合包括:
* abstract
* base
* final
* interface
* sealed
* mixin

只有base修饰符可以出现在mixin声明之前。这些修饰符不适用于其他声明，如enum、typedef或extension。

#### 10.1 No modifier
要允许不受限制地从任何库构造或子类化，请使用不带修饰符的类或mixin声明。默认情况下，您可以:
* 构造类的新实例。
* 扩展类以创建新的子类型。
* 实现一个类或mixin的接口。
* 在mixin或mixin类中混合。

#### 10.2 abstract

#### 10.3 base

要强制继承类或mixin的实现，请使用base修饰符。base类不允许在自己的库之外实现。这个担保:
* 每当创建类的子类型的实例时，就调用基类构造函数。
* 所有实现的私有成员都存在于子类型中。
* 基类中新实现的成员不会破坏子类型，因为所有子类型都继承新成员。除非子类型已经声明了具有相同名称和不兼容签名的成员，否则是正确的。

所以我想base类的初衷是为了小范围使用，比如只在自己的库中使用。因为它过于宽松，可以与子类共享私有属性。

base类可以被继承（extends）不可以被实现（implements）。

必须将实现或继承base类的任何类标记为base类、final类或sealed类。这可以防止外部库破坏基类的保证。

#### 10.3 interface

java中的interface在dart中成了修饰符，休时候的类就叫接口类。dart因为在类中隐式包含了接口，所以可以不需要接口这种东西。
接口类只能实现不能继承。
* 当一个类的实例方法调用另一个实例方法时(这在java中是办不到的，java程序员可能还不适应这种方式)，它将始终调用同一库中该方法的已知实现。
* 其他库不能覆盖接口类自己的方法以后可能以意想不到的方式调用的方法。这减少了脆弱的基类问题。

因为我还未在实战中使用过dart，所以并不能领会这些问题。

#### 10.4 abstract interface

没太看懂，是不是说abstract interface既像纯接口又像抽象类呢？

The most common use for the interface modifier is to define a pure interface. Combine the interface and abstract modifiers for an abstract interface class.

Like an interface class, other libraries can implement, but cannot inherit, a pure interface. Like an abstract class, a pure interface can have abstract members.

#### 10.5 final
阻止继承(extends)，也阻止实现（implements）。

#### 10.6 sealed
密封类。

要创建已知的、可枚举的子类型集，请使用sealed修饰符。这允许您创建在这些子类型之间的切换，这些子类型静态地确保是详尽的。

上面说的切换是指使用switch语法或switch子句详尽列举它的所有实例。

sealed修饰符防止类在其自己的库之外被扩展或实现。密封类是隐式抽象的。

* 它们不能自己构造(They cannot be constructed themselves)。
* 他们可以有工厂构造函数(They can have factory constructors)。
* 它们可以定义要使用的子类的构造函数(They can define constructors for their subclasses to use)。

如果您不希望彻底switch，或者希望能够在不破坏API的情况下稍后添加子类型，请使用final修饰符。

#### 10.7 Combining modifiers

您可以为分层限制组合一些修饰符。一个类的声明可以是:
* (可选)abstract，描述类是否可以包含抽象成员并防止实例化。
* (可选) base,interface,final,sealed中的一种，描述对其他类子类化的限制。
* (可选)mixin，描述是否可以混合声明。
* class关键字本身。

你不能把一些修饰语组合在一起，因为它们是矛盾的、冗余的或互斥的:
* abstract with sealed. A sealed class is always implicitly abstract.
* interface, final or sealed with mixin. These access modifiers prevent mixing in. 

总之这些规则去记忆是没有道理的，在使用中慢慢踩坑和体会dart的设计原则才是正道。

#### 10.8 API 维护者应该用的类型修饰符

这是高级点的主题，所以我先跳过。先会用别人的API，等我想编写自己的API的时候再回来看看。

#### 10.9 速查表

https://dart.cn/language/modifier-reference

<table class="table table-striped nowrap">
    <thead>
      <tr>
        <th>Declaration</th>
        <th>
<a href="/language/classes#using-constructors">Construct</a>?</th>
        <th>
<a href="/language/extend">Extend</a>?</th>
        <th>
<a href="/language/classes#implicit-interfaces">Implement</a>?</th>
        <th>
<a href="/language/mixins">Mix in</a>?</th>
        <th>
<a href="/language/branches#exhaustiveness-checking">Exhaustive</a>?</th>
        <th>&nbsp;</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">class</code></td>
        <td><strong>Yes</strong></td>
        <td><strong>Yes</strong></td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">base class</code></td>
        <td><strong>Yes</strong></td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>No</td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">interface class</code></td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">final class</code></td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>No</td>
        <td>No</td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">sealed class</code></td>
        <td>No</td>
        <td>No</td>
        <td>No</td>
        <td>No</td>
        <td><strong>Yes</strong></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">abstract class</code></td>
        <td>No</td>
        <td><strong>Yes</strong></td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">abstract base class</code></td>
        <td>No</td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>No</td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">abstract interface class</code></td>
        <td>No</td>
        <td>No</td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">abstract final class</code></td>
        <td>No</td>
        <td>No</td>
        <td>No</td>
        <td>No</td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">mixin class</code></td>
        <td><strong>Yes</strong></td>
        <td><strong>Yes</strong></td>
        <td><strong>Yes</strong></td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">base mixin class</code></td>
        <td><strong>Yes</strong></td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">abstract mixin class</code></td>
        <td>No</td>
        <td><strong>Yes</strong></td>
        <td><strong>Yes</strong></td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">abstract base mixin class</code></td>
        <td>No</td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">mixin</code></td>
        <td>No</td>
        <td>No</td>
        <td><strong>Yes</strong></td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><code class="language-plaintext highlighter-rouge">base mixin</code></td>
        <td>No</td>
        <td>No</td>
        <td>No</td>
        <td><strong>Yes</strong></td>
        <td>No</td>
        <td>&nbsp;</td>
      </tr>
    </tbody>
  </table>

### 11. 并发

我想学完这一章，dart的入门研究算是结束了，接下来我会去搞flutter。如果dart还有需要深入研究的主题，我想用一个个的专题来研究。

#### 11.1 异步支持
Dart库中充满了返回Future或Stream对象的函数。这些函数是异步的:它们在设置一个可能很耗时的操作(比如I/O)后返回，而不等待该操作完成。
async和await关键字支持异步编程，使您可以编写与同步代码相似的异步代码。

##### 11.1.1 Handling Futures

当你要等待一个耗时的操作完成，这在客户端调用服务端web API是是非常常见的事情。在js中，我们可能会使用回调函数。
本人对这种编程风格的讨厌程度极高。不过好在ES5之后有async和await搭救我。在dart中也有这两个关键字来做同样的事。

```dart
Future<void> checkVersion() async {
//To use await, code must be in an async function —a function marked as async:
  var version = await lookUpVersion();
  // Do something with version
}
```
函数里出现await这种调用方式，函数就要声明为async函数。否则报错The await expression can only be used in an async function.

注意要分清谁是调用者谁是被调用者，这里的await和async是要求调用者的，而被调用者，即lookUpVersion这个函数并没有要求。

尽管异步函数可能执行耗时的操作，但它并不等待这些操作。相反，async函数只在遇到第一个await表达式之前执行。
然后它返回一个Future对象，只有在await表达式完成后才恢复执行。
```dart
main(){
  Future<void> f = checkVersion();
  //other codes
}

```
我们在main方法中调用checkVersion这个异步函数，异步函数在碰到await之前都和同步函数一样执行下去，
main函数也在等待checkVersion的执行。直到碰到await，函数checkVersion知道了这是个耗时的操作，
所以不等了立即返回一个Future<void>类型的对象，而main函数也会继续执行下去。不过在checkVersion函数内部，
剩余的代码还会继续执行下去吗？前面说了，等await执行完成后会恢复执行。

另外，大家发现没有，checkVersion有定义返回值类型Future<void>，但却没有return语句，不是很奇怪吗？
是不是因为函数被定义为async后，就可以没有返回值呢？简单想想可能还真是，因为它碰到await会自动返回。
然而我试了试把返回值类型由Future<void>改为Future<String>后，它就要求我需要返回值了：
```dart

Future<String> checkVersion() async {
  var version = await lookUpVersion();
  print(version);
//如果没有return语句，编译会报错误：
// The body might complete normally, causing 'null' to be returned, but the return type,
// 'FutureOr<String>', is a potentially non-nullable type.
  return  null as Future<String>;
}
```
所以，只有Future<void>返回类型的async函数不需要返回值。

await语句用try catch来捕获异常可能是个常规做法。

await语句在一个async函数中可以出现多次：
```dart
var entrypoint = await findEntryPoint();
var exitCode = await runExecutable(entrypoint, args);
await flushThenExit(exitCode);
```

在await表达式中，expression的值通常是Future;如果不是，那么该值将自动包装在Future中。这个Future对象表示一个返回对象的承诺。
await表达式的值就是返回的对象。await表达式暂停执行，直到该对象可用为止。

如果在使用await时出现编译时错误，请确保await在async函数中。例如，要在应用程序的main()函数中使用await, main()函数体必须标记为async:
```dart
void main() async {
  checkVersion();
  print('In main: version is ${await lookUpVersion()}');
}
```

教程到这里提示我还有异步编程的详细资料 https://dart.cn/codelabs/async-await 。
如果有必要我可能还要开一章节学习这个，不过先把它这个简单的教程学完。

##### 11.1.2 声明异步函数

下面这个同步函数返回一个String:
```dart
String lookUpVersion() => '1.0.0';
```
改为异步后：
```dart
Future<String> lookUpVersion() async => '1.0.0';
```
有没有觉得奇怪，箭头函数明明代表着它返回了一个String,而不是Future<String>。
为了让还不习惯箭头函数写法的我能看更明白，我把它改为常规写法：
```dart
Future<String> checkVersion() async {
  return  '';
}
```
一点也没有报错，说明说明？说明async函数虽然声明返回值是Future<String>，但你只需要返回String,
它会自动包装成Future<String>。

现在还有一个问题，我现在获得了Future<String>类型的返回值，我如何从这个包装对象中获得被包装进来字符串或其它对象呢？
继续学下去找答案。

##### 11.1.3 Handling Streams

完全是没有前置知识就跳跃来的莫名其妙的一节，根本不知道在说什么。

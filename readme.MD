## dart入门

这不是一个教程，教程在这里 https://dart.cn/language

本研究项目的章节和教程一致。

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

#### 4.1 命名参数

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

#### 4.2 位置参数

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

#### 4.3 可选位置参数

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

#### 4.4 main() 函数

程序的入口函数，其实它定义了List<String>类型的可选参数。目前我使用的intellij idea无法点进去看main函数的定义代码。

#### 4.5 Functions as first-class objects

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

#### 4.6 匿名函数(Anonymous functions)

匿名函数，有时也称为lambda或闭包。

匿名函数这样声明：
```text
([[Type] param1[, …]]) {
  codeBlock;
};
```

##### 4.6.1 研究下List.map先

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

##### 4.6.2 使用示例

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

##### 4.6.3 变量作用域 (Lexical scope)

Lexical是词汇的意思，但是我觉得这里应该是变量作用域。

和java一样，花括号里面的代码块包含的变量不会在它外面生效，但外面的可以在里面使用。

##### 4.6.4 闭包（Lexical closures）

如果看文档上的例子，你不会理解闭包。在网上找了一篇《深入理解 Dart Function & Closure》的文章，对我理解很有帮助，但解释得有点繁琐。
不如看我三言两语解释透彻。

先看看闭包的定义：
```text
闭包是一个函数对象，它可以访问其词法作用域中的变量，即使该函数在其原始作用域之外使用也是如此。
```

我自己写了个例子：
```dart
void main() {

  var print1 = setDiscountToCalTotal(0.8);
  print1(100);
  var print2 = setDiscountToCalTotal(0.5);
  print1(50);
  print2(500);
  print(total);
}

double total=0;
Function setDiscountToCalTotal(double discount){
  print('设置折扣为：$discount');
  var printTotal = (int price){
    double cost = price*discount;
    total+=cost;
    print('当前商品价格：$price,折扣：${discount},折后价：$cost,总价：$total');
  };
  return printTotal;
}
```


class ImmutablePoint {
//  static const ImmutablePoint origin = ImmutablePoint(0, 0);
  //要让构造函数可以是const，实例变量为final是硬性规定，否则构造函数不能使用const
  final double x, y;
  //这里能使用const的前提是前面定义了类常量x,y。这里有了const修饰，就可以在实例化时就可以用一个常量接收其赋值
  //当然即便有const修饰，你也可以实例化为一个变量而不必实例化为常量
  const ImmutablePoint(this.x, this.y);
}
main(){
//  const ip1=ImmutablePoint.origin;
  var ip2=ImmutablePoint(0,0);
  var ip3 = ImmutablePoint(0,0);
//  print('ip1 x=${ip1.x},ip2 x=${ip2.x},ip1=ip2 is ${ip1==ip2},ip2=ip3 is ${ip2==ip3}');
 print('ip2 x=${ip2.x},ip3 x=${ip3.x},ip2=ip3 is ${ip2==ip3}');
  const ip1 = ImmutablePoint(0,0);
  const ip4 = ImmutablePoint(0,0);
  var ip5 = ImmutablePoint(0,0);
  print('ip1 x=${ip1.x},ip4 x=${ip4.x},ip1=ip4 is ${ip1==ip4},ip1=ip5 is ${ip1==ip5}');
}

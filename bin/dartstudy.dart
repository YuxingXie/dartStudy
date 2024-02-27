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

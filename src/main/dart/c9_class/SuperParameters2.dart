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
    print('z:$z');
  }
}

main(){
  Vector3d v1 = Vector3d.xyzPlane(11,2,3);
  print(v1.x);
  print(v1.y);
  print(v1.z);
}

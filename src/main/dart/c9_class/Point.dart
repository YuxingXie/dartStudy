const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  final double x;
  final double y;

  Point(this.x, this.y){
    print('x:$x,y:$y');
  }

  // Named constructor
  Point.origin()
      : x = xOrigin,
        y = yOrigin;
}
main(){
  Point(2,3);
}

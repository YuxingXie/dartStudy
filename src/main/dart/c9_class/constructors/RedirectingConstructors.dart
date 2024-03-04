class Point {
  double x, y;

  // The main constructor for this class.
  Point(double x, double y):x=0,y=0{
    this.x=x;
    this.y=y;
  }

  // Delegates to the main constructor.
  Point.alongXAxis(double x) : this(x, 0);
}

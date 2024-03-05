class Person{

}
class Performer{}
class Musician extends Performer with Musical {
  // ···
}

//class Maestro extends Person with Musical, Aggressive, Demented {
class Maestro extends Person with Musical{
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
main(){
  var me =Maestro("Mike");
  me.entertainMe();
}

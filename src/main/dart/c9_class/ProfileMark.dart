class ProfileMark {
  final String name;
  late int b;
  final DateTime start = DateTime.now();

  ProfileMark(this.name){
    ProfileMark.unnamed();
    ProfileMark.whatEver();
  }
  ProfileMark.unnamed() : name = '';
  ProfileMark.whatEver() : b=10,name = '';
}
main(){

  ProfileMark p = ProfileMark('sss');
  print(p.b);
}

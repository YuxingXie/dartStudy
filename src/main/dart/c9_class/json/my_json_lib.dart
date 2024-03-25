import 'dart:mirrors';

class MyJsonLib<T extends Jsonable> {
  String toJson(T t) {
    // t.fields().forEach((element) {
    //   MapEntry entry = MapEntry(element, t.);
    // };)
    // var(a, b, d) = ("", "", "");
    InstanceMirror nameMirror = reflect(t).getField(Symbol("name"));
    // 调用对象方法
    ClassMirror classMirror = reflect(t).type;
    DeclarationMirror? methodMirror = classMirror.declarations[Symbol("name")];
    reflect(t).invoke(methodMirror!.simpleName, []);

    return '';
  }
}

abstract interface class Jsonable {
  // List<String> fields();
}

class User implements Jsonable {
  String name;
  String gender;
  User(this.name, this.gender);
}

main() {
  MyJsonLib().toJson(User("a", "b"));
}

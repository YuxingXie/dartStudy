class Student {
  String name;
  Student(this.name);
}

Future<String> getStudentName() async {
  //使用await同步了，但是阻塞了
  Student student = await findOne();
  return student.name;
}

Future<Student> findOne() {
  //不阻塞，但是返回的是Future
  return Future.value(Student('陈圆圆'));
}

main() async {
  //同步了但是也阻塞了
  String name = await getStudentName();
  Future<String> futureName =
      getStudentName().then((value) => value).catchError((e) => 'err');
}

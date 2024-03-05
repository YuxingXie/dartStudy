class Musician {
  // ...
}

mixin Performer {
  // ...
}
mixin MusicalPerformer on Musician {
  // ...
}
class SingerDancer extends Musician with MusicalPerformer {
  // ...
}
class Athletes with Performer{}

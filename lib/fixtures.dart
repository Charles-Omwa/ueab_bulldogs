import 'package:firebase_database/firebase_database.dart';



class Fixture {

  String _id;
  String _match;
  String _home;
  String _away;
  String _start_stop;
  String _quater;

  Fixture(this._id,this._match, this._home, this._away, this._start_stop, this._quater);

  String get match => _match;

  String get hometeam => _home;

  String get awayteam => _away;

  String get start_stop => _start_stop;

  String get quater => _quater;

  String get id => _id;

  Fixture.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _match = snapshot.value['match'];
    _home = snapshot.value['home'];
    _away = snapshot.value['away'];
    _start_stop = snapshot.value['start'];
    _quater = snapshot.value['quater'];
  }

}





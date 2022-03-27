import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BavaFirebaseUser {
  BavaFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

BavaFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BavaFirebaseUser> bavaFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<BavaFirebaseUser>((user) => currentUser = BavaFirebaseUser(user));

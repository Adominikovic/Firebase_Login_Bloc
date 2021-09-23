import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';

class UserAuthDetails {
  final bool isValid;
  final String? uid;
  final String? photoUrl;
  final String? name;
  final String? email;

  UserAuthDetails(this.isValid, this.uid, this.photoUrl, this.name, this.email);

  UserAuthDetails copyWith(
      bool isValid, String uid, String photoUrl, String name, String email) {
    return UserAuthDetails(isValid, uid, photoUrl, name, email);
  }
}

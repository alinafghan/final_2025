import 'package:firebase_auth/firebase_auth.dart';

class MyUser {
  String userId;
  String? username;
  String email;
  String? profileUrl;

  MyUser({
    required this.userId,
    this.username,
    required this.email,
    this.profileUrl,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'profileUrl': profileUrl,
    };
  }

  factory MyUser.fromFirebaseUser(User firebaseUser, {String? username}) {
    return MyUser(
      userId: firebaseUser.uid,
      email: firebaseUser.email!,
      username: username,
      profileUrl: firebaseUser.photoURL,
    );
  }

  static MyUser fromDocument(Map<String, dynamic> doc) {
    return MyUser(
      userId: doc['userId'],
      username: doc['username'],
      email: doc['email'],
      profileUrl: doc['profileUrl'],
    );
  }

  MyUser copyWith({
    String? userId,
    String? username,
    String? email,
  }) {
    return MyUser(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'userId: $userId, username: $username, email: $email';
  }
}

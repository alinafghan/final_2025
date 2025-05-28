import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:final_2025/models/my_user.dart';
// import 'package:journal_app/repositories/user_repository.dart';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class AuthRepository {
  final Logger _logger = Logger();
  final usersCollection = FirebaseFirestore.instance.collection('Users');

  AuthRepository({
    FirebaseAuth? firebaseAuth,
  }) : _auth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  Stream<User?> get user {
    return _auth.authStateChanges().map((firebaseUser) {
      //just check whether user is authenticaated or not
      final user = firebaseUser;
      return user;
    });
  }

  Future<MyUser> getCurrentUser() async {
    try {
      User? firebaseUser = _auth.currentUser;
      return MyUser.fromFirebaseUser(firebaseUser!);
    } on SocketException {
      _logger.e('No internet connection. Check your Wi-Fi or mobile data.');
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      throw Exception('User not found $e');
    }
  }

  Future<MyUser?> emailSignUp(MyUser user, String password) async {
    try {
      user.userId = const Uuid().v4(); //generate random user id
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      FirebaseFirestore.instance
          .collection('MyUser')
          .doc(user.userId)
          .set(user.toDocument());
      //copywith method
      return user.copyWith(userId: credentials.user!.uid);
    } on SocketException {
      _logger.e('No internet connection. Check your Wi-Fi or mobile data.');
      throw Exception('No internet connection. Please check your network.');
    } on FirebaseAuthException catch (e) {
      _logger.e("FirebaseAuthException: ${e.message}");
    }
    return null;
  }

  Future<void> saveUserToFirestore(MyUser user) async {
    await FirebaseFirestore.instance
        .collection('MyUser')
        .doc(user.userId)
        .set(user.toDocument());
  }

  Future<User?> emailLogin(String emailOrUsername, String password) async {
    String email = '';

    if (RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(emailOrUsername)) {
      email = emailOrUsername;
    } else {
      email = await getEmailFromUsername(emailOrUsername);
    }

    if (email == '') {
      _logger.e('email not found');
      return null;
    }

    try {
      UserCredential credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credentials.user;
    } on SocketException {
      _logger.e('No internet connection. Check your Wi-Fi or mobile data.');
      throw Exception('No internet connection. Please check your network.');
    } on FirebaseAuthException catch (e) {
      _logger.e("FirebaseAuthException: ${e.message}");
    }
    return null;
  }

  Future<User?> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      _logger.e("FirebaseAuthException: ${e.message}");
    }
    return null;
  }

  Future<UserCredential> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } on SocketException {
      _logger.e('No internet connection. Check your Wi-Fi or mobile data.');
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      _logger.e("Error signing in with Google: $e");
      throw Exception("Error signing in with Google: $e");
    }
  }

  //helper functions
  Future<String> getEmailFromUsername(String username) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore
          .instance //set trules to ensure that MyUser can access this.
          .collection("MyUser")
          .where("username", isEqualTo: username)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.get("email") as String;
      }
    } catch (e) {
      _logger.e("Error while fetching the email from username: $e");
    }
    return ""; // Return an empty string if no match is found
  }

  Future<void> deleteUser() async {
    try {
      MyUser currentUser = await getCurrentUserFromFirebase();

      await FirebaseFirestore.instance
          .collection('MyUser')
          .doc(currentUser.userId)
          .delete();
    } on SocketException {
      _logger.e('No internet connection. Check your Wi-Fi or mobile data.');
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      _logger.e("Error deleting user: $e");
    }
  }

  Future<MyUser> getCurrentUserFromFirebase() async {
    try {
      MyUser? user = await getCurrentUser();

      if (user == null) {
        throw Exception("User is not logged in");
      }

      QuerySnapshot querySnapshot = await usersCollection
          .where('email', isEqualTo: user.email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        return MyUser.fromDocument(doc.data() as Map<String, dynamic>);
      } else {
        throw Exception("No user found with the given email.");
      }
    } on SocketException {
      _logger.e('No internet connection. Check your Wi-Fi or mobile data.');
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      throw Exception("Failed to fetch user: $e");
    }
  }

  Future<void> setUser(MyUser user) async {
    try {
      await usersCollection.doc(user.userId).set(user.toDocument());
    } on SocketException {
      _logger.e('No internet connection. Check your Wi-Fi or mobile data.');
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      _logger.e('Error while setting user: $e');
      return;
    }
  }
}

extension on User {
  /// Maps a [firebase_auth.User] into a [User].
  MyUser toUser(String userName) {
    return MyUser(userId: uid, email: email!, username: userName);
  }
}

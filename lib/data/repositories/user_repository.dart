import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(
    FirebaseFirestore.instance,
    FirebaseAuth.instance,
  );
});

class UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserRepository(this._firestore, this._auth);

  User? get currentUser => _auth.currentUser;

  Stream<UserModel?> getUserData() {
    if (currentUser == null) return Stream.value(null);
    return _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return UserModel.fromJson(snapshot.data()!);
      }
      return null;
    });
  }

  Future<void> saveUserData(UserModel user) async {
    // If not authenticated, we can sign in anonymously for MVP
    if (currentUser == null) {
      await _auth.signInAnonymously();
    }

    final uid = currentUser!.uid;
    final userWithId = user.copyWith(id: uid); // Ensure ID matches auth ID

    await _firestore
        .collection('users')
        .doc(uid)
        .set(userWithId.toJson(), SetOptions(merge: true));
  }
}

import 'package:study_group_app/models/user.dart';
import 'package:study_group_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final String uid;

  UserService({this.uid});

  // A reference to the users collection in Firebase
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  // Updates (sets if doesn't exist) user Data in users collection
  Future updateUserFields(
      String email, String userName, String firstName, String lastName) async {
    return await userCollection.document(uid).setData({
      'email': email,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  // Updates user name within the 'users' collection
  Future updateUserName(String userName) async {
    try {
      await userCollection
        .document(uid)
        .updateData({'userName': userName});
        return 1;
    } catch (error) {
      return null;
    }
  }

  // Updates first name within the 'users' collection
  Future updateFirstName(String firstName) async {
    return await userCollection
        .document(uid)
        .updateData({'firstName': firstName});
  }

  // Updates last name within the 'users' collection
  Future updateLastName(String lastName) async {
    return await userCollection
      .document(uid)
      .updateData({'lastName': lastName});
  }

  // Updates email within the 'users' collection
  Future updateEmail(String email, String curPassword) async {
    //final Auth _auth = Auth();
    var _auth = Auth();
    var result = await _auth.changeFirebaseUserEmail(email, curPassword);
    if(result == 1)
    {
      print('Successfully changed user email.');
      return await userCollection
        .document(uid)
        .updateData({'email': email}); 
    }
    else {
      print('Could not change user email.');
      return null;
    }
  }

  // Updates the current user's password
  Future updatePassword(String email, String curPassword, String newPassword) async {
    //final Auth _auth = Auth();
    var _auth = Auth();
    dynamic result = await _auth.changePassword(curPassword, newPassword);
    if(result == 1) {
      print('Successfully changed user password.');
      return null;
    }
    else {
      print('Incorrect password/username.');
      return 1;
    }
  }

  // Provides stream of user data to the app
  Stream<User> get userData {
    // return userCollection.document(uid).snapshots().map(_userData);
    return userCollection
      .document(uid)
      .snapshots()
      .map((snap) => User.fromFirestore(snap));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  // userID of User is used as document name
  final String userID;
  var userRole;
  DatabaseService(this.userID);

  // user refers to collection User, where all documents (all users) get stored
  final CollectionReference user = Firestore.instance.collection('User');

  // if document with name userID exists, return true, otherwise create one
  Future checkIfUserExists() async {
    if ((await user.document(userID).get()).exists) {
      return true;
    } else {
      await user.document(userID).setData({
        'newUser': true,
      });
      return false;
    }
  }

  // return stream with user collections
  Stream<DocumentSnapshot> getDataStream() {
    return user.document(userID).snapshots();
  }

  // store new role for a specific user
  Future setUserRole(String role) async {
    return await user.document(userID).updateData({
      userRole: role,
    });
  }

  // delete role
  Future deleteUserRole() async {
    return await user.document(userID).updateData({
      userRole: FieldValue.delete(),
    });
  }

  Stream getMyRole() {
    return user.document(userID).snapshots();
  }
}
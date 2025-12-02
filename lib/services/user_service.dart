import 'package:aiyurapp/models/media_list_model.dart';
import 'package:aiyurapp/models/user_model.dart';
import 'package:aiyurapp/modules/database_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  UserService._();
  static final UserService instance = UserService._();
  final DatabaseConfig _databaseConfig = DatabaseConfig.instance;
  late final _database = _databaseConfig.database;
  late final String _collectionName = _databaseConfig.userCollectionName;

  Future<void> registerUserInDatabase(User user) async {
    print("Ristrando usuário no database..."); // TODO remover debug
    final UserModel userModel = UserModel(
        userUid: user.uid,
        nickname: user.email!,
        mediaLists: [
          MediaListModel(
              listName: "Favorites",
              mediaList: [],
          )
        ],
    );
    await setUserDocumentInDataBase(userModel);
  }

  Future<void> setUserDocumentInDataBase(UserModel userModel) async {
    print("Creating user document in database..."); // TODO remover debug
    if(await checkDocumentByUserUid(userModel.userUid) == null) {
      await _database.collection(_collectionName).doc(userModel.userUid).set(userModel.toJson());
    }
  }

  Future<DocumentSnapshot?> checkDocumentByUserUid(String? userUid) async {
    if(userUid == null) {
      return null;
    }
    DocumentSnapshot userDoc = await _database.collection(_collectionName).doc(userUid).get();
    if(userDoc.exists) {
      return userDoc;
    }
    return null;
  }

  Future<UserModel?> getUserData(String? userUid) async {
    print("Getting user data..."); // TODO remove debug
    if(userUid != null) {
      var _doc = await _database.collection(_collectionName).doc(userUid).get();
      var _data = _doc.data();

      UserModel userModel;
      if(_data != null) {
        print("User model from JSON..."); // TODO remove debug
        userModel = UserModel.fromJson(_data);
        print(userModel.toJson());
        return userModel;
      }
    }
    return null;
  }
}
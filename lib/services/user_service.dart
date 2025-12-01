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
    final List<MediaListModel> mediaListModelList = [
      MediaListModel(listName: "Favorites",
          mediaList: []
      )
    ];
    final UserModel userModel = UserModel(
        userUid: user.uid,
        nickname: user.email!,
        mediaLists: mediaListModelList,
    );
    await createNewUserDocument(userModel);
  }

  Future<void> createNewUserDocument(UserModel userModel) async {
    if(await checkDocumentByUserUid(userModel.userUid) == null) {
      await _database.collection(_collectionName).doc(userModel.userUid).set({
        "user_uid": userModel.userUid,
        "nickname": userModel.nickname,
        "biography": userModel.biography,
        "mediaLists": userModel.mediaLists,
      });
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
}
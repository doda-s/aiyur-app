import 'package:aiyurapp/models/media_list_model.dart';

class UserModel {
  String userUid;
  String nickname;
  String? biography;
  List<MediaListModel> mediaLists;

  UserModel({
    required this.userUid,
    required this.nickname,
    this.biography,
    required this.mediaLists,
  });
}
import 'package:aiyurapp/models/media_list_item_model.dart';

class MediaListModel {
  String listName;
  List<MediaListItemModel> mediaList;

  MediaListModel({
    required this.listName,
    required this.mediaList,
  });
}
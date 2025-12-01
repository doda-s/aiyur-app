import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseConfig {
  DatabaseConfig._();
  static final DatabaseConfig instance = DatabaseConfig._();
  final FirebaseFirestore database = FirebaseFirestore.instance;
  final String userCollectionName = "users";
}
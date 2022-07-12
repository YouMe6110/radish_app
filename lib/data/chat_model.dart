import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radish_app/constants/data_keys.dart';

/// chatKey : ""
/// msg : ""
/// createdData : "2012-04-21T18:25:43-05:00"
/// userKey : ""
/// referece : ""

class ChatModel {
  String? chatKey;
  late String msg;
  late DateTime createdData;
  late String userKey;
  DocumentReference? reference;

  ChatModel({
    required this.msg,
    required this.createdData,
    required this.userKey,
    this.reference,
  });

  ChatModel.fromJson(Map<String, dynamic> json, this.chatKey, this.reference) {
    msg = json[DOC_MSG] ?? "";
    createdData = json[DOC_CREATEDDATE] ?? DateTime.now();
    userKey = json[DOC_USERKEY] ?? "";
  }

  ChatModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.id, snapshot.reference);

  ChatModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[DOC_MSG] = msg;
    map[DOC_CREATEDDATE] = createdData;
    map[DOC_USERKEY] = userKey;
    return map;
  }
}

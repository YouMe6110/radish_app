import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:radish_app/constants/data_keys.dart';

/// itemKey : ""
/// itemTitle : ""
/// itemAddress : ""
/// itemPrice : 0.0
/// sellerKey : ""
/// buyerKey : ""
/// sellerImage : ""
/// buyerImage : ""
/// geoFirePoint : ""
/// lastMsg : ""
/// lastMsgTime : "2012-04-21T18:25:43-05:00"
/// lastMsgUserKey : ""
/// chatRoomKey : ""

class ChatroomModel {
  late String itemKey;
  late String itemTitle;
  late String itemAddress;
  late num itemPrice;
  late String sellerKey;
  late String buyerKey;
  late String sellerImage;
  late String buyerImage;
  late GeoFirePoint geoFirePoint;
  late String lastMsg;
  late DateTime lastMsgTime;
  late String lastMsgUserKey;
  late String chatRoomKey;
  DocumentReference? reference;

  ChatroomModel(
      {required this.itemKey,
      required this.itemTitle,
      required this.itemAddress,
      required this.itemPrice,
      required this.sellerKey,
      required this.buyerKey,
      required this.sellerImage,
      required this.buyerImage,
      required this.geoFirePoint,
      required this.lastMsg,
      required this.lastMsgTime,
      required this.lastMsgUserKey,
      required this.chatRoomKey,
      this.reference});

  ChatroomModel.fromJson(
      Map<String, dynamic> json, this.chatRoomKey, this.reference) {
    itemKey = json[DOC_ITEMKEY] ?? "";
    itemTitle = json[DOC_ITEMTITLE] ?? "";
    itemAddress = json[DOC_ITEMADDRESS] ?? "";
    itemPrice = json[DOC_ITEMPRICE] ?? 0;
    sellerKey = json[DOC_SELLERKEY] ?? "";
    buyerKey = json[DOC_BUYERKEY] ?? "";
    sellerImage = json[DOC_SELLERIMAGE] ?? "";
    buyerImage = json[DOC_BUYERIMAGE] ?? "";
    geoFirePoint = json[DOC_GEOFIREPOINT] == null
        ? GeoFirePoint(0, 0)
        : GeoFirePoint((json[DOC_GEOFIREPOINT][DOC_GEOPOINT]).latitude,
            (json[DOC_GEOFIREPOINT][DOC_GEOPOINT]).longitude);
    lastMsg = json[DOC_LASTMSG];
    lastMsgTime = json[DOC_LASTMSGTIME] == null
        ? DateTime.now().toUtc()
        : (json[DOC_LASTMSGTIME] as Timestamp).toDate();
    lastMsgUserKey = json[DOC_LASTMSGUSERKEY] ?? "";
    chatRoomKey = json[DOC_CHATROOMKEY] ?? "";
  }

  ChatroomModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.id, snapshot.reference);

  ChatroomModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[DOC_ITEMKEY] = itemKey;
    map[DOC_ITEMTITLE] = itemTitle;
    map[DOC_ITEMADDRESS] = itemAddress;
    map[DOC_ITEMPRICE] = itemPrice;
    map[DOC_SELLERKEY] = sellerKey;
    map[DOC_BUYERKEY] = buyerKey;
    map[DOC_SELLERIMAGE] = sellerImage;
    map[DOC_BUYERIMAGE] = buyerImage;
    map[DOC_GEOFIREPOINT] = geoFirePoint.data;
    map[DOC_LASTMSG] = lastMsg;
    map[DOC_LASTMSGTIME] = lastMsgTime;
    map[DOC_LASTMSGUSERKEY] = lastMsgUserKey;
    map[DOC_CHATROOMKEY] = chatRoomKey;
    return map;
  }

  static String generateChatRoomKey(String buyer, String itemKey) {
    return '${itemKey}_$buyer';
  }
}

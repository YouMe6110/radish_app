import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class UserModel {
  late String userKey; //유저 고유키값(파이어베이스)
  late String phoneNumber; // 핸드폰 번호
  late String address; // 주소
  late GeoFirePoint geoFirePoint; // 좌표값으로 자동생성(파이어베이스)
  late DateTime createdDate; // 가입일시(파이어베이스)
  DocumentReference? reference; // Document 고유키값(파이어베이스)

  UserModel({
    required this.userKey,
    required this.phoneNumber,
    required this.address,
    required this.geoFirePoint,
    required this.createdDate,
    this.reference,
  });

  UserModel.fromJson(Map<String, dynamic> json, this.userKey, this.reference) {
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    geoFirePoint = GeoFirePoint((json['geoFirePoint']['geopoint']).latitude,
        (json['geoFirePoint']['geopoint']).longitude);
    createdDate = json['createdDate'] == null
        ? DateTime.now().toUtc()
        : (json['createdDate'] as Timestamp).toDate();
  }

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = phoneNumber;
    map['address'] = address;
    map['geoPoint'] = geoFirePoint.data;
    map['createdDate'] = createdDate;
    return map;
  }
}

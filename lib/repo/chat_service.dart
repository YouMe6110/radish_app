import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radish_app/constants/data_keys.dart';
import 'package:radish_app/data/chat_model.dart';
import 'package:radish_app/data/chatroom_model.dart';

class ChatService {
  //singleton함수생성 => 하나의 생성자로 다른 인스턴스를 선언할 필요없음.
  static final ChatService _chatService = ChatService._internal();

  factory ChatService() => _chatService;

  ChatService._internal();

  // todo: 1) 신규 chatRoom DB 생성
  Future createNewChatroom(ChatroomModel chatroomModel) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_CHATROOMS).doc(
            ChatroomModel.generateChatRoomKey(
                chatroomModel.buyerKey, chatroomModel.itemKey));
    final DocumentSnapshot documentSnapshot = await documentReference.get();
    if (!documentSnapshot.exists) {
      await documentReference.set(chatroomModel.toJson());
    }
  }

  // todo: 2) 신규 chat DB 생성
  Future createdNewChat(String chatroomKey, ChatModel chatModel) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection(COL_CHATROOMS)
            .doc(chatroomKey)
            .collection(COL_CHATS)
            .doc();

    DocumentReference<Map<String, dynamic>> chatroomDocRef =
        FirebaseFirestore.instance.collection(COL_CHATROOMS).doc(chatroomKey);

    await documentReference.set(chatModel.toJson());

    // 최근 메세지와 작성한 유저 DB 저장하기
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatModel.toJson());

      transaction.update(chatroomDocRef, {
        DOC_LASTMSG: chatModel.msg,
        DOC_LASTMSGTIME: chatModel.createdData,
        DOC_LASTMSGUSERKEY: chatModel.userKey
      });
    });
  }

  // todo: 3) chatRoom 실시간 연동 / 싱크 맞추기
  Stream<ChatroomModel> connectChatroom(String chatroomKey) {
    return FirebaseFirestore.instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .snapshots()
        .transform(snapshotToChatroom);
  }

  var snapshotToChatroom = StreamTransformer<
      DocumentSnapshot<Map<String, dynamic>>,
      ChatroomModel>.fromHandlers(handleData: (snapshot, sink) {
    ChatroomModel chatroom = ChatroomModel.fromSnapshot(snapshot);
    sink.add(chatroom);
  });

  // todo: 4) chat list 정보 가져오기
  Future<List<ChatModel>> getChatList(String chatroomKey) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .collection(COL_CHATS)
        .orderBy(DOC_CREATEDDATE, descending: true)
        .limit(10)
        .get();

    List<ChatModel> chatlist = [];

    snapshot.docs.forEach((docSnapshot) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(docSnapshot);
      chatlist.add(chatModel);
    });
    return chatlist;
  }

  // todo: 5) 최근 chat 가져오기
  Future<List<ChatModel>> getLatestChats(
      String chatroomKey, DocumentReference currentLatestChatRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .collection(COL_CHATS)
        .orderBy(DOC_CREATEDDATE, descending: true)
        .endAtDocument(await currentLatestChatRef.get())
        .get();

    List<ChatModel> chatlist = [];

    snapshot.docs.forEach((docSnapshot) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(docSnapshot);
      chatlist.add(chatModel);
    });
    return chatlist;
  }

  // todo: 6) 지난(과거) chat 가져오기
  Future<List<ChatModel>> getOlderChats(
      String chatroomKey, DocumentReference oldestChatRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .collection(COL_CHATS)
        .orderBy(DOC_CREATEDDATE, descending: true)
        .limit(10)
        .startAfterDocument(await oldestChatRef.get())
        .get();

    List<ChatModel> chatlist = [];

    snapshot.docs.forEach((docSnapshot) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(docSnapshot);
      chatlist.add(chatModel);
    });
    return chatlist;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_healthapp/models/chat_room_model.dart';
import 'package:mental_healthapp/models/message_model.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository());

class ChatRepository {
  Future<ChatRoomModel> createOrGetChatRoom(String otherUserName) async {
    String userId1 = FirebaseAuth.instance.currentUser!.uid;
    String chatRoomId = constructChatRoomId(userId1, otherUserName);

    final chatRoomSnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .get();
    if (!chatRoomSnapshot.exists) {
      await FirebaseFirestore.instance.collection('chats').doc(chatRoomId).set({
        'chatRoomId': chatRoomId,
        'members': [userId1, otherUserName],
        'lastMessage': null,
        'timestamp': DateTime.now().toIso8601String(),
      });
    }

    return ChatRoomModel(
      roomId: chatRoomId,
      memberIds: [userId1, otherUserName],
      lastMessage: null,
      otherMemberName: otherUserName,
      timestamp: DateTime.now(),
    );
  }

  String constructChatRoomId(String userId1, String userId2) {
    List<String> sortedIds = [userId1, userId2]..sort();
    return '${sortedIds[0]}_${sortedIds[1]}';
  }

  Future<void> sendMessage(String chatRoomId, MessageModel message) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatRoomId)
          .collection('messages')
          .add(message.toMap());

      String answer = await fetchAnswer(message.message);
      if (answer.isNotEmpty) {
        MessageModel answerMessage = MessageModel(
          message: answer,
          senderId: 'system',
          timestamp: DateTime.now(),
        );
        await FirebaseFirestore.instance
            .collection('chats')
            .doc(chatRoomId)
            .collection('messages')
            .add(answerMessage.toMap());
      }

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatRoomId)
          .update({
        'timestamp': DateTime.now().toIso8601String(),
        'lastMessage': message.message,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<String> fetchAnswer(String questionString) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('messages')
              .where('question', isEqualTo: questionString)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        var answerDoc = querySnapshot.docs.first;

        String answer = answerDoc['answer'];

        return answer;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  Stream<List<MessageModel>> getChatMessages(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => MessageModel.fromMap(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }
}

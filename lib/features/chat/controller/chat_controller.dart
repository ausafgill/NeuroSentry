import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_healthapp/features/chat/repository/chat_repository.dart';
import 'package:mental_healthapp/models/chat_room_model.dart';
import 'package:mental_healthapp/models/message_model.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.read(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository);
});

class ChatController {
  ChatController({required this.chatRepository});
  final ChatRepository chatRepository;

  Future<ChatRoomModel> createOrGetChatRoom(String otherUserName) async {
    return chatRepository.createOrGetChatRoom(otherUserName);
  }

  Stream<List<MessageModel>> getChatMessages(String chatRoomId) {
    return chatRepository.getChatMessages(chatRoomId);
  }

  Future sendMessage(String chatRoomId, MessageModel message) async {
    await chatRepository.sendMessage(chatRoomId, message);
  }
}

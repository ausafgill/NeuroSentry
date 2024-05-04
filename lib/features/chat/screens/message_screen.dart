import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthapp/features/chat/controller/chat_controller.dart';
import 'package:mental_healthapp/features/chat/screens/ai_consultant_screen.dart';
import 'package:mental_healthapp/features/chat/screens/chat_consultant_screen.dart';
import 'package:mental_healthapp/features/chat/screens/chat_user_screen.dart';
import 'package:mental_healthapp/models/chat_room_model.dart';
import 'package:mental_healthapp/shared/loading.dart';

class MessageScreen extends ConsumerStatefulWidget {
  static const routeName = '/message-screen';
  const MessageScreen({super.key});

  @override
  ConsumerState<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  Future messageAi() async {
    ChatRoomModel chatRoom = await ref
        .read(chatControllerProvider)
        .createOrGetOneToOneChatRoom("NeuroSentry Bot", true);

    if (mounted) {
      Navigator.pushNamed(
        context,
        ChatAiScreen.routeName,
        arguments: [chatRoom],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("MESSAGES", style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<List<ChatRoomModel>>(
        stream: ref.read(chatControllerProvider).userChatRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<ChatRoomModel> chats = snapshot.data!;
            if (chats.isEmpty) {
              return const Center(
                child: Text('No Messages'),
              );
            }
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return MessageTile(
                  chat: chats[index],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: messageAi,
        backgroundColor: Colors.teal,
        child: const Text(
          "AI",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final ChatRoomModel chat;

  const MessageTile({super.key, required this.chat});

  openChat(BuildContext context) {
    if (chat.isConsultant) {
      if (chat.otherMemberName == "NeuroSentry Bot") {
        Navigator.pushNamed(context, ChatAiScreen.routeName, arguments: [chat]);
      } else {
        Navigator.pushNamed(context, ChatConsultantScreen.routeName,
            arguments: [chat]);
      }
    } else {
      Navigator.pushNamed(
        context,
        ChatUserScreen.routeName,
        arguments: [chat],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openChat(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: ListTile(
          title: Text(
            chat.otherMemberName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              chat.lastMessage ?? "New Chat",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          trailing: const Icon(FontAwesomeIcons.checkDouble),
        ),
      ),
    );
  }
}

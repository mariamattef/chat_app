import 'package:chat_app/constant.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/chat_cubit/chat_cubit.dart';

class ChatPage extends StatelessWidget {
  static const String id = 'ChatPage';
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Message> messageList = [];

  ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(kLogo),
                width: 70,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Chat',
                style: TextStyle(color: Colors.white),
              ),
            ],
          )

          // title: Text('Chat'),
          ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatSuccess) {
            messageList = state.messageList;
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBuble(message: messageList[index])
                          : ChatBubleForFriend(message: messageList[index]);
                    },
                    itemCount: messageList.length),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: controller,
                  onSubmitted: (data) {
                    BlocProvider.of<ChatCubit>(context)
                        .sendMessage(data, email.toString());

                    controller.clear();
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                  decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          child: const Icon(
                            Icons.send,
                            size: 26,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      )),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

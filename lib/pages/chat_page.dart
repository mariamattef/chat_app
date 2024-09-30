import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollection);
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
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
                image: AssetImage(KLogo),
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
      body: StreamBuilder<QuerySnapshot>(
          stream: messages.orderBy(KCreatedAt, descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Message> messageList = [];
              for (var doc in snapshot.data!.docs) {
                var data = doc.data() as Map<String, dynamic>;
                messageList.add(Message.fromJson(data));
              }
              return Column(children: [
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
                      messages.add({
                        KMessage: data,
                        KCreatedAt: DateTime.now(),
                        'id': email,
                      });

                      controller.clear();
                      _scrollController.animateTo(
                        0,
                        duration: Duration(microseconds: 500),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.send,
                            size: 26,
                            color: kPrimaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kPrimaryColor),
                        )),
                  ),
                )
              ]);
            } else {
              return Center(
                child: const CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

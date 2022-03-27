import 'package:chat/chat/message.dart';
import 'package:chat/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          DropdownButton(
            icon: const Icon(Icons.more_vert),
            underline:Container(),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout')
                  ],
                ),
                value:'logout',
              ),
            ],
            onChanged:(itemIdentifier){
              if(itemIdentifier=='logout'){
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body:Container(
        child: Column(
          children:const[
            Expanded(child: Message()),
            NewMessages(),

          ],
        ),
      ),
    );
  }
}

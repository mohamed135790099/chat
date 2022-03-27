import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _controller = TextEditingController();
  String _enterMessage = '';

  _sendMessage()async{
    FocusScope.of(context).unfocus();
    final user= FirebaseAuth.instance.currentUser;
    final userData=await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    print(user.uid);
   final username=userData.get('username');
   final userImage=userData.get('image_url');
   print(userImage);


    print(username);

    FirebaseFirestore.instance.collection('chat').add({
      'text': _enterMessage,
      'createAt': Timestamp.now(),
      'username':username,
      'userImage':userImage,
      'userId':user.uid,
    });
    _controller.clear();
    setState(() {
      _enterMessage = '';
    });
  }

  _emptyMessage() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Send Message'),
            onChanged: (val) {
              setState(() {
                _enterMessage = val;
              });
            },
          )),
          IconButton(
              color:Theme.of(context).primaryColor,
              icon: const Icon(Icons.send),
              onPressed: _enterMessage.trim().isNotEmpty
                  ? _sendMessage
                  : null)
        ],
      ),
    );
  }
}

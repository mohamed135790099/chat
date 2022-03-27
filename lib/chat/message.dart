import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_bubbles.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createAt', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = snapshot.data.docs;
        final user= FirebaseAuth.instance.currentUser;


        return ListView.builder(
          reverse: true,
        itemBuilder: (context, index) {
            return MessageBubbles(
              docs[index]['text'],
              docs[index]['username'],
              docs[index]['userImage'],
              docs[index]['userId']==user!.uid,
            key: ValueKey( docs[index]['userId']),
            );
          },
          itemCount: docs.length,
        );
      },
    );
  }
}

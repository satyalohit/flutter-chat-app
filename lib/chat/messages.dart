import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sixthapp/chat/Messagebubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (ctx, AsyncSnapshot<FirebaseUser>futuresnapshots) {
              if (futuresnapshots.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy('createat', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatsnapshot) {
        if (chatsnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final documents = chatsnapshot.data!.documents;
        return  ListView.builder(
                reverse: true,
                itemBuilder: (ctx, i) => Messagebubble(
                  documents[i]['texts'],
                  documents[i]['username'],
                  documents[i]['userimage'],
                  documents[i]['userid'] == futuresnapshots.data!.uid,
                  key: ValueKey(documents[i].documentID),
                ),
                itemCount: documents.length,
              );
            });
      },
    );
  }
}

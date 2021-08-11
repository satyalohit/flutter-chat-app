import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Newmessage extends StatefulWidget {
  @override
  _NewmessageState createState() => _NewmessageState();
}

class _NewmessageState extends State<Newmessage> {
  var newmessage = '';
  final _controller = new TextEditingController();

  void _sendmessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userdata =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'texts': newmessage,
      'createat': Timestamp.now(),
      'userid': user.uid,
      'username':userdata['username'],
      'userimage':userdata['image_url'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Send messages...',
              ),
              onChanged: (value) {
                setState(() {
                  newmessage = value;
                });
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              color: Theme.of(context).primaryColor,
              onPressed: newmessage.trim().isEmpty ? null : _sendmessage)
        ],
      ),
    );
  }
}

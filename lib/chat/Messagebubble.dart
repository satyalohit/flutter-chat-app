import 'package:flutter/material.dart';

class Messagebubble extends StatelessWidget {
  Messagebubble(this.message, this.username, this.userimageurl, this.isme,
      {required this.key});
  final String message;
  final bool isme;
  final String userimageurl;
  final Key key;
  final String username;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isme ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isme ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        !isme ? Radius.circular(0) : Radius.circular(12),
                    bottomRight:
                        isme ? Radius.circular(0) : Radius.circular(12)),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                  mainAxisAlignment:
                      isme ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      message,
                      style:
                          TextStyle(color: isme ? Colors.black : Colors.white),
                      textAlign: isme ? TextAlign.end : TextAlign.start,
                    ),
                  ]),
            )
          ],
        ),
        Positioned(
          top: -10,
          left: isme?null:120,
          right: isme?120:null,
          child: CircleAvatar(backgroundImage: NetworkImage(userimageurl),),
        )
      ],
      overflow: Overflow.visible,
    );
  }
}

import 'package:flutter/material.dart';
class MessageBubbles extends StatelessWidget {
  const MessageBubbles(this.message,  this.userName,this.userImg,this.isMe,{required this.key}) : super(key: key);
  final Key key;
  final String message;
  final String userName;
  final String userImg;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:isMe?MainAxisAlignment.end:MainAxisAlignment.start,
          children: [
            Container(
              padding:const EdgeInsets.symmetric(vertical:10 ,horizontal:16 ),
              margin:const EdgeInsets.symmetric(vertical:8,horizontal:8),
              decoration:BoxDecoration(
                color:isMe?Colors.grey[300]:Theme.of(context).accentColor,
                borderRadius:BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft:!isMe?const Radius.circular(0):const Radius.circular(16),
                  bottomRight:isMe?const Radius.circular(0):const Radius.circular(16),
                ),
              ),
             width:200,
              child:Column(
                crossAxisAlignment:isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
                children: [
                  Text(userName,style:TextStyle(
                      fontWeight:FontWeight.bold,
                      color:isMe?Colors.black: Theme.of(context).accentTextTheme.headline6!.color
                  ),),
                  Text(message,
                    style:TextStyle(
                        color:isMe?Colors.black: Theme.of(context).accentTextTheme.headline6!.color
                    ),
                    textAlign:isMe?TextAlign.end:TextAlign.start,
                  ),
                ],
              ),
            ),

          ],
        ),
        Positioned(
          top:-8,
          left:!isMe?175:null,
          right:isMe?175:null,
          child: CircleAvatar(
            backgroundImage:NetworkImage(userImg),
          ),
        ),
      ],
      overflow:Overflow.visible,
    );
  }
}

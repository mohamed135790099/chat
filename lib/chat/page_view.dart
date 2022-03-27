import 'package:flutter/material.dart';
class pageView extends StatelessWidget {
  const pageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.indigoAccent,
      body:Center(
        child:CircleAvatar(
          child:SingleChildScrollView(
            child: Column(
              children: const[
                Text('Welcome My Friend',style:TextStyle(color:Colors.white,fontSize:25),),
                CircularProgressIndicator(
                  color:Colors.grey,
                  strokeWidth:15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

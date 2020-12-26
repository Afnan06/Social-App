import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class chatscreen extends StatefulWidget {
  @override
  _chatscreenState createState() => _chatscreenState();
}
class _chatscreenState extends State<chatscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text("chat"),),
      body:
       Stack(
        children: [
          ListView(
           children: [
           //messages//

           ],
          ),
          Positioned(
            child: Align(
              alignment:Alignment.bottomCenter,
              child: TextFormField(
                decoration:InputDecoration(
                  suffixIcon:Icon(Icons.send_sharp),
                  border:OutlineInputBorder(
                      borderRadius: const BorderRadius.all(const Radius.circular(40.0))
                  ),
                  hintText:"enter message",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  final docu;

  const ChatPage({Key key, this.docu}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String groupChatId;
  String userID;
  String msg;
  String anotherUserId;
 // String anotherUserId;
  TextEditingController textEditingController = TextEditingController();

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    getGroupChatId();
    super.initState();
  }

  getGroupChatId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    userID = sharedPreferences.getString('id');

    anotherUserId = widget.docu['id'];
    print(userID);
    print(anotherUserId);

    if (userID.compareTo(anotherUserId) > 0) {
      groupChatId = '$userID - $anotherUserId';
    } else {
      groupChatId = '$anotherUserId - $userID';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("Chat"),
            backgroundColor: Colors.green[700],
            bottomOpacity: 0,
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(50)),
      backgroundColor: Colors.green[700],
//      appBar: AppBar(
//        title: Text("chat"),
//      ),
      body:


      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Messages')
              .doc(groupChatId)
              .collection(groupChatId)
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Column(
                //crossAxisAlignment:CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemBuilder: (listContext, index) =>
                            buildItem(snapshot.data.docs[index]),
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                      )),
                  //SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    Container(
                      decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                          decoration:InputDecoration(

                            suffixIcon: IconButton(icon:Icon(Icons.send),onPressed: (){sendMsg();},), border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 5.0),
                            borderRadius:BorderRadius.circular(20),
                          ),

                              ),

                              controller: textEditingController,
                            ),
                          ),
//                          IconButton(
//                            icon: Icon(Icons.send),
//                            onPressed: () => sendMsg(),
//                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                  child: SizedBox(
                    height: 36,
                    width: 36,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ));
            }
          },
        ),
      ),
    );
  }

  sendMsg() {
    msg = textEditingController.text.trim();

    /// Upload images to firebase and returns a URL

    if (msg.isNotEmpty) {
      print('thisiscalled $msg');
      var ref = FirebaseFirestore.instance
          .collection('Messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(ref, {
          "senderId": userID,
          "anotherUserId": widget.docu['id'],
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          'content': msg,
          "type": 'text',
        });
      });

      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
      textEditingController.text = '';
    } else {
      print('Please enter some text to send');
    }
  }

  buildItem(obj1) {
    return Padding(
      padding: EdgeInsets.only(
          top: 8.0,

       //  left: ((obj1['senderId'] == userID) ? 120 : 0),
         // right: ((obj1['senderId'] == userID) ? 0: 64),
      ),
      child: 
        ChatBubble(
          clipper: ChatBubbleClipper1(type:(obj1['senderId']==userID) ?BubbleType.sendBubble:BubbleType.receiverBubble

          ),alignment:(obj1['senderId']==userID) ?Alignment.topRight:Alignment.topLeft,
          backGroundColor: (obj1['senderId']==userID)?Colors.green:Colors.grey,


         child: Container(
        // width: MediaQuery.of(context).size.width,
//          height: 30,
        // padding: const EdgeInsets.all(8.0),
//          decoration: BoxDecoration(

//              color: ((obj1['senderId'] == userID)
//                  ? Colors.green
//                  : Colors.grey),
//           borderRadius:BorderRadius.only(
//               topLeft:((obj1['senderId']!=userID)?Radius.circular(0):Radius.circular(25)),
//               topRight: Radius.circular(25),
//               bottomRight:((obj1['senderId']!=userID)?Radius.circular(25):Radius.circular(0)),
//               bottomLeft: Radius.circular(25),
//
//           )
             // borderRadius: BorderRadius.circular(8.0)

        //  ),
          child: (obj1['type'] == 'text')
              ? Text('${obj1['content']}')
              : Image.network(obj1['content']),

        ),
    ));
  }
}

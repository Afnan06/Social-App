import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

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
      appBar: AppBar(
        title: Text("chat"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Messages')
            .doc(groupChatId)
            .collection(groupChatId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Column(
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemBuilder: (listContext, index) =>
                          buildItem(snapshot.data.docs[index]),
                      itemCount: snapshot.data.docs.length,
                      reverse: true,
                    )),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () => sendMsg(),
                    ),
                  ],
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
    } else {
      print('Please enter some text to send');
    }
  }

  buildItem(obj1) {
    return Padding(
      padding: EdgeInsets.only(
          top: 8.0,
          left: ((obj1['senderId'] == userID) ? 64 : 0),
          right: ((obj1['senderId'] == userID) ? 0 : 64)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: ((obj1['senderId'] == userID)
                ? Colors.grey
                : Colors.greenAccent),
            borderRadius: BorderRadius.circular(8.0)),
        child: (obj1['type'] == 'text')
            ? Text('${obj1['content']}')
            : Image.network(obj1['content']),
      ),
    );
  }
}

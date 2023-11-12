import 'package:flutter_e_commerce_app/consts/packege.dart';

class chat_screen extends StatefulWidget {
  final String friendname;
  final String friendid;

  const chat_screen({
    Key? key,
    required this.friendname,
    required this.friendid,
  }) : super(key: key);

  @override
  State<chat_screen> createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {
  @override
  void initState() {
    super.initState();
    friendname = widget.friendname;
    friendid = widget.friendid;
    initializeSenderName();
    getchatid();
    sendmsg(messagecontroller.text.toString());
  }

  var chats = firestore.collection('chats');
  late String friendname;
  late String friendid;
  var sendername = '';
  var currentuid = auth.currentUser!.uid;
  var messagecontroller = TextEditingController();
  var chatdocid;
  var isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(friendname),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            isloading
                ? Center(child: lodingindicator())
                : Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: firestoreservices
                            .getchatmessage(chatdocid.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: lodingindicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Some Things Wants Wrong'));
                          } else if (snapshot.hasData &&
                              snapshot.data!.docs.isNotEmpty) {
                            return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return Align(
                                    alignment:
                                        data['uid'] == auth.currentUser!.uid
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                    child: sender_babble(data));
                              }).toList(),
                            );
                          } else {
                            return Center(
                                child: Text(
                              'Send a message...',
                              style: TextStyle(fontSize: 20),
                            ));
                          }
                        })),
            Container(
              height: MediaQueryu.getScreenHeight(context) * .12,
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messagecontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendmsg(messagecontroller.text);
                      messagecontroller.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: redcolor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initializeSenderName() async {
    var hc = home_controller();
    await hc.getusername();
    setState(() {
      sendername = hc.username;
    });
  }

  getchatid() async {
    setState(() {
      isloading = true;
    });
    QuerySnapshot querySnapshot = await chats
        .where('users', isEqualTo: {
          friendid.toString(): null,
          currentuid.toString(): null,
        })
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      chatdocid = querySnapshot.docs.single.id;
    } else {
      chats.add({
        'created_on': null,
        'lastmsg': '',
        'users': {
          friendid.toString(): null,
          currentuid.toString(): null,
        },
        'toid': '',
        'fromid': '',
        'friend_name': friendname,
        'sender_name': sendername,
      }).then((value) {
        chatdocid = value.id;
        print('ChatDocID: $chatdocid');
      });
    }
    ;
    setState(() {
      isloading = false;
    });
  }

  sendmsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatdocid).update({
        'created_on': FieldValue.serverTimestamp(),
        'lastmsg': msg,
        'toid': friendid,
        'fromid': currentuid,
      });
      chats.doc(chatdocid).collection('messages').doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentuid,
      });
    }
  }
}

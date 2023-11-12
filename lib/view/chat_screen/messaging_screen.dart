import 'package:flutter_e_commerce_app/consts/packege.dart';

class messaging_screen extends StatefulWidget {
  const messaging_screen({Key? key}) : super(key: key);

  @override
  State<messaging_screen> createState() => _messaging_screenState();
}

class _messaging_screenState extends State<messaging_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Messaging Screen')),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreservices.getallmessage(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: lodingindicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('No messages yet!'));
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => chat_screen(
                                            friendname: data[index]
                                                ['friend_name'],
                                            friendid: data[index]['toid'])));
                              },
                              leading: CircleAvatar(
                                  backgroundColor: redcolor,
                                  child: Icon(
                                    Icons.person,
                                    color: whitecolor,
                                  )),
                              title: Text(data[index]['friend_name']),
                              subtitle: Text(data[index]['lastmsg']),
                            ),
                          );
                        }),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'No message yet!',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
          }),
    );
  }
}

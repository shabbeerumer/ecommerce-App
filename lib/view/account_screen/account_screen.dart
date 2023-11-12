import 'package:flutter_e_commerce_app/consts/packege.dart';

class account_screen extends StatefulWidget {
  const account_screen({Key? key}) : super(key: key);

  @override
  State<account_screen> createState() => _account_screenState();
}

class _account_screenState extends State<account_screen> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: firestoreservices.getuserdata(auth.currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs[0];

                return SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQueryu.getScreenWidth(context) * 0.06,
                            top: 10),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              edit_account_screen(
                                                data: data,
                                              )));
                                },
                                child: Icon(Icons.edit))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            data['imageurl'] == ''
                                ? CircleAvatar(
                                    radius: 40.0,
                                    backgroundColor: whitecolor,
                                    backgroundImage: AssetImage(
                                      'assets/icons/user.png',
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage:
                                        NetworkImage(data['imageurl']),
                                  ),
                            SizedBox(
                              width: MediaQueryu.getScreenWidth(context) * 0.02,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['name']),
                                  Text(data['email']),
                                ],
                              ),
                            ),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide()),
                                onPressed: () {
                                  signoutmethod(context);
                                },
                                child: Text(
                                  'Logout',
                                  style: TextStyle(color: blackcolor),
                                ))
                          ],
                        ),
                      ),
                      FutureBuilder(
                          future: firestoreservices.getcount(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return lodingindicator();
                            } else {
                              var countdata = snapshot.data;
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  detailcard(
                                      countdata[0].toString(),
                                      'in your cart',
                                      MediaQueryu.getScreenHeight(context) *
                                          0.11,
                                      MediaQueryu.getScreenWidth(context) *
                                          0.30),
                                  SizedBox(
                                    width: MediaQueryu.getScreenWidth(context) *
                                        0.01,
                                  ),
                                  detailcard(
                                      countdata[1].toString(),
                                      'in your wishlist',
                                      MediaQueryu.getScreenHeight(context) *
                                          0.11,
                                      MediaQueryu.getScreenWidth(context) *
                                          0.30),
                                  SizedBox(
                                    width: MediaQueryu.getScreenWidth(context) *
                                        0.01,
                                  ),
                                  detailcard(
                                      countdata[2].toString(),
                                      'in your order',
                                      MediaQueryu.getScreenHeight(context) *
                                          0.11,
                                      MediaQueryu.getScreenWidth(context) *
                                          0.30),
                                ],
                              );
                            }
                          }),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: profilebuttonlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                order_screen()));
                                    break;
                                  case 1:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                wishlist_screen()));
                                    break;
                                  case 2:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                messaging_screen()));
                                    break;
                                }
                              },
                              title: Text(
                                profilebuttonlist[index],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              leading: Image.asset(
                                profilebuttonicon[index],
                                width:
                                    MediaQueryu.getScreenWidth(context) * 0.04,
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: lightgreycolor,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(child: lodingindicator());
              }
            }));
  }
}

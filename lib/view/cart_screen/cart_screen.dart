import 'package:flutter_e_commerce_app/consts/packege.dart';

class cart_screen extends StatefulWidget {
  const cart_screen({Key? key}) : super(key: key);

  @override
  State<cart_screen> createState() => _cart_screenState();
}

class _cart_screenState extends State<cart_screen> {
  cart_controller cc = cart_controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Shopping cart'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreservices.getcarddata(auth.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: lodingindicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Some Things Went Wrong'));
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var data = snapshot.data!.docs;
            cc.setProductSnapshot(data);
            cc.getproductdetail();
            calculate(data);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          leading: Image.network(
                            data[index]['img'].toString(),
                            width: 120,
                          ),
                          title: Text(
                            "${data[index]['title']} (x${data[index]['qty']})",
                          ),
                          subtitle: Text(
                            data[index]['tprice'].toString(),
                            style: TextStyle(color: redcolor),
                          ),
                          trailing: InkWell(
                              onTap: () {
                                firestoreservices
                                    .deletecarddocument(data[index].id);
                              },
                              child: Icon(
                                Icons.delete,
                                color: redcolor,
                              )),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQueryu.getScreenHeight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('TotalPrice'),
                      Text(
                        cc.totalp.numCurrency,
                        style: TextStyle(color: redcolor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQueryu.getScreenHeight(context) * 0.01,
                  ),
                  Buttons('Proceed to shopping', context, redcolor, whitecolor,
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => shopping_screen(
                                  cc: cc,
                                )));
                  })
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'Card is empty',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
        },
      ),
    );
  }

  calculate(data) {
    cc.totalp = 0;
    for (var i = 0; i < data.length; i++) {
      cc.totalp = cc.totalp + int.parse(data[i]['tprice'].toString());
    }
  }
}

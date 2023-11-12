import 'package:flutter_e_commerce_app/consts/packege.dart';

class wishlist_screen extends StatefulWidget {
  const wishlist_screen({Key? key}) : super(key: key);

  @override
  State<wishlist_screen> createState() => _wishlist_screenState();
}

class _wishlist_screenState extends State<wishlist_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('wishlist_screen')),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreservices.getwishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: lodingindicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('some things wants wrong'));
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        leading: Image.network(
                          data[index]['p_images'][0].toString(),
                          width: 120,
                        ),
                        title: Text(
                          "${data[index]['p_name']}",
                        ),
                        subtitle: Text(
                          data[index]['p_price'].toString(),
                          style: TextStyle(color: redcolor),
                        ),
                        trailing: InkWell(
                            onTap: () {
                              firestore
                                  .collection('products')
                                  .doc(data[index].id)
                                  .set({
                                'p_wishlist': FieldValue.arrayRemove(
                                    [auth.currentUser!.uid])
                              }, SetOptions(merge: true));
                            },
                            child: const Icon(
                              Icons.favorite,
                              color: redcolor,
                            )),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text(
                'No order yet!',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
        },
      ),
    );
  }
}

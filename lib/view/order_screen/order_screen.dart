import 'package:flutter_e_commerce_app/consts/packege.dart';

class order_screen extends StatefulWidget {
  const order_screen({Key? key}) : super(key: key);

  @override
  State<order_screen> createState() => _order_screenState();
}

class _order_screenState extends State<order_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Screen')),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreservices.getallorder(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: lodingindicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('No order yet!'));
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      data[index]['order_code'],
                      style: const TextStyle(color: redcolor),
                    ),
                    subtitle: Text(
                      data[index]['total_amount'].toString(),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => order_detail_screen(
                                      data: data[index],
                                    )));
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                      ),
                    ),
                    leading: Text(
                      '${index + 1}',
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                });
          } else {
            return const Center(
                child: Text(
              'No order found!',
              style: TextStyle(fontSize: 20),
            ));
          }
        },
      ),
    );
  }
}

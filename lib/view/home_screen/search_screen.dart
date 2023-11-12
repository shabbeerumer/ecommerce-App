import 'package:flutter_e_commerce_app/consts/packege.dart';

class search_screen extends StatefulWidget {
  String title;
  search_screen({Key? key, required this.title}) : super(key: key);

  @override
  State<search_screen> createState() => _search_screenState();
}

class _search_screenState extends State<search_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: blackcolor,
                )),
            backgroundColor: whitecolor,
            title: Text(
              widget.title,
              style: TextStyle(color: blackcolor),
            )),
        body: FutureBuilder(
            future: firestoreservices.searchproducts(widget.title),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: lodingindicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No products found'));
              } else {
                var data = snapshot.data!.docs;
                var filltered = data
                    .where((element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(widget.title.toLowerCase()))
                    .toList();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 300,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 3.0,
                      ),
                      children: filltered
                          .mapIndexed((currentValue, index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              item_detail_screen(
                                                  title: filltered[index]
                                                      ['p_name'],
                                                  data: filltered[index])));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: greycolor,
                                            offset: Offset(0, 2),
                                            blurRadius: 6.0,
                                            spreadRadius: 2.0,
                                            blurStyle: BlurStyle.outer),
                                      ]),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        filltered[index]['p_images'][0]
                                            .toString(),
                                        height: 200,
                                        width: 200,
                                      ),
                                      Text(filltered[index]['p_name']),
                                      Text(
                                        filltered[index]['p_price'],
                                        style: TextStyle(color: redcolor),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList()),
                );
              }
            }));
  }
}

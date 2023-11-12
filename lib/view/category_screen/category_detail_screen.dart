import 'package:flutter_e_commerce_app/consts/packege.dart';

class category_detail_screen extends StatefulWidget {
  String title;
  var subcategories;
  category_detail_screen(
      {Key? key, required this.title, required this.subcategories})
      : super(key: key);

  @override
  State<category_detail_screen> createState() => _category_detail_screenState();
}

class _category_detail_screenState extends State<category_detail_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchcatogery(widget.title);
    print('widget.title: ${widget.title}');
    print('widget.subcategories: ${widget.subcategories}');
    print(widget.subcategories.contains(widget.title.toLowerCase()));
  }

  Product_Controller product_controller = Product_Controller();
  var productmethod;

  switchcatogery(title) {
    if (widget.subcategories.contains(title)) {
      productmethod = firestoreservices.getsubcatogariesproducts(title);
    } else {
      productmethod = firestoreservices.getproductdata(widget.title);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightgreycolor,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: List.generate(
                    widget.subcategories.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          switchcatogery(widget.subcategories[index]);
                          setState(() {});
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 70,
                          width: 150,
                          decoration: BoxDecoration(
                            color: redcolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              widget.subcategories[index],
                              style: const TextStyle(
                                color: whitecolor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * 0.02,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: productmethod,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(child: Center(child: lodingindicator()));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Some Things Wants Wrong'));
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    var data = snapshot.data!.docs;
                    return Expanded(
                      child: GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 3.0,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                await product_controller
                                    .checkisfav(data[index]);
                                print(data[index]['p_wishlist']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            item_detail_screen(
                                              title: data[index]['p_name'],
                                              data: data[index],
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: whitecolor,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.network(
                                          data[index]['p_images'][0].toString(),
                                          width: MediaQueryu.getScreenWidth(
                                                  context) *
                                              .25,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        data[index]['p_name'].toString(),
                                      ),
                                      Text(
                                        '${data[index]['p_price']}'.numCurrency,
                                        style: const TextStyle(color: redcolor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Expanded(
                      child: Center(
                          child: Text(
                        'No Product found!',
                        style: TextStyle(fontSize: 20),
                      )),
                    );
                  }
                }),
          ],
        ));
  }
}

import 'package:flutter_e_commerce_app/consts/packege.dart';

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  TextEditingController home_controller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreycolor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQueryu.getScreenHeight(context),
          width: MediaQueryu.getScreenWidth(context),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: home_controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: whitecolor,
                      hintText: 'search anything',
                      suffixIcon: InkWell(
                          onTap: () {
                            if (home_controller.text.isNotEmptyAndNotNull) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => search_screen(
                                          title: home_controller.text
                                              .toString())));
                            }
                          },
                          child: Icon(Icons.search))),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      CarouselSlider(
                        items: swiperlist.map((swiper) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              swiper,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                            autoPlay: true,
                            height: MediaQueryu.getScreenHeight(context) * 0.2,
                            enlargeCenterPage: true
                            // Customize carousel options here
                            ),
                      ),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          homebuttons(
                              "Today's deal",
                              'assets/icons/todays_deal.png',
                              MediaQueryu.getScreenHeight(context) * .20,
                              MediaQueryu.getScreenWidth(context) * .40,
                              () {},
                              MediaQueryu.getScreenHeight(context) * 0.10,
                              MediaQueryu.getScreenWidth(context) * 0.10),
                          SizedBox(
                            width: MediaQueryu.getScreenWidth(context) * 0.05,
                          ),
                          homebuttons(
                              "flash sale",
                              'assets/icons/flash_deal.png',
                              MediaQueryu.getScreenHeight(context) * .20,
                              MediaQueryu.getScreenWidth(context) * .40,
                              () {},
                              MediaQueryu.getScreenHeight(context) * 0.10,
                              MediaQueryu.getScreenWidth(context) * 0.10)
                        ],
                      ),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * 0.02,
                      ),
                      CarouselSlider(
                        items: secondswiperlist.map((secondswiperlist) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              secondswiperlist,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                            autoPlay: true,
                            height: MediaQueryu.getScreenHeight(context) * 0.2,
                            enlargeCenterPage: true
                            // Customize carousel options here
                            ),
                      ),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          homebuttons(
                              "Top Categories",
                              'assets/icons/top_categories.png',
                              MediaQueryu.getScreenHeight(context) * 0.15,
                              MediaQueryu.getScreenWidth(context) * 0.30,
                              () {},
                              MediaQueryu.getScreenHeight(context) * 0.10,
                              MediaQueryu.getScreenWidth(context) * 0.10),
                          SizedBox(
                            width: MediaQueryu.getScreenWidth(context) * 0.02,
                          ),
                          homebuttons(
                              "brands",
                              'assets/icons/brands.png',
                              MediaQueryu.getScreenHeight(context) * 0.15,
                              MediaQueryu.getScreenWidth(context) * 0.30,
                              () {},
                              MediaQueryu.getScreenHeight(context) * 0.10,
                              MediaQueryu.getScreenWidth(context) * 0.10),
                          SizedBox(
                            width: MediaQueryu.getScreenWidth(context) * 0.02,
                          ),
                          homebuttons(
                              "Top Sellers",
                              'assets/icons/top_sellers.png',
                              MediaQueryu.getScreenHeight(context) * 0.15,
                              MediaQueryu.getScreenWidth(context) * 0.30,
                              () {},
                              MediaQueryu.getScreenHeight(context) * 0.10,
                              MediaQueryu.getScreenWidth(context) * 0.10),
                        ],
                      ),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          height: 260,
                          width: double.infinity,
                          decoration: BoxDecoration(color: redcolor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQueryu.getScreenHeight(context) * 0.01,
                              ),
                              const Text(
                                'featured product',
                                style: TextStyle(
                                    color: whitecolor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                    MediaQueryu.getScreenHeight(context) * 0.01,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream:
                                      firestoreservices.getfeaturedproducts(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: lodingindicator());
                                    } else if (snapshot.hasError) {
                                      return const Center(
                                          child:
                                              Text('some things wants wrong'));
                                    } else if (snapshot.hasData &&
                                        snapshot.data!.docs.isNotEmpty) {
                                      var fetureddata = snapshot.data!.docs;
                                      return Row(
                                          children: List.generate(
                                              fetureddata.length,
                                              (index) => InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => item_detail_screen(
                                                                  title: fetureddata[
                                                                          index]
                                                                      [
                                                                      'p_name'],
                                                                  data: fetureddata[
                                                                      index])));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: whitecolor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Image.network(
                                                            fetureddata[index]
                                                                ['p_images'][0],
                                                            width: 130,
                                                            height: 130,
                                                          ),
                                                          Text(
                                                              fetureddata[index]
                                                                  ['p_name']),
                                                          Text(
                                                            fetureddata[index]
                                                                ['p_price'],
                                                            style:
                                                                const TextStyle(
                                                                    color:
                                                                        redcolor),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )));
                                    } else {
                                      return const Center(
                                        child: Text(
                                          'No fetured products',
                                          style: TextStyle(
                                              fontSize: 20, color: whitecolor),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      CarouselSlider(
                        items: secondswiperlist.map((secondswiperlist) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              secondswiperlist,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                            autoPlay: true,
                            height: MediaQueryu.getScreenHeight(context) * 0.2,
                            enlargeCenterPage: true
                            // Customize carousel options here
                            ),
                      ),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * 0.02,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '    All Products',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * 0.01,
                      ),
                      StreamBuilder(
                          stream: firestoreservices.getallproducts(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: lodingindicator());
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('some things wants wrong'));
                            } else if (snapshot.hasData &&
                                snapshot.data!.docs.isNotEmpty) {
                              var allproductsdata = snapshot.data!.docs;
                              return GridView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: allproductsdata.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisExtent: 300,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10.0,
                                          crossAxisSpacing: 3.0),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    item_detail_screen(
                                                        title: allproductsdata[
                                                            index]['p_name'],
                                                        data: allproductsdata[
                                                            index])));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: whitecolor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              allproductsdata[index]['p_images']
                                                      [0]
                                                  .toString(),
                                              height: 200,
                                              width: 200,
                                            ),
                                            Text(allproductsdata[index]
                                                ['p_name']),
                                            Text(
                                              allproductsdata[index]['p_price'],
                                              style: TextStyle(color: redcolor),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return Center(
                                child: Text(
                                  'No products',
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

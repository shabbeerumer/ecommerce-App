import 'package:flutter_e_commerce_app/consts/packege.dart';

class item_detail_screen extends StatefulWidget {
  var title;
  var data;
  item_detail_screen({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  State<item_detail_screen> createState() => _item_detail_screenState();
}

class _item_detail_screenState extends State<item_detail_screen> {
  var colorindex = 0;
  var quantity = 0;
  var totalprice = 0;
  Product_Controller product_controller = Product_Controller();
  void initState() {
    super.initState();
    product_controller.checkisfav(widget.data);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toString()),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(
            onPressed: () async {
              setState(() {
                if (product_controller.isfav == true) {
                  product_controller.removefromwishlist(
                      widget.data.id, context);
                  product_controller.isfav = false;
                } else {
                  product_controller.addtowishlist(widget.data.id, context);
                  product_controller.isfav = true;
                }
              });
            },
            icon: Icon(Icons.favorite_outlined,
                color: product_controller.isfav == true
                    ? redaccentcolor
                    : bluegreycolor),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                itemCount: widget.data['p_images'].length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Image.network(
                    widget.data['p_images'][0].toString(),
                    fit: BoxFit.cover,
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  height: MediaQueryu.getScreenHeight(context) * 0.4,
                  enlargeCenterPage: true,
                  // Customize carousel options here
                ),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: MediaQueryu.getScreenHeight(context) * 0.03),
              ),
              VxRating(
                isSelectable: false,
                value: double.parse(widget.data['p_rating']),
                normalColor: lightgreycolor,
                selectionColor: yellowcolor,
                count: 5,
                maxRating: 5,
                size: MediaQueryu.getScreenHeight(context) * 0.04,
                onRatingUpdate: (value) {},
              ),
              Text(
                '${widget.data['p_price']}'.numCurrency,
                style: TextStyle(
                    color: redcolor,
                    fontSize: MediaQueryu.getScreenHeight(context) * 0.03),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: MediaQueryu.getScreenHeight(context) * 0.09,
                color: lightgreycolor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Seller',
                          style: TextStyle(
                              fontSize:
                                  MediaQueryu.getScreenHeight(context) * 0.02),
                        ),
                        Text(
                          widget.data['p_seller'],
                          style: TextStyle(
                              fontSize:
                                  MediaQueryu.getScreenHeight(context) * 0.02),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => chat_screen(
                                friendname: widget.data['p_seller'],
                                friendid: widget.data['vender_id'],
                              ),
                            ));
                      },
                      child: CircleAvatar(
                        backgroundColor: whitecolor,
                        child: Icon(
                          Icons.message_outlined,
                          color: blackcolor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Container(
                color: lightgreycolor,
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Color',
                        ),
                        SizedBox(
                          width: MediaQueryu.getScreenWidth(context) * 0.25,
                        ),
                        Row(
                          children: List.generate(
                            widget.data['p_colors'].length,
                            (index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                VxBox()
                                    .size(40.0, 40.0)
                                    .margin(EdgeInsets.symmetric(horizontal: 2))
                                    .roundedFull
                                    .color(Color(int.parse(
                                        widget.data['p_colors'][index])))
                                    .make()
                                    .onTap(() {
                                  changecolorindex(index);
                                }),
                                Visibility(
                                  visible: index == colorindex,
                                  child: Icon(
                                    Icons.done,
                                    color: whitecolor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Quantity',
                        ),
                        SizedBox(
                          width: MediaQueryu.getScreenWidth(context) * 0.18,
                        ),
                        Row(children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (quantity > 0) {
                                    quantity--;
                                    calculatetotalprice(widget.data['p_price']);
                                  } else {}
                                });
                              },
                              icon: Icon(Icons.remove)),
                          Text(quantity.toString()),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (quantity <
                                      int.parse(widget.data['p_quantity'])) {
                                    quantity++;
                                    calculatetotalprice(widget.data['p_price']);
                                  } else {}
                                });
                              },
                              icon: Icon(Icons.add)),
                          SizedBox(
                            width: MediaQueryu.getScreenWidth(context) * 0.01,
                          ),
                          Text(
                            widget.data['p_quantity'],
                          ),
                        ]),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'total',
                        ),
                        SizedBox(
                          width: MediaQueryu.getScreenWidth(context) * 0.30,
                        ),
                        Row(children: [
                          Text(
                            '${totalprice}'.numCurrency,
                            style: TextStyle(color: redcolor),
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Text('Description'),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Text(widget.data['p_description']),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                    itemdetailbuttonlist.length,
                    (index) => ListTile(
                          trailing: Icon(Icons.arrow_forward),
                          title: Text(itemdetailbuttonlist[index]),
                        )),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Text('Product you may also like'),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(
                        6,
                        (index) => Container(
                              decoration: BoxDecoration(
                                  color: whitecolor,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/p1.jpeg',
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Text('LapTop 4GB/6GB'),
                                  Text(
                                    "\$600",
                                    style: TextStyle(color: redcolor),
                                  )
                                ],
                              ),
                            ))),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Buttons('add to cart', context, redcolor, whitecolor, () {
                if (quantity > 0) {
                  product_controller.addtocart(
                    widget.data['p_name'],
                    widget.data['p_images'][0],
                    widget.data['p_seller'],
                    widget.data['p_colors'][colorindex],
                    quantity,
                    totalprice,
                    context,
                    widget.data['vender_id'],
                  );
                  VxToast.show(context, msg: 'Added to cart');
                } else {
                  VxToast.show(context, msg: "Quentity can't be 0");
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  calculatetotalprice(price) {
    totalprice = int.parse(price) * quantity;
  }

  changecolorindex(index) {
    setState(() {
      colorindex = index;
    });
  }
}

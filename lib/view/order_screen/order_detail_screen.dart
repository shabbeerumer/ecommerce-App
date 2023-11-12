import 'package:flutter_e_commerce_app/consts/packege.dart';
import 'package:intl/intl.dart' as intl;

class order_detail_screen extends StatelessWidget {
  var data;
  order_detail_screen({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Detail')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              order_status(
                  Icons.done, redcolor, 'Placed', data['order_placed']),
              order_status(Icons.thumb_up_alt_sharp, bluecolor, 'Confirmed',
                  data['order_confirmed']),
              order_status(Icons.car_crash, orangecolor, 'On Delivery',
                  data['order_on_delivery']),
              order_status(Icons.done_all, purplecolor, 'Delivered',
                  data['order_delivered']),
              Divider(),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: greycolor,
                      offset: Offset(0, 2), // X and Y offsets for the shadow
                      blurRadius: 6.0, // Spread of the shadow
                      spreadRadius: 2.0,
                      blurStyle: BlurStyle
                          .outer // Positive values will expand the shadow
                      ),
                ]),
                child: Column(
                  children: [
                    orderplacedetail('Order code', data['order_code'],
                        'Shipping Method', data['shipping_method']),
                    SizedBox(
                      height: MediaQueryu.getScreenHeight(context) * 0.01,
                    ),
                    orderplacedetail(
                        'Order date',
                        intl.DateFormat()
                            .add_yMd()
                            .format(data['order_date'].toDate()),
                        'Payment Method',
                        data['payment_method']),
                    SizedBox(
                      height: MediaQueryu.getScreenHeight(context) * 0.01,
                    ),
                    orderplacedetail('Payment Status', 'unpaid',
                        'Delivery Status', 'Order Status'),
                    SizedBox(
                      height: MediaQueryu.getScreenHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Shipping Address'),
                            Text(data['order_by_name']),
                            Text(data['order_by_email']),
                            Text(data['order_by_address']),
                            Text(data['order_by_city']),
                            Text(data['order_by_state']),
                            Text(data['order_by_phone']),
                            Text(data['order_by_postalcode']),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Ammount'),
                            Text(
                              data['total_amount'].toString(),
                              style: TextStyle(color: redcolor),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              const Text(
                'Ordered Product',
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: greycolor,
                      offset: Offset(0, 1), // X and Y offsets for the shadow
                      blurRadius: 4.0, // Spread of the shadow
                      spreadRadius: 2.0,
                      blurStyle: BlurStyle
                          .outer // Positive values will expand the shadow
                      ),
                ]),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(data['orders'].length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderplacedetail(
                            data['orders'][index]['title'],
                            '${data['orders'][index]['qty']}x',
                            data['orders'][index]['tprice'].toString(),
                            'Refundable'),
                        Container(
                            width: 30,
                            height: 20,
                            color: Color(
                                int.parse(data['orders'][index]['color']))),
                        Divider()
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

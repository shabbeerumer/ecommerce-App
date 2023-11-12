import 'package:flutter_e_commerce_app/consts/packege.dart';

class cart_controller {
  TextEditingController address_controller = TextEditingController();
  TextEditingController city_controller = TextEditingController();
  TextEditingController state_controller = TextEditingController();
  TextEditingController postalcode_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  home_controller hc = home_controller();
  var totalp = 0;
  var products = [];
  var productsnapshot;
  var venders = [];

  setProductSnapshot(data) {
    productsnapshot = data;
    print(productsnapshot);
  }

  placemyorder(orderpaymentmethod, totalamount) async {
    await setProductSnapshot(productsnapshot);
    print(productsnapshot);
    await getproductdetail();
    await firestore.collection('orders').doc().set({
      'order_code': '1234567890',
      'order_date': FieldValue.serverTimestamp(),
      'order_by': auth.currentUser!.uid,
      'order_by_name': hc.username,
      'order_by_email': auth.currentUser!.email,
      'order_by_address': address_controller.text,
      'order_by_state': state_controller.text,
      'order_by_city': city_controller.text,
      'order_by_phone': phone_controller.text,
      'order_by_postalcode': postalcode_controller.text,
      'shipping_method': 'Home Delivery',
      'payment_method': orderpaymentmethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalamount,
      'orders': FieldValue.arrayUnion(products),
      'venders': FieldValue.arrayUnion(venders)
    });
  }

  getproductdetail() {
    products.clear();
    venders.clear();
    for (var i = 0; i < productsnapshot.length; i++) {
      print(productsnapshot.length);
      products.add({
        'color': productsnapshot[i]['color'],
        'img': productsnapshot[i]['img'],
        'vender_id': productsnapshot[i]['vender_id'],
        'tprice': productsnapshot[i]['tprice'],
        'qty': productsnapshot[i]['qty'],
        'title': productsnapshot[i]['title'],
      });
      venders.add(productsnapshot[i]['vender_id']);
    }
  }

  clearcart() {
    for (var i = 0; i < productsnapshot.length; i++) {
      firestore.collection('cart').doc(productsnapshot[i].id).delete();
    }
  }
}

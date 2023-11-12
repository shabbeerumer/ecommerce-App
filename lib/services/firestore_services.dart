import 'package:flutter_e_commerce_app/consts/packege.dart';

class firestoreservices {
  static getuserdata(uid) {
    return firestore.collection('auth').where('id', isEqualTo: uid).snapshots();
  }

  static getproductdata(catogery) {
    return firestore
        .collection('products')
        .where('p_catogery', isEqualTo: catogery)
        .snapshots();
  }

  static getcarddata(uid) {
    return firestore
        .collection('cart')
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deletecarddocument(docid) {
    return firestore.collection('cart').doc(docid).delete();
  }

  static getchatmessage(docid) {
    return firestore
        .collection('chats')
        .doc(docid)
        .collection('messages')
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getallorder() {
    return firestore
        .collection('orders')
        .where('order_by', isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  static getwishlist() {
    return firestore
        .collection('products')
        .where('p_wishlist', arrayContains: auth.currentUser!.uid)
        .snapshots();
  }

  static getallmessage() {
    return firestore
        .collection('chats')
        .where('fromid', isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  static getcount() async {
    var res = await Future.wait([
      firestore
          .collection('cart')
          .where('added_by', isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection('products')
          .where('p_wishlist', arrayContains: auth.currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection('orders')
          .where('order_by', isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }

  static getallproducts() {
    return firestore.collection('products').snapshots();
  }

  static getfeaturedproducts() {
    return firestore
        .collection('products')
        .where('is_featured', isEqualTo: true)
        .snapshots();
  }

  static searchproducts(title) {
    return firestore.collection('products').get();
  }

  static getsubcatogariesproducts(title) {
    return firestore
        .collection('products')
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }
}

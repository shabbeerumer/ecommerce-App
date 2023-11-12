import 'package:flutter_e_commerce_app/consts/packege.dart';

class Product_Controller {
  var categories = [];
  var isfav = false;
  final uid = auth.currentUser!.uid.toString();

  Future loadJsonData() async {
    final String jsonString =
        await rootBundle.loadString('lib/services/categorie_model.json.dart');
    var decodedData = jsonDecode(jsonString);
    var sl = Categoriemodal.fromJson(decodedData);
    for (var category in sl.categories!) {
      categories.add(category);
    }
  }

  addtocart(
      title, img, sellername, color, qty, tprice, context, vender_id) async {
    await firestore.collection('cart').doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'vender_id': vender_id,
      'tprice': tprice,
      'added_by': uid
    }).onError((error, stackTrace) =>
        VxToast.show(context, msg: 'Something went wrong'));
  }

  addtowishlist(docid, context) async {
    try {
      await firestore.collection('products').doc(docid).set({
        'p_wishlist': FieldValue.arrayUnion([uid])
      }, SetOptions(merge: true));
      isfav = true;
      VxToast.show(context, msg: 'Added to wishlist');
      print(uid);
    } catch (e) {
      print(e.toString());
    }
  }

  removefromwishlist(docid, context) async {
    try {
      await firestore.collection('products').doc(docid).set({
        'p_wishlist': FieldValue.arrayRemove([uid])
      }, SetOptions(merge: true));
      isfav = false;
      VxToast.show(context, msg: 'Removed from wishlist');
      print(uid);
    } catch (e) {
      print(e.toString());
    }
  }

  checkisfav(data) {
    try {
      if (data['p_wishlist'].contains(uid)) {
        isfav = true;
      } else {
        isfav = false;
      }
    } catch (e) {
      print('Error checking if item is in wishlist: $e');
      isfav = false; // Default to false in case of error
    }
  }
}

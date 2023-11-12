import 'package:flutter_e_commerce_app/consts/packege.dart';

class home_controller {
  var username = '';
  getusername() async {
    var value = await firestore
        .collection('auth')
        .where('id', isEqualTo: auth.currentUser!.uid)
        .get();

    if (value.docs.isNotEmpty) {
      username = value.docs.single['name'];
    }
  }
}

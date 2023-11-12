import 'package:flutter_e_commerce_app/consts/packege.dart';

Future<void> signinmethod(String email, String password, context) async {
  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  } catch (error) {
    VxToast.show(context, msg: 'Something went wrong');
    throw error; // Throw the error to handle it in the calling code if needed
  }
}

Future<void> showuserdata(String name, String email, String password,
    String conformpassword, context) async {
  try {
    await firestore.collection('auth').doc(auth.currentUser!.uid).set({
      'name': name,
      'email': email,
      'password': password,
      'conformpassword': conformpassword,
      'imageurl': '',
      'id': auth.currentUser!.uid,
      'cart count': '00',
      'wishlist count': '00',
      'order count': '00',
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const login_screen()));
  } catch (error) {
    VxToast.show(context, msg: 'Something went wrong');
    throw error; // Throw the error to handle it in the calling code if needed
  }
}

signoutmethod(context) async {
  try {
    await auth.signOut();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const signin_screen()));
  } catch (error) {
    VxToast.show(context, msg: 'some things wants wrong');
  }
}

loginmethod(String email, String password, context) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const home()));
  } catch (error) {
    VxToast.show(context, msg: 'some things wants wrong');
  }
}

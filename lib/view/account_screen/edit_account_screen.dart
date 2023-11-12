import 'package:flutter_e_commerce_app/consts/packege.dart';

class edit_account_screen extends StatefulWidget {
  var data;
  edit_account_screen({Key? key, required this.data}) : super(key: key);

  @override
  State<edit_account_screen> createState() => _edit_account_screenState();
}

class _edit_account_screenState extends State<edit_account_screen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController oldpasswordcontroller = TextEditingController();
  TextEditingController newpasswordcontroller = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();
    namecontroller.text = widget.data['name'].toString();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQueryu.getScreenHeight(context) * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              child: ClipOval(
                child: (widget.data['imageurl'] == '' &&
                        (profileimagepath == null ||
                            profileimagepath!.path.isEmpty))
                    ? Image.asset(
                        'assets/icons/user.png',
                        fit: BoxFit.cover,
                      )
                    : (widget.data['imageurl'] != '' &&
                            (profileimagepath == null ||
                                profileimagepath!.path.isEmpty))
                        ? Image.network(
                            widget.data['imageurl'],
                            fit: BoxFit.cover,
                          )
                        : (profileimagepath != null &&
                                !profileimagepath!.path.isEmpty)
                            ? Image.file(
                                File(profileimagepath!.path),
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/profile_image_joya_ahsan.jpg',
                                fit: BoxFit.cover,
                              ),
              ),
            ),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * 0.02,
            ),
            Buttons('change', context, redcolor, whitecolor, () {
              change_image(context);
            }),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * 0.02,
            ),
            Divider(),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * 0.02,
            ),
            textformfieldwidget('name', context, namecontroller, false),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * 0.02,
            ),
            textformfieldwidget(
                ' oldpassword', context, oldpasswordcontroller, true),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * 0.02,
            ),
            textformfieldwidget(
                ' newpassword', context, newpasswordcontroller, true),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * 0.02,
            ),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * 0.02,
            ),
            loading
                ? lodingindicator()
                : Buttons('save', context, redcolor, whitecolor, () async {
                    setState(() {
                      loading = true;
                    });
                    var imageUrl = await _uploadFile();
                    await updateProfile(
                        namecontroller.text,
                        imageUrl,
                        oldpasswordcontroller.text,
                        newpasswordcontroller.text,
                        widget.data['email']);
                    setState(() {
                      loading = false;
                    });
                  })
          ],
        ),
      ),
    );
  }

  File? profileimagepath;
  Future change_image(BuildContext context) async {
    try {
      final pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 70);

      if (pickedFile != null) {
        setState(() {
          profileimagepath = File(pickedFile.path);
        });
      } else {}
    } catch (error) {
      VxToast.show(context, msg: 'Something went wrong');
    }
  }

  Future<String?> _uploadFile() async {
    if (profileimagepath == null) {
      return '';
    }

    FirebaseStorage _storage = FirebaseStorage.instance;
    Reference storageRef =
        _storage.ref().child('images/${auth.currentUser!.uid.toString()}.jpg');
    UploadTask uploadTask = storageRef.putFile(profileimagepath!.absolute);
    TaskSnapshot downloadUrl = await uploadTask;
    final url = await downloadUrl.ref.getDownloadURL();
    return url; // Return the download URL
  }

  Future<void> updateProfile(String name, imageUrl, String oldPassword,
      String newPassword, email) async {
    try {
      // Verify user's existing password
      if (oldPassword.isNotEmpty) {
        final cred =
            EmailAuthProvider.credential(email: email, password: oldPassword);
        await auth.currentUser!.reauthenticateWithCredential(cred);

        // User wants to change the password
        if (newPassword.isNotEmpty) {
          await auth.currentUser!.updatePassword(newPassword);
        } else {}
      } else {}

      // Update user profile data in Firestore
      await firestore.collection('auth').doc(auth.currentUser!.uid).update(
          {'name': name, 'password': newPassword, 'imageurl': imageUrl});

      VxToast.show(context, msg: 'Updated');
    } catch (e) {
      VxToast.show(context, msg: 'Something went wrong');
      print('Error updating profile: $e');
    }
  }
}

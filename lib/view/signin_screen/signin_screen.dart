import 'package:flutter_e_commerce_app/consts/packege.dart';

class signin_screen extends StatefulWidget {
  const signin_screen({Key? key}) : super(key: key);

  @override
  State<signin_screen> createState() => _signin_screenState();
}

class _signin_screenState extends State<signin_screen> {
  bool ischeck = false;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController conformpasswordcontroller = TextEditingController();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQueryu.getScreenHeight(context),
          width: MediaQueryu.getScreenWidth(context),
          child: Column(
            children: [
              Image.asset(
                'assets/images/eCommerce.png',
                width: MediaQueryu.getScreenWidth(context) * .60,
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              textformfieldwidget('name', context, namecontroller, false),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              textformfieldwidget('email', context, emailcontroller, false),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              textformfieldwidget(
                  'Password', context, passwordcontroller, true),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              textformfieldwidget(
                  'Conform Password', context, conformpasswordcontroller, true),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    activeColor: orangecolor,
                    value: ischeck,
                    onChanged: (newvalue) {
                      setState(() {
                        ischeck = newvalue!;
                      });
                    },
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'I agree to the',
                          style: TextStyle(color: greycolor),
                        ),
                        TextSpan(
                          text: ' Terms and Conditions ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: orangecolor),
                        ),
                        TextSpan(
                          text: '& ',
                          style: TextStyle(color: greycolor),
                        ),
                        TextSpan(
                          text: '\n PrivacyPolicy',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: orangecolor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isloading
                  ? lodingindicator()
                  : Buttons(
                      'signin',
                      context,
                      ischeck == true ? redcolor : lightgreycolor,
                      whitecolor, () async {
                      if (ischeck == true) {
                        setState(() {
                          isloading = true;
                        });
                        try {
                          await signinmethod(emailcontroller.text.toString(),
                              passwordcontroller.text.toString(), context);

                          await showuserdata(
                              namecontroller.text,
                              emailcontroller.text,
                              passwordcontroller.text,
                              conformpasswordcontroller.text,
                              context);
                        } catch (e) {
                          setState(() {
                            isloading = false;
                          });
                          VxToast.show(context, msg: 'Something went wrong');
                        }
                      } else {
                        VxToast.show(context,
                            msg: 'Please agree to the terms and condition');
                      }
                    }),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an accoumt ? "),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const login_screen()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: orangecolor),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

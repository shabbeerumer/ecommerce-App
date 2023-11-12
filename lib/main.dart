import 'package:flutter_e_commerce_app/consts/packege.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: ThemeData(
              appBarTheme: AppBarTheme(elevation: 0.0, color: redcolor)),
          debugShowCheckedModeBanner: false,
          title: 'ECommerce App',
          home: child,
        );
      },
      child: const splash_screen(),
    );
  }
}

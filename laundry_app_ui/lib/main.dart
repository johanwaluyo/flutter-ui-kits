import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry_app_ui/pages/dashboard.dart';
import 'package:laundry_app_ui/pages/home.dart';
import 'package:laundry_app_ui/pages/login.dart';
import 'package:laundry_app_ui/pages/single_order.dart';
import 'package:laundry_app_ui/pages/view_all.dart';
import 'package:laundry_app_ui/utils/constants.dart';
import 'package:laundry_app_ui/pages/launching.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Laundry UI",
        theme: ThemeData(
          scaffoldBackgroundColor: Constants.scaffoldBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        initialRoute: "/",
        home: new LauncherPage(),
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Home();
      });
    case "/login":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Login();
      });
    case "/dashboard":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Dashboard();
      });
    // case "/single-order":
    //   return MaterialPageRoute(builder: (BuildContext context) {
    //     return SingleOrder( detailOrder: ,);
    //   });
    case "/viewall":
      return MaterialPageRoute(builder: (BuildContext context) {
        return ViewAll();
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return Home();
      });
  }
}

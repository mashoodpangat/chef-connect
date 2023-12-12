import 'package:chef_connect_project/API/ApiProvider.dart';
import 'package:chef_connect_project/API/Stateprovider.dart';
import 'package:chef_connect_project/FoodItemCategories/ProductCategories.dart';
import 'package:chef_connect_project/FoodItemCategories/SubCategories.dart';
import 'package:chef_connect_project/ToggleSwitch.dart';

import 'package:chef_connect_project/splashscreen.dart';
import 'package:chef_connect_project/styleUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => Stateprovider()),
      ],
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: splashscreen(),
        );
      }),
    );
  }
}

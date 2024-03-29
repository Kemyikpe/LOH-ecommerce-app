import 'package:flutter/material.dart';
import 'package:loh_ecommerce_app/routes/locator.dart';
import 'package:loh_ecommerce_app/routes/routes.dart';
import 'package:loh_ecommerce_app/services/navigation_service.dart';
import 'package:loh_ecommerce_app/views/home_page.dart';
import 'package:loh_ecommerce_app/views/view_model/app_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  ///setup dependency injector
  dependenciesInjectorSetup();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppViewModel())
        ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      navigatorKey: getIt<NavigationService>().navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            primary: Colors.white,
            inversePrimary: Colors.white
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white
      ),
      home: const AppHomePage(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}





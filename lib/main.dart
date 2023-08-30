import 'package:flutter/material.dart';
import 'package:flutter_bloc1/presentation/app_router.dart';

void main() {
  runApp(MyApp(
    appRouter: Approuter(),
  ));
}

class MyApp extends StatelessWidget {
  final Approuter appRouter;

  const MyApp({super.key, required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute, //!to make navigation
    );
  }
}

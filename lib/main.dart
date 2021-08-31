import 'package:comet_news/core/constants/palette.dart';
import 'package:comet_news/core/route_generator.dart';
import 'package:comet_news/core/service_locator.dart';
import 'package:comet_news/features/view_news/presenter/notifiers/view_news_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServices();
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ViewNewsNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'COMET News',
        onGenerateRoute: RouteGenerator.generateRoutes,
        onGenerateInitialRoutes: RouteGenerator.generateInitialRoutes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Palette.deepBlue,
        ),
        builder: (context, child) => ResponsiveWrapper.builder(
          child,
          minWidth: 280,
          maxWidth: 1200,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(280, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ],
        ),
      ),
    );
  }
}

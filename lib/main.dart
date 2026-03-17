import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_food_app/core/theme/app_colors.dart';
import 'core/di/dependency_injection.dart';
import 'core/router/app_router.dart';
import 'core/router/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xvkqxowbijcabrpdfpte.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2a3F4b3diaWpjYWJycGRmcHRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM3NTYxNTgsImV4cCI6MjA4OTMzMjE1OH0.LSI_vT1cS1BlGJIjZfa0S0S3MQdBNp6zFhFfrQ4xYzE',
  );

  await initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'FoodHub',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.white,
          ),
          onGenerateRoute: getIt<AppRouter>().generateRoute,
          initialRoute: Supabase.instance.client.auth.currentSession != null
              ? Routes.main
              : Routes.onboarding,
        );
      },
    );
  }
}

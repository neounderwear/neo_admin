import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/app/main_screen.dart';
import 'package:neo_admin/constant/theme.dart';
import 'package:neo_admin/features/banner/presentation/ui/banner_screen.dart';
import 'package:neo_admin/features/brand/presentation/ui/brand_screen.dart';
import 'package:neo_admin/features/category/presentation/ui/category_screen.dart';
import 'package:neo_admin/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:neo_admin/features/login/presentation/login_screen.dart';
import 'package:neo_admin/features/product/presentation/ui/product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) => const MainScreen(name: 'Herlan'),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/banner',
        builder: (context, state) => BannerScreen(),
      ),
      GoRoute(
        path: '/category',
        builder: (context, state) => CategoryScreen(),
      ),
      GoRoute(
        path: '/brand',
        builder: (context, state) => BrandScreen(),
      ),
      GoRoute(
        path: '/product',
        builder: (context, state) => ProductScreen(),
      ),
    ],
    initialLocation: '/main',
    debugLogDiagnostics: true,
    routerNeglect: true,
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Admin | GPD',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(context),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

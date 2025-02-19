import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/app/main_screen.dart';
import 'package:neo_admin/constant/theme.dart';
import 'package:neo_admin/features/banner/presentation/ui/banner_screen.dart';
import 'package:neo_admin/features/brand/presentation/ui/brand_screen.dart';
import 'package:neo_admin/features/category/presentation/ui/category_screen.dart';
import 'package:neo_admin/features/customer/presentation/customer_screen.dart';
import 'package:neo_admin/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:neo_admin/features/login/main/login_screen.dart';
import 'package:neo_admin/features/order/presentation/order_screen.dart';
import 'package:neo_admin/features/product/presentation/ui/add_product_screen.dart';
import 'package:neo_admin/features/product/presentation/ui/product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GlobalKey<NavigatorState> _rootNavigatorKey;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _rootNavigatorKey = GlobalKey<NavigatorState>();

    _router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/login',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        ShellRoute(
          navigatorKey: _rootNavigatorKey,
          builder: (context, state, child) {
            return MainScreen(name: "Herlan");
          },
          routes: [
            GoRoute(
              path: '/main/dashboard',
              builder: (context, state) => const DashboardScreen(),
            ),
            GoRoute(
              path: '/main/banner',
              builder: (context, state) => const BannerScreen(),
            ),
            GoRoute(
              path: '/main/category',
              builder: (context, state) => const CategoryScreen(),
            ),
            GoRoute(
              path: '/main/brand',
              builder: (context, state) => const BrandScreen(),
            ),
            GoRoute(
              path: '/main/product',
              builder: (context, state) => const ProductScreen(),
            ),
            GoRoute(
              path: '/main/order',
              builder: (context, state) => const OrderScreen(),
            ),
            GoRoute(
              path: '/main/customer',
              builder: (context, state) => const CustomerScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/add-product',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const AddProductScreen(),
        ),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Admin | GPD',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(context),
      routerConfig: _router,
    );
  }
}

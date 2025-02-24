import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/app/main_screen.dart';
import 'package:neo_admin/constant/theme.dart';
import 'package:neo_admin/features/banner/bloc/banner_bloc.dart';
import 'package:neo_admin/features/banner/data/banner_service.dart';
import 'package:neo_admin/features/banner/view/ui/banner_screen.dart';
import 'package:neo_admin/features/brand/bloc/brand_bloc.dart';
import 'package:neo_admin/features/brand/data/brand_service.dart';
import 'package:neo_admin/features/brand/view/ui/brand_screen.dart';
import 'package:neo_admin/features/category/bloc/category_bloc.dart';
import 'package:neo_admin/features/category/data/category_service.dart';
import 'package:neo_admin/features/category/view/ui/category_screen.dart';
import 'package:neo_admin/features/customer/presentation/customer_screen.dart';
import 'package:neo_admin/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:neo_admin/features/login/bloc/login_bloc.dart';
import 'package:neo_admin/features/login/main/login_screen.dart';
import 'package:neo_admin/features/order/presentation/order_screen.dart';
import 'package:neo_admin/features/product/bloc/product_bloc.dart';
import 'package:neo_admin/features/product/data/product_service.dart';
import 'package:neo_admin/features/product/view/ui/product_form_widget.dart';
import 'package:neo_admin/features/product/view/ui/product_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wovklugpxmjwinfeaded.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndvdmtsdWdweG1qd2luZmVhZGVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAyMDQ2MzIsImV4cCI6MjA1NTc4MDYzMn0.EvYq1oi4tnF4Ix19ZBV4RGaKVsl1lli8hXb1VXcVXFI',
  );
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
          path: '/tambah-produk',
          builder: (context, state) => ProductFormWidget(),
        )
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => BrandBloc(BrandService())),
        BlocProvider(create: (context) => CategoryBloc(CategoryService())),
        BlocProvider(create: (context) => BannerBloc(BannerService())),
        BlocProvider(
          create: (context) => ProductBloc(
            ProductService(Supabase.instance.client),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Admin | GPD',
        // debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(context),
        routerConfig: _router,
        // routeInformationParser: _router.routeInformationParser,
        // routerDelegate: _router.routerDelegate,
        // routeInformationProvider: _router.routeInformationProvider,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/app/main_screen.dart';
import 'package:neo_admin/app/supabase_helper.dart';
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
import 'package:neo_admin/features/product/view/ui/product_form_screen.dart';
import 'package:neo_admin/features/product/view/ui/product_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseHelper().url,
    anonKey: SupabaseHelper().anonKey,
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
          builder: (context, state) {
            // The extra data will be null for adding a new product
            final productData = state.extra as Map<String, dynamic>?;
            return ProductFormScreen(product: productData);
          },
        )
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => BrandBloc(BrandService())),
        BlocProvider(create: (context) => CategoryBloc(CategoryService())),
        BlocProvider(create: (context) => BannerBloc(BannerService())),
        BlocProvider(
          create: (context) => ProductBloc(ProductService(supabase)),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/app/main_layout.dart';
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
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await dotenv.load(fileName: ".env");
  } else {
    await dotenv.load(fileName: ".env");
  }

  // Inisialisasi Supabase
  await Supabase.initialize(
    url: dotenv.env['URL']!,
    anonKey: dotenv.env['ANONKEY']!,
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

  // Konfigurasi GoRouter untuk navigasi dalam aplikasi
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
        // Rute utama aplikasi
        GoRoute(
          path: '/main/dashboard',
          pageBuilder: (context, state) => NoTransitionPage(
            child: MainLayout(
              currentRoute: '/main/dashboard',
              child: const DashboardScreen(),
            ),
          ),
        ),
        GoRoute(
          path: '/main/banner',
          pageBuilder: (context, state) => NoTransitionPage(
            child: MainLayout(
              currentRoute: '/main/banner',
              child: const BannerScreen(),
            ),
          ),
        ),
        // Rute lainnya dengan pola yang sama
        GoRoute(
          path: '/main/category',
          pageBuilder: (context, state) => NoTransitionPage(
            child: MainLayout(
              currentRoute: '/main/category',
              child: const CategoryScreen(),
            ),
          ),
        ),
        GoRoute(
          path: '/main/brand',
          pageBuilder: (context, state) => NoTransitionPage(
            child: MainLayout(
              currentRoute: '/main/brand',
              child: const BrandScreen(),
            ),
          ),
        ),
        GoRoute(
          path: '/main/product',
          pageBuilder: (context, state) => NoTransitionPage(
            child: MainLayout(
              currentRoute: '/main/product',
              child: const ProductScreen(),
            ),
          ),
        ),
        GoRoute(
          path: '/main/order',
          pageBuilder: (context, state) => NoTransitionPage(
            child: MainLayout(
              currentRoute: '/main/order',
              child: const OrderScreen(),
            ),
          ),
        ),
        GoRoute(
          path: '/main/customer',
          pageBuilder: (context, state) => NoTransitionPage(
            child: MainLayout(
              currentRoute: '/main/customer',
              child: const CustomerScreen(),
            ),
          ),
        ),
        // Rute tambah produk sebagai halaman penuh terpisah
        GoRoute(
          path: '/main/product/tambah-produk',
          builder: (context, state) {
            return ProductFormScreen();
          },
        ),
        GoRoute(
          path: '/main/product/edit-produk/:productId',
          builder: (context, state) {
            final productId = state.pathParameters['productId'];
            final productData = state.extra as Map<String, dynamic>?;

            // Pastikan productData memiliki ID yang sesuai dengan parameter path
            Map<String, dynamic>? updatedProductData;
            if (productData != null) {
              updatedProductData = {...productData};
              // Update ID jika berbeda dengan parameter path
              if (productId != null && productId.isNotEmpty) {
                updatedProductData['id'] =
                    int.tryParse(productId) ?? productData['id'];
              }
            }

            return ProductFormScreen(product: updatedProductData);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    // Provider BLOC untuk state management
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
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(context),
        routerConfig: _router,
      ),
    );
  }
}

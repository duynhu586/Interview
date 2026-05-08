import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'package:quanlygom/core/config/api_config.dart';
import 'package:quanlygom/services/category/category_service.dart';
import 'package:quanlygom/services/customer/customer_service.dart';
import 'package:quanlygom/services/order/order_service.dart';
import 'package:quanlygom/view-models/category/category_view_model.dart';
import 'package:quanlygom/view-models/customer/customer_list_view_model.dart';
import 'package:quanlygom/view-models/order/create_order_view_model.dart';
import 'package:quanlygom/views/main_screen.dart';
import 'package:sizer/sizer.dart';

// Import đúng đường dẫn các file của bạn
import 'package:quanlygom/services/product/product_service.dart';
import 'package:quanlygom/view-models/product/product_view_model.dart';
import 'package:quanlygom/views/product/product_list_screen.dart';

void main() {
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            // 1. Khởi tạo Service (Tạm thời dùng token cứng theo tài liệu API)
            Provider(
              create: (_) => ProductService(ApiConfig.baseUrl, ApiConfig.token),
            ),
            Provider(
              create: (_) =>
                  CategoryService(ApiConfig.baseUrl, ApiConfig.token),
            ),
            Provider(
              create: (_) => OrderService(ApiConfig.baseUrl, ApiConfig.token),
            ),
            Provider(
              create: (_) =>
                  CustomerService(ApiConfig.baseUrl, ApiConfig.token),
            ),

            // 2. Khởi tạo ViewModel và truyền Service vào thông qua context.read
            ChangeNotifierProvider(
              create: (context) =>
                  ProductListViewModel(context.read<ProductService>()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  CategoryViewModel(context.read<CategoryService>()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  CreateOrderViewModel(context.read<OrderService>()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  CustomerListViewModel(context.read<CustomerService>()),
            ),
          ],
          child: MaterialApp(
            title: 'Quản Lý Gốm',
            useInheritedMediaQuery: true, // Cần thiết cho DevicePreview
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // 3. Bây giờ bạn không cần truyền viewModel qua constructor nữa
            home: MainScreen(),
          ),
        );
      },
    );
  }
}

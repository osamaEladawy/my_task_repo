import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_task_products/core/routes/routes.dart';
import 'package:my_task_products/features/auth/presentation/pages/login_screen.dart';
import 'package:my_task_products/features/auth/presentation/pages/signup.dart';
import 'package:my_task_products/features/products/domain/entities/product_entity.dart';
import 'package:my_task_products/features/products/presentation/pages/add_product_screen.dart';
import 'package:my_task_products/features/products/presentation/pages/home_screen.dart';
import 'package:my_task_products/features/home_tap/presentation/pages/home_tap_screen.dart';
import 'package:my_task_products/features/products/presentation/pages/update_product_screen.dart';
import 'package:my_task_products/features/roles/presentation/pages/roles_screen.dart';
import 'package:my_task_products/features/splash/presentation/pages/splash_screen.dart';

class RoutesGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final isIos = defaultTargetPlatform == TargetPlatform.iOS;
    final nameRoute = settings.name;
    final arg = settings.arguments;

    switch (nameRoute) {
      case Routes.splash:
        return _buildRoute(const SplashScreen(), isIos);
      case Routes.homeTap:
        return _buildRoute(HomeTapScreen(), isIos);
      case Routes.home:
        return _buildRoute(const HomeScreen(), isIos);
      case Routes.addProduct:
        return _buildRoute(const AddProductScreen(), isIos);
      case Routes.updateProduct:
        if (arg is ProductEntity) {
          return _buildRoute(UpdateProductScreen(productEntity: arg), isIos);
        } else {
          return _buildRoute(_undefinedWidget(), isIos);
        }
      case Routes.login:
        return _buildRoute(LoginScreen(), isIos);

      case Routes.signUp:
        return _buildRoute(SignUpScreen(), isIos);
      case Routes.roleScreen:
        return _buildRoute(RolesScreen(), isIos);
      default:
        return _buildRoute(_undefinedWidget(), isIos);
    }
  }

  //* customize to android or ios
  static _buildRoute(Widget page, bool isIos) {
    if (isIos) {
      return CupertinoPageRoute(builder: (_) => page);
    } else {
      return MaterialPageRoute(builder: (_) => page);
    }
  }

  //* when not found page display this
  static Widget _undefinedWidget() {
    return Scaffold(
      appBar: AppBar(title: const Text("undefined")),
      body: const Center(child: Text("no page here")),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/core/constants/strings.dart';
import 'package:flutter_sample_app/core/local/shared_preference/app_preference.dart';
import 'package:flutter_sample_app/core/routes/navigator_routes.dart';
import 'package:flutter_sample_app/core/utility/extensions.dart';
import 'package:flutter_sample_app/di/injector.dart';
import 'package:flutter_sample_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_sample_app/features/cart/domain/repositories/cart_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartBloc(
            CartRepositoryImp(
              appPreference: Injector.instance.get<AppPreference>(),
            ),
          )..add(GetProductsAddedInCartEvent()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is ProductAddedToCartActionState) {
                messengerKey.currentState?.showSuccessSnackBarOnState(
                    message: Strings.productAddedToCart);
              } else if (state is ProductRemovedFromCartActionState) {
                messengerKey.currentState?.showSuccessSnackBarOnState(
                    message: Strings.productRemovedFromCart);
              }
            },
          )
        ],
        child: MaterialApp(
          scaffoldMessengerKey: messengerKey,
          title: 'Flutter Sample',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          routes: NavigatorRoutes.routes,
          initialRoute: NavigatorRoutes.root,
        ),
      ),
    );
  }
}

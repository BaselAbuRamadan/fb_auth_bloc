import 'package:fb_auth_bloc/pages/home_page.dart';
import 'package:fb_auth_bloc/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print("listester State: $state");
        if(state.authStatus == AuthStatus.unauthenticated){
          Navigator.pushNamedAndRemoveUntil(
            context,
            SigninPage.routeName,
                (route) {
              print('route.settings.name: ${route.settings.name}');
              print('ModalRoute: ${ModalRoute.of(context)!.settings.name}');

              return route.settings.name ==
                  ModalRoute.of(context)!.settings.name
                  ? true
                  : false;
            },
          );
        }else  if(state.authStatus == AuthStatus.authenticated){
          Navigator.pushNamed (context,  HomePage.routeName);
        }

      },
      builder: (context, state) {
        print("listener $state");
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

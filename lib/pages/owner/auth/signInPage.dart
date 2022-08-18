import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_reservat/provider/authProvider.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/widgets/appBar.dart';
import 'package:uts_reservat/widgets/button.dart';
import 'package:uts_reservat/widgets/entry.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: customAppBar(title: 'Inicio de sesión')),
        body: Padding(
            padding: EdgeInsets.all(padding_20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                SizedBox(height: size_40),
                Image.asset(
                  'lib/images/ic_app.png',
                  width: size_180,
                  height: size_80,
                ),
                SizedBox(height: size_80),
                customEntry(
                    text: 'giomeza24@hotmail.com',
                    hint: 'Correo electrónico',
                    onChanged: (value) =>
                        authProvider.setOwnerValues(email: value),
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next),
                SizedBox(height: size_20),
                customEntry(
                  text: '123456',
                    hint: 'Contraseña',
                    onChanged: (value) =>
                        authProvider.setOwnerValues(password: value),
                    textInputType: TextInputType.text,
                    isPassword: !authProvider.viewPasswordSignIn,
                    textInputAction: TextInputAction.done,
                    iconButton: iconPassword(
                        context: context,
                        viewPassword: authProvider.viewPasswordSignIn,
                        onClick: () => authProvider.seeOrHidePasswordSignIn(
                            authProvider.viewPasswordSignIn))),
                SizedBox(height: size_80),
                customButton(
                    context: context,
                    text: 'Iniciar Sesión',
                    onClick: () => authProvider.validateSignIn(context))
              ]),
            )));
  }
}

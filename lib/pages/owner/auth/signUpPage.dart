import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_reservat/provider/authProvider.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/widgets/appBar.dart';
import 'package:uts_reservat/widgets/button.dart';
import 'package:uts_reservat/widgets/entry.dart';

class SignUpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(title: 'Registro'),
      body: Padding(
        padding: EdgeInsets.all(padding_20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: size_40),
              Image.asset(
                'lib/images/ic_app.png',
                width: size_180,
                height: size_80,
              ),
              SizedBox(height: size_80),
              customEntry(
                hint: 'Nombre', 
                onChanged: (value) => authProvider.ownerModel.name = value,
                textInputType: TextInputType.name, 
                textInputAction: TextInputAction.next
              ),
              SizedBox(height: size_20),
              customEntry(
                hint: 'Teléfono', 
                onChanged: (value) => authProvider.ownerModel.phone = value,
                textInputType: TextInputType.phone, 
                textInputAction: TextInputAction.next
              ),
              SizedBox(height: size_20),
              customEntry(
                hint: 'Correo electrónico', 
                onChanged: (value) => authProvider.ownerModel.email = value,
                textInputType: TextInputType.emailAddress, 
                textInputAction: TextInputAction.next
              ),
              SizedBox(height: size_20),
              customEntry(
                hint: 'Contraseña', 
                onChanged: (value) => authProvider.ownerModel.password = value,
                textInputType: TextInputType.text,
                isPassword: !authProvider.viewPasswordSignUp, 
                textInputAction: TextInputAction.done,
                iconButton: iconPassword(
                  context: context,
                  viewPassword: authProvider.viewPasswordSignUp,
                  onClick: () => authProvider.seeOrHidePasswordSignIn(authProvider.viewPasswordSignUp)
                )
              ),
              SizedBox(height: size_80),
              customButton(
                context: context, 
                text: 'Registrarse', 
                onClick: () {
                  authProvider.validateSignUp(context, authProvider.ownerModel);
                }
              )
            ]
          ),
        )
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:uts_reservat/helpers/ui.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/res/styles.dart';
import 'package:uts_reservat/sessions/sessionManager.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';

Widget customNavigationDrawer({required BuildContext context, String? token}) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        headerDrawer(),
        Visibility(
          visible: token!.isNotEmpty ? false : true,
          child: itemDrawer(
            context: context,
            iconName: Icons.contact_support,
            title: 'Registrarse',
            routeName: signUpRoute
          ),
        ),
        Visibility(
          visible: token.isNotEmpty ? false : true,
          child: itemDrawer(
            context: context,
            iconName: Icons.contact_support,
            title: 'Inicio de sesión',
            routeName: signInRoute
          ),
        ),
        Visibility(
          visible: token.isNotEmpty ? true : false,
          child: itemDrawer(
            context: context,
            iconName: Icons.account_circle,
            title: 'Perfil',
            routeName: profileRoute
          ),
        ),
        Visibility(
          visible: token.isNotEmpty? true : false,
          child: itemDrawer(
            context: context,
            iconName: Icons.contact_support,
            title: ' Mis lugares',
            routeName: placesRoute
          ),
        ),
        Visibility(
          visible: token.isNotEmpty? true : false,
          child: itemDrawer(
            context: context,
            iconName: Icons.logout,
            title: 'Cerrar Sesión',
            routeName: signOutRoute
          ),
        )
      ]
    )
  );
}

Widget headerDrawer() {
  return DrawerHeader(
    child: Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(padding_16),
        child: Image.asset('lib/images/ic_app.png'),
      )
    ),
    decoration: BoxDecoration(
      color: conifer
    )
  );
}

Widget itemDrawer({required BuildContext context, IconData? iconName, String? title, String? routeName}) {
  return ListTile(
    title: Text(
      title!,
      textAlign: TextAlign.center,
      style: textStyleSemiBold(
        fontSize: text_14,
        color: charcoal
      )
    ),
    onTap: () {
      Navigator.pop(context);
      if(routeName == signOutRoute) {
        showAlertDialog(
          context: context,
          title: 'Finalizar Sesión',
          message: '¿Desea Finalizar la sesión?',
          positiveClick: () {
            final SessionManager prefs = SessionManager();
            prefs.deleteAll();
            Navigator.of(context).pop(); // dismiss dialog
            Navigator.pushReplacementNamed(
              context, 
              placesHomeRoute
            );
          },
          negativeClick: () => Navigator.of(context).pop() // dismiss dialog
        );
      }else{
        Navigator.pushNamed(context, routeName!);
      }
    }
  );
}
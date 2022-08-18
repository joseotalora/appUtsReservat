import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:uts_reservat/api/restClient.dart';
import 'package:uts_reservat/helpers/serverError.dart';
import 'package:uts_reservat/helpers/ui.dart';
import 'package:uts_reservat/models/ownerModel.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/sessions/sessionManager.dart';
import 'package:uts_reservat/utils/util.dart';
import 'package:uts_reservat/widgets/appBar.dart';
import 'package:uts_reservat/widgets/button.dart';
import 'package:uts_reservat/widgets/entry.dart';
import 'package:uts_reservat/widgets/others.dart';

class ProfilePage extends StatefulWidget {
  @override
  createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static Dio _dio = Dio();
  RestClient _apiClient = RestClient(_dio);
  final SessionManager _prefs = SessionManager();
  OwnerModel? ownerDto;
  bool _viewPassword = false;
  bool _isEdit = false;
  Future<OwnerModel>? _future;
  String? _name;
  String? _phone;
  String? _email;
  String? _password;

  @override
  void initState() {
    super.initState();
    _future = _getOwnerData() as Future<OwnerModel>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(title: 'Perfil'),
        body: FutureBuilder<OwnerModel>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return _setView(context, snapshot.data!);
              } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
                return withoutItems(message: 'Sin informacion para mostrar');
              } else if (snapshot.hasError) {
                ServerError(context: context, error: snapshot.error as DioError);
                return Container(width: double.infinity, height: double.infinity);
              }
              return customLoading();
            }));
  }

  Future _getOwnerData() {
    return _apiClient.getInfoOwner(token: _prefs.token);
  }

  Padding _setView(BuildContext context, OwnerModel ownerModel) {
    _prefs.ownerId = ownerModel.id!;
    return Padding(
        padding: EdgeInsets.all(padding_20),
        child: Column(children: [
          SizedBox(height: size_40),
          customEntry(
              text: _name = ownerModel.name,
              hint: 'Nombre',
              onChanged: (value) => _name = value,
              enable: _isEdit,
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.next),
          SizedBox(height: size_20),
          customEntry(
              text: _phone = ownerModel.phone,
              hint: 'Teléfono',
              onChanged: (value) => _phone = value,
              enable: _isEdit,
              textInputType: TextInputType.phone,
              textInputAction: TextInputAction.next),
          SizedBox(height: size_20),
          customEntry(
              text: _email = ownerModel.email,
              hint: 'Correo electrónico',
              enable: false,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next),
          SizedBox(height: size_20),
          customEntry(
              hint: 'Contraseña',
              onChanged: (value) => _password = value,
              enable: _isEdit,
              textInputType: TextInputType.text,
              isPassword: !_viewPassword,
              textInputAction: TextInputAction.done,
              iconButton: iconPassword(
                  context: context,
                  viewPassword: _viewPassword,
                  onClick: () => setState(() => _viewPassword = !_viewPassword))),
          SizedBox(height: size_80),
          customButton(
              context: context,
              text: !_isEdit ? 'Editar' : 'Guardar',
              onClick: () {
                if (_isEdit == true) {
                  _validateData(context, _name!, _phone!, _email!, _password!);
                } else {
                  setState(() => _isEdit = !_isEdit);
                }
              })
        ]));
  }

  void _validateData(BuildContext context, String name, String phone, String email, String password) {
    if (name.isNotEmpty && phone.isNotEmpty || password.isNotEmpty) {
      _updateData(context, name, phone, email, password);
    } else {
      // --- validate errors
    }
  }

  OwnerModel _setData(String name, String phone, String email, String password) =>
      ownerDto = OwnerModel.updateOwner(name: name, phone: phone, email: email, password: password);

  void _updateData(BuildContext context, String name, String phone, String email, String password) {
    showProgressDialog(context: context);
    _apiClient
        .updateOwner(token: _prefs.token, ownerId: _prefs.ownerId, ownerModel: _setData(name, phone, email, password))
        .whenComplete(() => Navigator.of(context).pop())
        .then((value) {
      showToast(message: 'Datos actualizados exitosamente');
      setState(() => _isEdit = !_isEdit);
    }).catchError((error) {
      ServerError(context: context, error: error);
    });
  }
}

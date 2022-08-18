import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uts_reservat/helpers/cameraAndGallery.dart';
import 'package:uts_reservat/helpers/serverError.dart';
import 'package:uts_reservat/helpers/ui.dart';
import 'package:uts_reservat/models/categoryModel.dart';
import 'package:uts_reservat/models/ownerModel.dart';
import 'package:uts_reservat/models/placeModel.dart';
import 'package:uts_reservat/models/securityMeasuresModel.dart';
import 'package:uts_reservat/provider/categoriesProvider.dart';
import 'package:uts_reservat/provider/placeProvider.dart';
import 'package:uts_reservat/provider/securityMeasuresProvider.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/res/styles.dart';
import 'package:uts_reservat/services/locationService.dart';
import 'package:uts_reservat/sessions/sessionManager.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';
import 'package:uts_reservat/utils/util.dart';
import 'package:uts_reservat/widgets/appBar.dart';
import 'package:uts_reservat/widgets/button.dart';
import 'package:uts_reservat/widgets/card.dart';
import 'package:uts_reservat/widgets/dropDown.dart';
import 'package:uts_reservat/widgets/entry.dart';
import 'package:uts_reservat/widgets/image.dart';
import 'package:uts_reservat/widgets/others.dart';

class PlaceCreationPage extends StatefulWidget {
  @override
  createState() => _PlaceCreationPageState();
}

class _PlaceCreationPageState extends State<PlaceCreationPage> {
  final SessionManager _prefs = SessionManager();
  String _name = '', _price = '', _description = '', _capacity = '';
  CategoryModel _categorySelected = CategoryModel();
  late Future _future1;
  File? _file1;
  File? _file2;
  File? _file3;
  PlaceModel? _dataNewPlace;
  Completer<GoogleMapController> _googleMapController = Completer();

  List<SecurityMeasuresModel> _securityMeasuresSelect = [];
  bool _isButtonDisabled = false;
  bool _value1 = false,
      _value2 = false,
      _value3 = false,
      _value4 = false,
      _value5 = false,
      _value6 = false;

  @override
  void initState() {
    super.initState();
    _future1 = _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final PlaceProvider _placeProvider = Provider.of<PlaceProvider>(context);
    final CategoriesProvider _categoriesProvider =
        Provider.of<CategoriesProvider>(context);
    final SecurityMeasuresProvider _securityMeasuresProvider =
        Provider.of<SecurityMeasuresProvider>(context);
    final List<Future<dynamic>>? futures = [
      _future1,
      _categoriesProvider.getCategories(),
      _securityMeasuresProvider.getSecurityMeasures()
    ];

    return Scaffold(
        appBar: customAppBar(title: 'Creación de lugar'),
        body: FutureBuilder(
            future: Future.wait(futures!),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              inspect(snapshot);
              //inspect(futures);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return customLoading();
              } else if (snapshot.hasError) {
                ServerError(
                    context: context, error: snapshot.error as DioError);
                return Container(
                    width: double.infinity, height: double.infinity);
              } else {
                //inspect(_placeProvider);
                return _setView(
                    _placeProvider,
                    context,
                    snapshot.data![0],
                    _categoriesProvider.categories!,
                    _securityMeasuresProvider.securityMeasures!);
              }
            }));
  }

  Future<Position> _getLocation() {
    return getLocation();
  }

  Widget _setView(
      PlaceProvider placeProvider,
      BuildContext context,
      Position position,
      List<CategoryModel> categories,
      List<SecurityMeasuresModel> securityMeasures) {
    return SingleChildScrollView(
      child: Column(children: [
        customCardMap(
            width: MediaQuery.of(context).size.width,
            height: size_200,
            googleMapController: _googleMapController,
            cameraPosition: CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 16),
            markers: placeProvider.location == null
                ? _addMarker(
                    LatLng(double.parse('7.0909'), double.parse('-73.1095')))
                : _addMarker(placeProvider.location!),
            onClick: (position) => placeProvider.addedLocation(position)),
        /*customCardMap(
            width: MediaQuery.of(context).size.width,
            height: size_200,
            googleMapController: _googleMapController,
            cameraPosition: CameraPosition(target: LatLng(data.latitude, data.longitude), zoom: 16),
            markers: placeProvider.location == null ? null : _addMarker(placeProvider.location!),
            onClick: (position) => placeProvider.addedLocation(position)),*/
        Padding(
          padding: EdgeInsets.all(padding_20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            customEntry(
                hint: _name == '' ? 'Nombre' : _name,
                onChanged: (value) => _name = value,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next),
            SizedBox(height: size_20),
            customEntry(
                hint: _price == '' ? 'Precio' : _price,
                onChanged: (value) => _price = value,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next),
            SizedBox(height: size_20),
            customEntry(
                hint: _description == '' ? 'Descripción' : _description,
                onChanged: (value) => _description = value,
                maxLines: 4,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next),
            SizedBox(height: size_20),
            customEntry(
                hint: _capacity == '' ? 'Capacidad' : _capacity,
                onChanged: (value) => _capacity = value,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done),
            SizedBox(height: size_20),
            customDropDown(
                hint: 'Seleccione la categoria',
                items: categories.map((CategoryModel category) {
                  return DropdownMenuItem<String>(
                    value: category.name,
                    child: Center(
                      child: Text(category.name!,
                          style: textStyleNormal(
                              color: blackcurrant, fontSize: text_16)),
                    ),
                  );
                }).toList(),
                value: _categorySelected.name,
                onChanged: ((value) => setState(() {
                      _searchIdCategoria(categories, value);
                      return _categorySelected.name = value;
                    }))),
            SizedBox(height: size_20),
            Container(
                height: MediaQuery.of(context).size.height * 0.10,
                child: Container(child: _galeria(context))),
            SizedBox(height: size_20),
            Text(
              'Medidas de seguridad',
              style: textStyleNormal(color: blackcurrant, fontSize: text_16),
            ),
            SizedBox(height: size_5),
            _securityMeasures(context, securityMeasures),
            SizedBox(height: size_40),
            customButton(
                context: context,
                text: 'Crear',
                onClick: () async {
                  /*await _loadImage(
                      placeProvider: placeProvider,
                      token: _prefs.token,
                      placeId: 88,
                      image: _file1!);*/
                  if (_isButtonDisabled == false) {
                    if (_capacity != '' &&
                        _name != '' &&
                        _price != '' &&
                        _description != '' &&
                        _categorySelected.id != null) {
                      _newPlace(
                          placeProvider: placeProvider,
                          capacity: _capacity,
                          context: context,
                          name: _name,
                          description: _description,
                          //latitude: '37.42796133580664',
                          //longitude: '-122.085749655962',
                          latitude: placeProvider.location!.latitude.toString(),
                          longitude:
                              placeProvider.location!.longitude.toString(),
                          ownerId: _prefs.ownerId,
                          price: _price,
                          categoryId: _categorySelected.id!,
                          securityMeasures: _securityMeasuresSelect);
                    } else {
                      showToast(
                          message: 'Faltan campos para la creacion del sitio.');
                    }
                  } else {
                    showToast(
                        message: 'Se esta creando el sitio. Por favor espere');
                  }
                })
          ]),
        )
      ]),
    );
  }

  Set<Marker> _addMarker(LatLng location) {
    Set<Marker> marker = Set();
    marker.add(Marker(
      markerId: MarkerId('1'),
      infoWindow: InfoWindow(title: 'My ubicación'),
      position: LatLng(location.latitude, location.longitude),
    ));
    return marker;
  }

  Widget _galeria(BuildContext context) {
    return ListView(scrollDirection: Axis.horizontal, children: [
      SizedBox(width: size_20),
      customImageFile(
          context: context,
          file: _file1 == null ? null : _file1,
          width: size_100,
          height: size_100,
          corner: corner_20,
          shape: BoxShape.rectangle,
          onClick: () {
            // Click Event
            showAlertDialogAction(
                context: context,
                title: '¿Dónde desea cargar la primera imagen?',
                items: <Widget>[
                  GestureDetector(
                    child: Text("Galeria",
                        style: textStyleNormal(
                            color: blackcurrant, fontSize: text_16),
                        textAlign: TextAlign.center),
                    onTap: () async {
                      try {
                        final pickedFile = await openGallery(context);
                        setState(() => _file1 = File(pickedFile!.path));
                      } catch (error) {
                        addLog(message: error);
                      }
                    },
                  ),
                  SizedBox(height: size_20),
                  GestureDetector(
                    child: Text("Camara",
                        style: textStyleNormal(
                            color: blackcurrant, fontSize: text_16),
                        textAlign: TextAlign.center),
                    onTap: () async {
                      try {
                        final pickedFile = await openCamera(context);
                        setState(() => _file1 = File(pickedFile!.path));
                      } catch (error) {
                        addLog(message: error);
                      }
                    },
                  )
                ]);
          }),
      SizedBox(width: size_10),
      customImageFile(
          context: context,
          file: _file2 == null ? null : _file2,
          width: size_100,
          height: size_100,
          corner: corner_20,
          shape: BoxShape.rectangle,
          onClick: () {
            // Click Event
            showAlertDialogAction(
                context: context,
                title: '¿Dónde desea cargar la segunda imagen?',
                items: <Widget>[
                  GestureDetector(
                    child: Text("Galeria",
                        style: textStyleNormal(
                            color: blackcurrant, fontSize: text_16),
                        textAlign: TextAlign.center),
                    onTap: () async {
                      try {
                        final pickedFile = await openGallery(context);
                        setState(() => _file2 = File(pickedFile!.path));
                      } catch (error) {
                        addLog(message: error);
                      }
                    },
                  ),
                  SizedBox(height: size_20),
                  GestureDetector(
                    child: Text("Camara",
                        style: textStyleNormal(
                            color: blackcurrant, fontSize: text_16),
                        textAlign: TextAlign.center),
                    onTap: () async {
                      try {
                        final pickedFile = await openCamera(context);
                        setState(() => _file2 = File(pickedFile!.path));
                      } catch (error) {
                        addLog(message: error);
                      }
                    },
                  )
                ]);
          }),
      SizedBox(width: size_10),
      customImageFile(
          context: context,
          file: _file3 == null ? null : _file3,
          width: size_100,
          height: size_100,
          corner: corner_20,
          shape: BoxShape.rectangle,
          onClick: () {
            // Click Event
            showAlertDialogAction(
                context: context,
                title: '¿Dónde desea cargar la tercera imagen?',
                items: <Widget>[
                  GestureDetector(
                    child: Text("Galeria",
                        style: textStyleNormal(
                            color: blackcurrant, fontSize: text_16),
                        textAlign: TextAlign.center),
                    onTap: () async {
                      try {
                        final pickedFile = await openGallery(context);
                        setState(() => _file3 = File(pickedFile!.path));
                      } catch (error) {
                        addLog(message: error);
                      }
                    },
                  ),
                  SizedBox(height: size_20),
                  GestureDetector(
                    child: Text("Camara",
                        style: textStyleNormal(
                            color: blackcurrant, fontSize: text_16),
                        textAlign: TextAlign.center),
                    onTap: () async {
                      try {
                        final pickedFile = await openCamera(context);
                        setState(() => _file3 = File(pickedFile!.path));
                      } catch (error) {
                        addLog(message: error);
                      }
                    },
                  )
                ]);
          })
    ]);
  }

  Widget _securityMeasures(
      BuildContext context, List<SecurityMeasuresModel> securityMeasures) {
    return Column(children: [
      customCardWithCheck(
          text: securityMeasures[0].name!,
          value: _value1,
          onChanged: (value) => setState(() {
                if (value == true) {
                  _securityMeasuresSelect.add(
                      SecurityMeasuresModel.newSecurityMeasureID(
                          id: securityMeasures[0].id!));
                } else {
                  _securityMeasuresSelect.remove(securityMeasures[0]);
                }
                _value1 = value!;
              })),
      customCardWithCheck(
          text: securityMeasures[1].name!,
          value: _value2,
          onChanged: (value) => setState(() {
                addLog(message: value);
                if (value == true) {
                  _securityMeasuresSelect.add(
                      SecurityMeasuresModel.newSecurityMeasureID(
                          id: securityMeasures[1].id!));
                } else {
                  _securityMeasuresSelect.remove(securityMeasures[1]);
                }
                _value2 = value!;
              })),
      customCardWithCheck(
          text: securityMeasures[2].name!,
          value: _value3,
          onChanged: (value) => setState(() {
                if (value == true) {
                  _securityMeasuresSelect.add(
                      SecurityMeasuresModel.newSecurityMeasureID(
                          id: securityMeasures[2].id!));
                } else {
                  _securityMeasuresSelect.remove(securityMeasures[2]);
                }
                _value3 = value!;
              })),
      customCardWithCheck(
          text: securityMeasures[3].name!,
          value: _value4,
          onChanged: (value) => setState(() {
                if (value == true) {
                  _securityMeasuresSelect.add(
                      SecurityMeasuresModel.newSecurityMeasureID(
                          id: securityMeasures[3].id!));
                } else {
                  _securityMeasuresSelect.remove(securityMeasures[3]);
                }
                _value4 = value!;
              })),
      customCardWithCheck(
          text: securityMeasures[4].name!,
          value: _value5,
          onChanged: (value) => setState(() {
                if (value == true) {
                  _securityMeasuresSelect.add(
                      SecurityMeasuresModel.newSecurityMeasureID(
                          id: securityMeasures[4].id!));
                } else {
                  _securityMeasuresSelect.remove(securityMeasures[4]);
                }
                _value5 = value!;
              })),
      customCardWithCheck(
          text: securityMeasures[5].name!,
          value: _value6,
          onChanged: (value) => setState(() {
                if (value == true) {
                  _securityMeasuresSelect.add(
                      SecurityMeasuresModel.newSecurityMeasureID(
                          id: securityMeasures[5].id!));
                } else {
                  _securityMeasuresSelect.remove(securityMeasures[5]);
                }
                _value6 = value!;
              })),
    ]);
  }

  PlaceModel _setData(
          {required String capacity,
          required String name,
          required String description,
          required String latitude,
          required String longitude,
          required int ownerId,
          required String price,
          required int categoryId,
          required List<SecurityMeasuresModel> securityMeasures}) =>
      PlaceModel.newPlace(
          name: name,
          description: description,
          latitude: latitude,
          longitude: longitude,
          capacity: capacity,
          owner: OwnerModel.onlyId(id: ownerId),
          price: price,
          category: CategoryModel.onlyId(id: categoryId),
          securityMeasures: securityMeasures);

  Future<String> _loadImage(
      {required PlaceProvider placeProvider,
      required String token,
      required int placeId,
      required File image}) async {
    final _result = await placeProvider.uploadImageFile(
        token: token, placeId: placeId, image: image);
    log('--------- IMAGEN -----------------');
    inspect(_result);
    return _result;
  }

  void _newPlace(
      {required PlaceProvider placeProvider,
      required String capacity,
      required BuildContext context,
      required String name,
      required String description,
      required String latitude,
      required String longitude,
      required int ownerId,
      required String price,
      required int categoryId,
      required List<SecurityMeasuresModel> securityMeasures}) async {
    showToast(message: 'Se esta creando el sitio. Por favor espere');
    setState(() => _isButtonDisabled = true);
    var _status;
    var result = await placeProvider.newPlace(
        context: context,
        placeModel: _setData(
            capacity: capacity,
            name: name,
            description: description,
            latitude: latitude,
            longitude: longitude,
            ownerId: ownerId,
            price: price,
            categoryId: categoryId,
            securityMeasures: securityMeasures));

    _status = result;

    if (_status != null) {
      if (_file1 != null) {
        await _loadImage(
            placeProvider: placeProvider,
            token: _prefs.token,
            placeId: result.id!.toInt(),
            image: _file1!);
      }

      if (_file2 != null) {
        await _loadImage(
            placeProvider: placeProvider,
            token: _prefs.token,
            placeId: result.id!.toInt(),
            image: _file2!);
      }

      if (_file3 != null) {
        await _loadImage(
            placeProvider: placeProvider,
            token: _prefs.token,
            placeId: result.id!.toInt(),
            image: _file3!);
      }

      showToast(message: 'Lugar creado exitosamente');
      setState(() => {this._dataNewPlace = null, _isButtonDisabled = false});
      Navigator.pushReplacementNamed(context, placesRoute);
      //Navigator.pop(context);
    } else {
      setState(() => _isButtonDisabled = false);
      showToast(message: 'Error al crear el sitio');
    }

    //if (_status != null) {
    //showToast(message: 'Lugar creado exitosamente');
    //setState(() => {this._dataNewPlace = null, _isButtonDisabled = false});
    //} else {
    //setState(() => _isButtonDisabled = false);
    //showToast(message: 'Error al crear el sitio');
    //}
  }

  void _searchIdCategoria(
      List<CategoryModel> categories, String nameCategoria) {
    categories.forEach((categoria) => {
          if (categoria.name == nameCategoria)
            {_categorySelected.id = categoria.id}
        });
  }
}

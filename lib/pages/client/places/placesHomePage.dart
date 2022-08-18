import 'dart:developer';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uts_reservat/helpers/serverError.dart';
import 'package:uts_reservat/models/categoryModel.dart';
import 'package:uts_reservat/models/placeModel.dart';
import 'package:uts_reservat/provider/categoriesProvider.dart';
import 'package:uts_reservat/provider/placeProvider.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/res/styles.dart';
import 'package:uts_reservat/sessions/sessionManager.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';
import 'package:uts_reservat/utils/util.dart';
import 'package:uts_reservat/widgets/appBar.dart';
import 'package:uts_reservat/widgets/card.dart';
import 'package:uts_reservat/widgets/navigationDrawer.dart';
import 'package:uts_reservat/widgets/others.dart';


class PlacesHomePage extends StatefulWidget {
  @override
  createState() => _PlacesHomePageState();
}

class _PlacesHomePageState extends State<PlacesHomePage> {
  final SessionManager _prefs = SessionManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final placeProvider = Provider.of<PlaceProvider>(context);
    final categoriesProvider = Provider.of<CategoriesProvider>(context);   

    return Scaffold(
        appBar: customAppBar(title: 'UTS Reservat'),
        drawer: customNavigationDrawer(context: context, token: _prefs.token),
        body: FutureBuilder(
            future: Future.wait([categoriesProvider.getCategories(), placeProvider.getPlaces()]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return _setView(categoriesProvider, placeProvider);
              } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
                return withoutItems(message: 'Sin informacion para mostrar');
              } else if (snapshot.hasError) {
                ServerError(context: context, error: snapshot.error as DioError);
                return Container(width: double.infinity, height: double.infinity);
              }
              return customLoading();
            }));
  }

  Padding _setView(CategoriesProvider categoriesProvider, PlaceProvider placeProvider) {
    inspect(MediaQuery.of(context));
    print(MediaQuery.of(context).size.height* .01);
    return Padding(
      padding: EdgeInsets.all(padding_16),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            height: MediaQuery.of(context).size.height * .07,
            child: Container(child: _setCategories(categoriesProvider, placeProvider))),
        SizedBox(height: size_20),
        Expanded(child: _setPlaces(placeProvider))
      ]),
    );
  }

  Widget _setCategories(CategoriesProvider categoriesProvider, PlaceProvider placeProvider) {
    return Row(
      children: [
        InkWell(
          child: Padding(
              padding: EdgeInsets.all(padding_16),
              child: Text('Todas', style: textStyleSemiBold(color: blackcurrant, fontSize: text_16))),
          onTap: () {
            placeProvider.filterPlaces('ALL');
          },
        ),
        SizedBox(width: size_10),
        Container(width: 2, color: gossip),
        SizedBox(width: size_10),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoriesProvider.categories!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _itemCategory(categoriesProvider.categories!, index, placeProvider);
              }),
        ),
      ],
    );
  }

  Widget _setPlaces(PlaceProvider placeProvider) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: placeProvider.places!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return _itemPlace(context, placeProvider.places!, index);
        });
  }

  Widget _itemCategory(List<CategoryModel> categories, int index, PlaceProvider placeProvider) {
    
    return Card(
      color: darkCerulean,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding_10),
        child: InkWell(
            child: Center(
              child: Text(
                categories[index].name!,
                style: textStyleNormal(color: white, fontSize: text_16),
              ),
            ),
            onTap: () {   
              placeProvider.filterPlaces(categories[index].name!);
            }),
      ),
    );
  }

  /*
  Restaurantes: 'https://images.unsplash.com/photo-1592861956120-e524fc739696?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
  Fincas: 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80'
  Hoteles: 'https://images.unsplash.com/photo-1568084680786-a84f91d1153c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80'
  */

  Widget _itemPlace(BuildContext context, List<PlaceModel> places, int index) {

    return customCard(
        context: context,
        image: getTypeImage(places[index].category!.name!),
        textTag: places[index].category!.name!,
        title: places[index].name!,
        subtitle: places[index].price!,
        onClick: () => Navigator.pushNamed(context, placeDetailClientRoute, arguments: places[index].id));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_range/time_range.dart';
import 'package:uts_reservat/helpers/ui.dart';
import 'package:uts_reservat/models/clientModel.dart';
import 'package:uts_reservat/models/placeModel.dart';
import 'package:uts_reservat/models/reservationModel.dart';
import 'package:uts_reservat/provider/reservationClientProvider.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/res/dimens.dart';
import 'package:uts_reservat/res/styles.dart';
import 'package:uts_reservat/utils/util.dart';
import 'package:uts_reservat/widgets/appBar.dart';
import 'package:uts_reservat/widgets/button.dart';
import 'package:uts_reservat/widgets/entry.dart';

class ReservationCreationPage extends StatefulWidget {
  final PlaceModel placeModel;

  @override
  createState() => _ReservationCreationPageState();

  ReservationCreationPage(this.placeModel);
}

class _ReservationCreationPageState extends State<ReservationCreationPage> {
  PickerDateRange? _dateRage;
  TimeRangeResult? _timeRange;
  String? _name,
      _phone,
      _email,
      _date = 'Fecha',
      _time = 'Hora',
      _starDate,
      _endDate,
      _timeReservedStart,
      _timeReservedEnd,
      _capacity;
  PlaceModel? _placeModel;

  @override
  void initState() {
    super.initState();
    _placeModel = widget.placeModel;
  }

  @override
  Widget build(BuildContext context) {
    final ReservationClientProvider reservationProvider = Provider.of<ReservationClientProvider>(context);
    return Scaffold(
      appBar: customAppBar(title: 'Creación de reserva'),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(padding_16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          customEntry(
            hint: 'Lugar',
            text: _placeModel!.name,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            enable: false,
          ),
          SizedBox(height: size_20),
          customButton(
              context: context,
              text: 'Seleccionar la fecha',
              onClick: () => showWidgetDialog(
                  context: context,
                  title: 'Seleccione la fecha de llegada y salida',
                  widget: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    child: SfDateRangePicker(
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.range,
                        onSelectionChanged: (data) => setState(() => _dateRage = data.value)),
                  ),
                  positiveClick: () {
                    setState(() {
                      if (_dateRage != null && _dateRage != null) {
                        _starDate = applyDateFormatForServer(_dateRage!.startDate.toString());
                        _endDate = applyDateFormatForServer(_dateRage!.endDate.toString());
                        _date =
                            '${applyDateFormatForUser(_dateRage!.startDate.toString())} a ${applyDateFormatForUser(_dateRage!.endDate.toString())}';
                      } else {
                        _starDate = applyDateFormatForServer(_dateRage!.startDate.toString());
                        _endDate = applyDateFormatForServer(_dateRage!.startDate.toString());
                        _date = '${applyDateFormatForUser(_dateRage!.startDate.toString())}';
                      }
                    });
                    Navigator.of(context).pop();
                  })),
          SizedBox(height: size_20),
          customFalseEntry(context: context, text: _date!),
          SizedBox(height: size_20),
          customButton(
            context: context,
            text: 'Seleccionar la hora',
            onClick: () => showWidgetDialog(
                context: context,
                title: 'Seleccione la hora de entrada y salida',
                widget: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 4,
                    child: TimeRange(
                        fromTitle: Text('Hora de llegada'),
                        toTitle: Text('Hora de salida'),
                        firstTime: TimeOfDay(hour: 0, minute: 00),
                        lastTime: TimeOfDay(hour: 24, minute: 00),
                        timeStep: 60,
                        timeBlock: 60,
                        textStyle: textStyleNormal(color: white, fontSize: text_14),
                        activeTextStyle: textStyleNormal(color: white, fontSize: text_14),
                        backgroundColor: gossip,
                        borderColor: gossip,
                        activeBorderColor: darkCerulean,
                        activeBackgroundColor: darkCerulean,
                        onRangeCompleted: (range) => setState(() => _timeRange = range))),
                positiveClick: () {
                  setState(() {
                    _timeReservedStart = '${_timeRange!.start.hour}:${_timeRange!.start.minute}:00';
                    _timeReservedEnd = '${_timeRange!.end.hour}:${_timeRange!.end.minute}:00';
                    _time = '${_timeRange!.start.format(context)} a ${_timeRange!.end.format(context)}';
                  });
                  Navigator.of(context).pop();
                }),
          ),
          SizedBox(height: size_20),
          customFalseEntry(context: context, text: _time!),
          SizedBox(height: size_20),
          customEntry(
              hint: 'Nombre',
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.next,
              onChanged: (value) => _name = value),
          SizedBox(height: size_20),
          customEntry(
              hint: 'Teléfono',
              textInputType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              onChanged: (value) => _phone = value),
          SizedBox(height: size_20),
          customEntry(
              hint: 'Correo Electrónico',
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (value) => _email = value),
          SizedBox(height: size_20),
          customEntry(
              hint: 'Cantidad de personas',
              onChanged: (value) => _capacity = value,
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.done),
          SizedBox(height: size_40),
          customButton(
              context: context,
              text: 'Confirmar reserva',
              onClick: () {
                reservationProvider.sendReservation(
                    context: context,
                    reservationModel: ReservationModel(
                        place: PlaceModel.onlyId(id: _placeModel!.id),
                        client: ClientModel(name: _name, email: _email, phone: _phone),
                        startDate: _starDate,
                        endDate: _endDate,
                        timeStart: _timeReservedStart,
                        timeEnd: _timeReservedEnd));
              })
        ]),
      )),
    );
  }
}

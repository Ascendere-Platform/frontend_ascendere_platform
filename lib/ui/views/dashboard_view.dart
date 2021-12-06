import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/ui/cards/cards_data_home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late List<LiveData> chartData;
  // ignore: unused_field
  late ChartSeriesController _chartSeriesController;
  var rng = Random();

  @override
  void initState() {
    chartData = getChartData();
    // Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
  }

  // int time = 19;
  // void updateDataSource(Timer timer) {
  //   chartData.add(LiveData(time++, (rng.nextInt(90) + 10)));
  //   chartData.removeAt(0);
  //   _chartSeriesController.updateDataSource(
  //       addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  // }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 12),
      LiveData(1, 22),
      LiveData(2, 43),
      LiveData(3, 49),
      LiveData(4, 54),
      LiveData(5, 15),
      LiveData(6, 58),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Panel de control',
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: const Color(0xFF001B34),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 0),
              Text(
                'Hola, bienvenido!',
                style: GoogleFonts.quicksand(
                    fontSize: 14,
                    color: const Color(0xFF001B34),
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 50),
              Wrap(
                children: [
                  CardDataHome(
                    icon: Icons.compare_arrows,
                    title: 'Cantidad de recursos',
                    child: Text(
                      '25',
                      style: GoogleFonts.roboto(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    width: 225,
                  ),
                  CardDataHome(
                    icon: Icons.compare_arrows,
                    title: 'Numero de convocatorias',
                    child: Text(
                      '2',
                      style: GoogleFonts.roboto(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    width: 225,
                  ),
                  CardDataHome(
                    icon: Icons.arrow_upward,
                    title: 'Numero de docentes registrados',
                    child: Text(
                      '6',
                      style: GoogleFonts.roboto(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    width: 225,
                  )
                ],
              ),
              const SizedBox(height: 24),
              // Grafico
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(10),
                decoration: buildBoxDecoration(),
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Pedidos Realizados'),
                  plotAreaBorderWidth: 0,
                  legend: Legend(overflowMode: LegendItemOverflowMode.wrap),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <SplineSeries<LiveData, int>>[
                    SplineSeries<LiveData, int>(
                      onRendererCreated: (ChartSeriesController controller) {
                        _chartSeriesController = controller;
                      },
                      dataSource: chartData,
                      color: const Color(0xFF00ACC1),
                      name: 'Convocatoria',
                      xValueMapper: (LiveData sales, _) => sales.time,
                      yValueMapper: (LiveData sales, _) => sales.speed,
                    )
                  ],
                  primaryXAxis: NumericAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      interval: 1,
                      title: AxisTitle(text: 'Convocatorias')),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(
                      text: 'Cantidad de Recursos',
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(10),
                decoration: buildBoxDecoration(),
                child: SfCircularChart(
                  title: ChartTitle(text: 'Tipos de proyectos'),
                  legend: Legend(isVisible: false),
                  series: _getDefaultPieSeries(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
            )
          ]);
}

List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries() {
  final List<ChartSampleData> pieData = <ChartSampleData>[
    ChartSampleData(
        x: 'Buenas Practicas', y: 13, text: 'Buenas Practicas \n 13%'),
    ChartSampleData(x: 'Triadas', y: 24, text: 'Triadas \n 24%'),
    ChartSampleData(x: 'Innovación', y: 25, text: 'Innovación \n 25%'),
    ChartSampleData(x: 'Retos', y: 38, text: 'Retos \n 38%'),
  ];
  return <PieSeries<ChartSampleData, String>>[
    PieSeries<ChartSampleData, String>(
        explode: true,
        explodeIndex: 0,
        explodeOffset: '10%',
        dataSource: pieData,
        xValueMapper: (ChartSampleData data, _) => data.x as String,
        yValueMapper: (ChartSampleData data, _) => data.y,
        dataLabelMapper: (ChartSampleData data, _) => data.text,
        startAngle: 90,
        endAngle: 90,
        dataLabelSettings: const DataLabelSettings(isVisible: true)),
  ];
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}

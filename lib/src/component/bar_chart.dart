import 'package:covid/src/model/covid_statistics.dart';
import 'package:covid/src/utils/data_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CovidBarChart extends StatelessWidget {

  final List<Covid19StatisticsModel> covidDatas;
  final double maxY;
  const CovidBarChart({Key? key, required this.maxY,required this.covidDatas}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY*1.5,
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipPadding: const EdgeInsets.all(0),
            tooltipMargin: 8,
            getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
                ) {
              return BarTooltipItem(
                rod.y.round().toString(),
                TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            // getTextStyles: (value) => const TextStyle(color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
            margin: 20,
            getTitles: (double value) {
              return DataUtils.simpleDayFormat(covidDatas[value.toInt()].stateDt!);
            },
          ),
          leftTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: this.covidDatas.map<BarChartGroupData>((covidData){
         return  BarChartGroupData(
                  x: x++,
                  barRods: [
                    BarChartRodData(
                        y: covidData.calcDecideCnt,
                        colors: [Colors.lightBlueAccent, Colors.greenAccent])
                  ],
                  showingTooltipIndicators: [0],
                );
        }).toList()
        // barGroups: [
        //   BarChartGroupData(
        //     x: 0,
        //     barRods: [
        //       BarChartRodData(
        //           y: 8,
        //           colors: [Colors.lightBlueAccent, Colors.greenAccent])
        //     ],
        //     showingTooltipIndicators: [0],
        //   ),
        //   BarChartGroupData(
        //     x: 1,
        //     barRods: [
        //       BarChartRodData(
        //           y: 10,
        //           colors: [Colors.lightBlueAccent, Colors.greenAccent])
        //     ],
        //     showingTooltipIndicators: [0],
        //   ),
        //   BarChartGroupData(
        //     x: 2,
        //     barRods: [
        //       BarChartRodData(
        //           y: 14,
        //           colors: [Colors.lightBlueAccent, Colors.greenAccent])
        //     ],
        //     showingTooltipIndicators: [0],
        //   ),
        //   BarChartGroupData(
        //     x: 3,
        //     barRods: [
        //       BarChartRodData(
        //           y: 15,
        //           colors: [Colors.lightBlueAccent, Colors.greenAccent])
        //     ],
        //     showingTooltipIndicators: [0],
        //   ),
        //   BarChartGroupData(
        //     x: 3,
        //     barRods: [
        //       BarChartRodData(
        //           y: 13,
        //           colors: [Colors.lightBlueAccent, Colors.greenAccent])
        //     ],
        //     showingTooltipIndicators: [0],
        //   ),
        //   BarChartGroupData(
        //     x: 3,
        //     barRods: [
        //       BarChartRodData(
        //           y: 10,
        //           colors: [Colors.lightBlueAccent, Colors.greenAccent])
        //     ],
        //     showingTooltipIndicators: [0],
        //   ),
        // ],
      ),
    );
  }
}

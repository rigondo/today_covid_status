import 'package:covid/src/canvas/arrow_clip_path.dart';
import 'package:covid/src/controller/covid_statistics_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component/bar_chart.dart';
import 'component/covid_statistics_viewer.dart';

class App extends GetView<CovidStatisticsController> {
  late double headerTopZone;

  Widget infoWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            " : ${value}",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  List<Widget> _background() {
    return [
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
              Color(0xff7859A8),
              Color(0xff8977AD),
            ])),
      ),
      Positioned(
        left: -90,
        top: headerTopZone + 40,
        child: Container(
          child: Image.asset(
            'assets/corona.png',
            width: Get.size.width * 0.6,
          ),
        ),
      ),
      Positioned(
        top: headerTopZone + 3,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff7c3fd2),
            ),
            child: Obx(() => Text(controller.todayData.standardDayString,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ))),
          ),
        ),
      ),
      Positioned(
        top: headerTopZone + 70,
        right: 40,
        child: Obx(
          () => CovidStatisticsViewer(
            title: '확진자',
            titleColor: Colors.white,
            addedCount: controller.todayData.calcDecideCnt,
            totalCount: controller.todayData.decideCnt??0,
            subValueColor: Colors.white,
            upDown:
                controller.calculrateUpDown(controller.todayData.calcDecideCnt),
          ),
        ),
      )
    ];
  }

  Widget _todayStatistics() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: CovidStatisticsViewer(
              title: '격리해제',
              addedCount: controller.todayData.calcClearCnt,
              totalCount: controller.todayData.clearCnt??0,
              upDown: controller
                  .calculrateUpDown(controller.todayData.calcClearCnt),
              dense: true,
            ),
          ),
          Container(
            height: 60,
            child: VerticalDivider(
              color: Color(0xffc7c7c7),
            ),
          ),
          Expanded(
            child: CovidStatisticsViewer(
              title: '검사 중',
              addedCount: controller.todayData.calcExamCnt,
              totalCount: controller.todayData.examCnt??0,
              upDown:
                  controller.calculrateUpDown(controller.todayData.calcExamCnt),
              dense: true,
            ),
          ),
          Container(
            height: 60,
            child: VerticalDivider(
              color: Color(0xffc7c7c7),
            ),
          ),
          Expanded(
            child: CovidStatisticsViewer(
              title: '사망자',
              addedCount: controller.todayData.calcDeathCnt,
              totalCount: controller.todayData.deathCnt??0,
              upDown: controller
                  .calculrateUpDown(controller.todayData.calcDeathCnt),
              dense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _covidTrendChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '확진자 추이',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        AspectRatio(
          aspectRatio: 1.7,
          child: Obx(
            () => controller.weekDays.length == 0
                ? Container() : CovidBarChart(
              covidDatas: controller.weekDays,
              maxY : controller.maxDecideValue,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    headerTopZone = Get.mediaQuery.padding.top + AppBar().preferredSize.height;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/rigondo.jpg'),
                backgroundColor: Colors.white,
              ),
              accountName: Text('제작자 : rigondo',
              style: TextStyle(color: Colors.white),),
              accountEmail: Text('git hub : https://github.com/rigondo',
                style: TextStyle(color: Colors.white),),
              decoration: BoxDecoration(
                color: Color(0xff8977AD),
              ),
            )

          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: Icon(
        //   Icons.menu,
        //   color: Colors.white,
        // ),
        title: Text(
          '오늘의 코로나',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        ..._background(),
        Positioned(
          top: headerTopZone + 200,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    _todayStatistics(),
                    SizedBox(
                      height: 20,
                    ),
                    _covidTrendChart(),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

import 'package:covid/src/utils/data_utils.dart';
import 'package:xml/xml.dart';

class Covid19StatisticsModel {
  double? accDefRate;
  double? accExamCnt;
  double? accExamCompCnt;
  double? careCnt;
  double? clearCnt;
  double calcClearCnt=0;
  double? deathCnt;
  double calcDeathCnt=0;
  double? decideCnt;
  double calcDecideCnt=0;
  double? examCnt;
  double calcExamCnt=0;
  double? resutlNegCnt;
  double? seq;
  String? createDt;
  DateTime? stateDt;
  String? stateTime;
  String? updateDt;
  Covid19StatisticsModel({
    this.accDefRate,
    this.accExamCnt,
    this.accExamCompCnt,
    this.careCnt,
    this.clearCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.examCnt,
    this.resutlNegCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19StatisticsModel.empty(){
    return Covid19StatisticsModel();
  }



  factory Covid19StatisticsModel.fromXml(XmlElement xml) {
    return Covid19StatisticsModel(
      accExamCnt: XmlUtils.searchResultForDouble(xml, 'accDefRate'),
      accDefRate: XmlUtils.searchResultForDouble(xml, 'accDefRate'),
      accExamCompCnt: XmlUtils.searchResultForDouble(xml, 'accExamCompCnt'),
      careCnt: XmlUtils.searchResultForDouble(xml, 'careCnt'),
      clearCnt: XmlUtils.searchResultForDouble(xml, 'clearCnt'),
      createDt: XmlUtils.searchResultForString(xml, 'createDt'),
      deathCnt: XmlUtils.searchResultForDouble(xml, 'deathCnt'),
      decideCnt: XmlUtils.searchResultForDouble(xml, 'decideCnt'),
      examCnt: XmlUtils.searchResultForDouble(xml, 'examCnt'),
      resutlNegCnt: XmlUtils.searchResultForDouble(xml, 'resutlNegCnt'),
      seq: XmlUtils.searchResultForDouble(xml, 'seq'),
      stateDt: XmlUtils.searchResultForString(xml, 'stateDt')!=''? DateTime.parse(XmlUtils.searchResultForString(xml, 'stateDt')) : null,
      stateTime: XmlUtils.searchResultForString(xml, 'stateTime'),
      updateDt: XmlUtils.searchResultForString(xml, 'updateDt'),
    );
  }

  void updateDtCalcAboutYesterday(Covid19StatisticsModel yesterDayData) {
    _updateCalcClearCnt(yesterDayData.clearCnt!);
    _updateCalcDeathCnt(yesterDayData.deathCnt!);
    _updateCalcDecideCnt(yesterDayData.decideCnt!);
    _updateCalcExamCnt(yesterDayData.examCnt!);

  }

  void _updateCalcDecideCnt(double beforeCnt) {
    calcDecideCnt = decideCnt! - beforeCnt;

  }
  void _updateCalcExamCnt(double beforeCnt) {
    calcExamCnt = examCnt! - beforeCnt;

  }
  void _updateCalcDeathCnt(double beforeCnt) {
    calcDeathCnt = deathCnt! - beforeCnt;

  }
  void _updateCalcClearCnt(double beforeCnt) {
    calcClearCnt = clearCnt! - beforeCnt;

  }

  String get standardDayString => stateDt == null ? '' :
      '${DataUtils.simpleDayFormat(stateDt!)} $stateTime 기준';

}

class XmlUtils {
  static String searchResultForString(XmlElement xml, String key) {
    return xml.findAllElements(key).map((e) => e.text).isEmpty
        ? ""
        : xml.findAllElements(key).map((e) => e.text).first;
  }
  static double searchResultForDouble(XmlElement xml, String key) {
    return xml.findAllElements(key).map((e) => e.text).isEmpty
        ? 0
        : double.parse(xml.findAllElements(key).map((e) => e.text).first);
  }
}

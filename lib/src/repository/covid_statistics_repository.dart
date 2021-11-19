import 'package:covid/src/model/covid_statistics.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  late var _dio;

  CovidStatisticsRepository() {
    _dio =
        Dio(BaseOptions(baseUrl: 'http://openapi.data.go.kr', queryParameters: {
      'ServiceKey':
          'xNBE7/0w2ba5sOordmPdk8SR8bp1ZV98dzFYdASZ/qNaFz6Q+10B1ZQBw/aEKyt15V81pHP0xRzcGmNzaHywsg=='
    }));
  }

  Future<List<Covid19StatisticsModel>> fetchCovid19Statistics({String? startDate, String? endDate}) async {
    var query = Map<String, String>();
    if(startDate!=null) query.putIfAbsent('startCreateDt', () => startDate);
    if(endDate!=null) query.putIfAbsent('endCreateDt', () => endDate);
    var response =
        await _dio.get('/openapi/service/rest/Covid19/getCovid19InfStateJson',
            queryParameters: query);
    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');
    if (results.isNotEmpty) {
      return results.map<Covid19StatisticsModel>((element)=>Covid19StatisticsModel.fromXml(element)).toList();
    } else {
      return Future.value(null);
    }
  }
}

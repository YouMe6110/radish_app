import 'package:dio/dio.dart';
import 'package:radish_app/constants/keys.dart';
import 'package:radish_app/data/address_model.dart';
import 'package:radish_app/utils/logger.dart';

class AddressService {

  // string타입 검색주소 api 데이터 받기
  Future<AddressModel> SearchAddressByStr(String text) async {
    final formData = {
      'key' : VWORLD_KEY,
      'request' : 'search',
      'type' : 'ADDRESS',
      'category' : 'ROAD',
      'query' : text,
      'size' : 30,
    };

    // http통신 응답결과 받기
    final response = await Dio().get(
        'http://api.vworld.kr/req/search',
        queryParameters: formData)
        .catchError((e){
      logger.e(e.message);
    });
    // 응답결과 확인
    logger.d(response);
    logger.d(response.data["response"]['result']);

    //api 오브젝트 모델 연동
    AddressModel addressModel =
    AddressModel.fromJson(response.data["response"]);
    logger.d(addressModel);

    return addressModel;

  }

}
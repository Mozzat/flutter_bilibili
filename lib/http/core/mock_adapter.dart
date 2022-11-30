import 'package:flutter_bilibili/http/core/hi_net_adapter.dart';
import 'package:flutter_bilibili/http/request/base_requeset.dart';

///测试适配器
///

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse({"code": "0", "message": "success"} as T, 200);
    });
  }
}

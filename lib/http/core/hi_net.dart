import 'package:flutter_bilibili/http/core/hi_errror.dart';
import 'package:flutter_bilibili/http/core/hi_net_adapter.dart';
import 'package:flutter_bilibili/http/core/mock_adapter.dart';
import 'package:flutter_bilibili/http/request/base_requeset.dart';

class HiNet {
  HiNet._privateConstructor();
  static final HiNet _instnace = HiNet._privateConstructor();
  static HiNet get instace {
    return _instnace;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;

    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      ///其他异常
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }

    var result = response?.data;
    printLog(result);

    var status = response?.statusCode ?? 0;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status, result.toString(), data: result);
    }

    // var response = await send(request);
    // var result = response["data"];
    // print(result);
    // return result;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    // printLog('url:${request.url()}');
    // printLog('mehtod:${request.httpMethod()}');
    // request.addHeader("token", "123");
    // printLog('url:${request.header}');
    // return Future.value({
    //   "statusCode": "200",
    //   "data": {"code": "0", "message": "success"}
    // });

    ///使用Mock发送请求
    HiNetAdapter adapter = MockAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print("hiNet:${log.toString()}");
  }
}

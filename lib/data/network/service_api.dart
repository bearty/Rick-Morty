import 'package:dio/dio.dart';

class ServiceApi {
  static final mainServer = "http://173.249.20.184:7001/api/";
  Dio dio = Dio(BaseOptions(
    baseUrl: mainServer,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));

  initialSettings() {
    Interceptors interceptors = dio.interceptors;
    interceptors.requestLock.lock();
    interceptors.clear();

    interceptors.add(
      InterceptorsWrapper(
        /// Обрабатываем ошибки
        onResponse: (response, handler) {
          if (response.statusCode == 204) {
            throw DioError(
              error: "Отсутствуют данные",
              requestOptions: response.requestOptions,
              response: Response(
                statusCode: 400,
                data: response.data,
                requestOptions: response.requestOptions,
              ),
            );
          }
        },
        onError: (DioError error, handler) async {
          if (error.type == DioErrorType.connectTimeout) {
            throw DioError(
              error: "Сервер не отвечает попробуйте еще раз",
              requestOptions: error.requestOptions,
              response: Response(
                statusCode: 400,
                data: error.response.data,
                requestOptions: error.requestOptions,
              ),
            );
          } else if (error.message.contains("SocketException:")) {
            throw DioError(
              error: "Отсутствует интернет соединение",
              requestOptions: error.requestOptions,
              response: Response(
                statusCode: 400,
                data: error.response.data,
                requestOptions: error.requestOptions,
              ),
            );
          } else if (error.response.statusCode == 401) {
            print('Error 401');
            print(error);
            /*ErrorHandler().showError(
              DioError(error: ErrorHandlerType.auth, requestOptions: error.requestOptions),
            );*/
          }
          return error;
        },
      ),
    );

    /// Добавляем настройки логов
    interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));

    /// Разблокируем запрос
    interceptors.requestLock.unlock();
  }
}

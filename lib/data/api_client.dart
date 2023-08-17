import 'package:dio/dio.dart';
import 'package:floordatabaseproject/constants/api_const.dart';
import 'package:floordatabaseproject/data/entity/person_entity.dart';
import 'package:floordatabaseproject/service/log_service.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppConstants.devUrl)
abstract class ApiClient {
  static Dio get getDio {
    Dio dio = Dio(BaseOptions(followRedirects: false));

    if (kDebugMode) {
      /// chuck interceptor
      // dio.interceptors.add(chuck.getDioInterceptor());

      /// log with Log Interceptor
      // dio.interceptors.add(
      //   LogInterceptor(
      //     responseBody: true,
      //     requestBody: true,
      //     request: true,
      //   ),
      // );

      /// log with log service
      dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              LogService.instance.info("On Request\n"
                  "Method: ${options.method}\n"
                  "Url: ${options.uri}\n"
                  "Headers: ${options.headers}\n"
              );
              LogService.instance.info(options.data);
              return handler.next(options);
            },

            onResponse: (response, handler) {
              LogService.instance.warning("On Response\n"
                  "Status code: ${response.statusCode}\n"
                  "Url: ${response.realUri}"
              );
              LogService.instance.warning(response.data);
              return handler.next(response);
            },

            onError: (error, handler) {
              LogService.instance.error("On Error\n"
                  "Status code: ${error.response?.statusCode}\n"
                  "Url: ${error.response?.realUri}"
              );
              LogService.instance.error("Message: ${error.response}");
              return handler.next(error);
            },
          )
      );
    }

    /// Tries the last error request again.
    // dio.interceptors.add(
    //   RetryInterceptorCustom(
    //     dio: dio,
    //     toNoInternetPageNavigator: () async {},
    //     accessTokenGetter: () => LocalSource.instance.getAccessToken(),
    //     refreshTokenFunction: BaseFunctions.refreshToken,
    //     forbiddenFunction: BaseFunctions.refreshToken,
    //   ),
    // );

    return dio;
  }

  static ApiClient? _apiClient;

  static ApiClient getAuthInstance({String baseUrl = AppConstants.devUrl}) {
    // if (LocalSource.instance.getDevStagingStatus()) {
    //   baseUrl = AppConstants.authUrl;
    // } else {
    //   baseUrl = AppConstants.authUrlDev;
    // }
    // if (_authClient != null) {
    //   removeApiClient();
    // }
    _apiClient = ApiClient(getDio, baseUrl);
    return _apiClient!;
  }

  factory ApiClient(Dio dio, String baseUrl) {
    dio.options = BaseOptions(
      receiveTimeout: const Duration(milliseconds: 30000),
      connectTimeout: const Duration(milliseconds: 30000),
    );
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET("floor/todo")
  Future<List<PersonEntity>> getPersonData();

}
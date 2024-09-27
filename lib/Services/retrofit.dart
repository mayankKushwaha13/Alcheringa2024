import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'retrofit.g.dart'; 

@RestApi(baseUrl: "")
abstract class RetrofitService {
  factory RetrofitService(Dio dio, {String? baseUrl}) = _RetrofitService;

  @FormUrlEncoded()
  @POST("formResponse")
  Future<void> dataToExcel(@Body() Map<String, dynamic> fields);

  @GET("get_data")
  Future<String> getData(@Query("email") String email);
}

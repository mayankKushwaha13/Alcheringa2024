import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'retrofit.g.dart'; 

@RestApi(baseUrl: "")
abstract class RetrofitService {
  factory RetrofitService(Dio dio, {String? baseUrl}) = _RetrofitService;

  @FormUrlEncoded()
  @POST("formResponse")
  Future<void> dataToExcel(@Field("key1") String key1, @Field("key2") String key2);

  @GET("get_data")
  Future<String> getData(@Query("email") String email);
}

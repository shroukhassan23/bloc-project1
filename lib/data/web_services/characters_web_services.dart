import 'package:dio/dio.dart';
import 'package:flutter_bloc1/data/model/character.dart';
import 'package:flutter_bloc1/constants/strings.dart';

class characterswebServices {
  //*get the data from server and send to repository
  late Dio
      dio; /* //?late because we gave it soon //instance of dio */ //we can use http instead of dio
  characterswebServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true, //*gave information  when recieve error
      connectTimeout: Duration(seconds: 20), //*time to connect
      receiveTimeout: Duration(seconds: 20), //*time to try to connect to server
    );
    dio = Dio(baseOptions); //*gave the options to dio
  }
  Future<dynamic> getAllcharacters() async {
    //*method to get characters from the internet to web services
    try {
      Response response =
          await dio.get("character"); //*get characters//end point
      //  print(response.data.toString()); //print the response//to verify that data is get from internet
      return response.data; //DONE---------
    } catch (e) {
      // character ch = character();
      print(e.toString());
      return {};
    }
  }
}

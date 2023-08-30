import 'package:flutter/material.dart';
import 'package:flutter_bloc1/data/model/character.dart';
import 'package:flutter_bloc1/constants/Strings.dart';
import 'package:flutter_bloc1/data/web_services/characters_web_services.dart';
import 'dart:convert';

class characters_repository {
  final characterswebServices
      characterWebServices; //////////*instance of web service class to take data from web service to repository */
  characters_repository({
    required this.characterWebServices,
  }); //!List<character>
  Future<List<Results>?> getAllcharacters() async {
    //*method to get characters from web service
    final characters = await characterWebServices
        .getAllcharacters(); //*get characters from web services and store it in characetrs
    final ch1 = character.fromJson(characters); //!
    /* final chh =
        characters.map((Character) => character.fromJson(Character)).toList();
    print(chh);*/
    //print(ch1.results);//to verify the results is correct
    return ch1.results; //DONE!---->//return List<Results>
/*final ch1 = jsonEncode(characters);
     Map<String, dynamic> decodedDoughnut = jsonDecode(ch1);
     print(jsonDecode(decodedDoughnut["results"]));
    print(ch1);
   final ch = //   characters.map((Character) => character.fromJson(Character)).toList();
  return characters.results;*/
  }
}

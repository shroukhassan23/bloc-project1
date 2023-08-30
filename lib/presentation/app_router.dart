import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc1/business_logic/cubit/cubit_cubit.dart';
import 'package:flutter_bloc1/constants/Strings.dart';
import 'package:flutter_bloc1/data/model/character.dart';
import 'package:flutter_bloc1/data/repository/characters_repository.dart';
import 'package:flutter_bloc1/data/web_services/characters_web_services.dart';
import 'package:flutter_bloc1/main.dart';
import 'package:flutter_bloc1/presentation/screens/character_details.dart';
import 'package:flutter_bloc1/presentation/screens/characters_screen.dart';

class Approuter {
  late characters_repository
      characterrepository; //*instance of character repository
  late CubitCubit charactersCubit; //*instance of cubit
  Approuter() {
    characterrepository = characters_repository(
        characterWebServices:
            characterswebServices()); //*instantiate the character repository
    charactersCubit = CubitCubit(characterrepository); //*instantiate cubit
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterscreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext contxt) => charactersCubit,
            child: const characters_screen(),
          ),
        ); //*create the bloc

      case character_details:
        final result = settings.arguments
            as Results; //to convert from characters screen to details screen
        return MaterialPageRoute(
            builder: (_) => Character_details(
                  result: result,
                ));

      default:
    }
  }
}

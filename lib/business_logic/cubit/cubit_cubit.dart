import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc1/data/model/character.dart';
import 'package:flutter_bloc1/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';
part 'cubit_state.dart';

class CubitCubit extends Cubit<CubitState> {
  final characters_repository charactersrepository;
  List<Results>?
      characterslist; //******instance of class character repository to send from repository to cubit *******//
  CubitCubit(this.charactersrepository) : super(CubitInitial());
  Future<List<Results>?> getAllcharacters() async {
    await charactersrepository.getAllcharacters().then((characterslist) {
      //get characters list from repository and store it in character list
      emit(
        charactersloaded(characterss: characterslist),
      );
      this.characterslist = characterslist;
    });
    return characterslist;
  }
}

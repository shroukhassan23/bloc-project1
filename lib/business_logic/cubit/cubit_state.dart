part of 'cubit_cubit.dart';

@immutable
abstract class CubitState {}

class CubitInitial extends CubitState {}

class charactersloaded extends CubitState {
  //*if characters loaded appear the list of characters
//  final List<Results>? characterss;
  final List<Results>? characterss;
  charactersloaded({
    required this.characterss,
  });
}

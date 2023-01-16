part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUser extends UserEvent {
  GetUser();
}

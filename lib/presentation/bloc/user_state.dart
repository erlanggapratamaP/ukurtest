// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

@immutable
abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final List<User>? user;
  const UserLoaded(this.user);

  @override
  bool operator ==(covariant UserLoaded other) {
    if (identical(this, other)) return true;

    return other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class UserError extends UserState {
  final String message;
  const UserError(this.message);

  @override
  bool operator ==(covariant UserError other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

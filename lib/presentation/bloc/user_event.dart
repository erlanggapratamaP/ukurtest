part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUser extends UserEvent {
  GetUser();
}

class LoadMore extends UserEvent {
  LoadMore();
}

class RefreshList extends UserEvent {
  RefreshList();
}

class FilterUser extends UserEvent {
  final bool? isActive;
  final String? gender;
  final String? starDate;
  final String? endDate;
  FilterUser({this.isActive, this.gender, this.starDate, this.endDate});
}

class SearchUser extends UserEvent {
  final String? search;
  SearchUser(this.search);
}

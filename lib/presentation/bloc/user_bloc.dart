import 'package:fake_json/data/data.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _dateRange = BehaviorSubject<DateTimeRange>();
  final _dateStart = BehaviorSubject<String>();
  final _dateEnd = BehaviorSubject<String>();
  final _isChecked = BehaviorSubject<bool>();
  final _valueGender = BehaviorSubject<String>();
  Stream<DateTimeRange> get dateRange => _dateRange.stream;
  Stream<String> get dateStart => _dateStart.stream;
  Stream<String> get dateEnd => _dateEnd.stream;
  Stream<bool> get isChecked => _isChecked.stream;
  Stream<String> get valueGender => _valueGender.stream;
  setDateRange(DateTimeRange data) {
    _dateRange.sink.add(data);
  }

  setDateStart(String data) {
    _dateStart.sink.add(data);
  }

  setDateEnd(String data) {
    _dateEnd.sink.add(data);
  }

  setIsChecked(bool data) {
    _isChecked.sink.add(data);
  }

  setValueGender(String data) {
    _valueGender.sink.add(data);
  }

  initItems() {
    _isChecked.sink.add(false);
    _valueGender.sink.add("Male");
  }

  final UserRepository _userRepository;
  List<String> listGender = <String>['Male', 'Female'];

  //current page
  int _currentPage = 0;

  UserBloc(this._userRepository) : super(UserInitial()) {
    on<UserEvent>(_onUserEvent);
  }

  _onUserEvent(
    UserEvent event,
    Emitter<UserState> emit,
  ) async {
    debugPrint(event.toString());

    if (event is GetUser) {
      _currentPage = 0;
      try {
        emit(UserLoading());
        final user = await _userRepository.mockUsers(_currentPage);

        if (user != null) {
          emit(UserLoaded(user: user));
        } else {
          emit(const UserError("Data Tidak Ada"));
        }
      } on Exception {
        emit(const UserError("Couldn't fetch user. Is the device online?"));
      }
    } else if (event is LoadMore) {
      if (_currentPage < 2) {
        try {
          _currentPage++;
          emit(UserLoading());
          var user = await _userRepository.mockUsers(_currentPage);
          await Future.delayed(const Duration(seconds: 2));
          if (user != null) {
            emit(UserLoaded(user: user));
          } else {
            emit(const UserError("Data Tidak Ada"));
          }
        } on Exception {
          emit(const UserError("Couldn't fetch user. Is the device online?"));
        }
      }
    } else if (event is RefreshList) {
      if (_currentPage > 0) {
        _currentPage--;
        try {
          emit(UserLoading());
          final user = await _userRepository.mockUsers(_currentPage);
          if (user != null) {
            emit(UserLoaded(user: user));
          } else {
            emit(const UserError("Data Tidak Ada"));
          }
        } on Exception {
          emit(const UserError("Couldn't fetch user. Is the device online?"));
        }
      }
    } else if (event is FilterUser) {
      try {
        emit(UserLoading());
        var user = await getAllForFilter();

        if (event.starDate!.isNotEmpty && event.endDate!.isNotEmpty) {
          user = await _dateFilter(event, user);
          emit(UserLoaded(user: user));
        }
        if (event.gender != "") {
          user = await _genderFilter(event, user);
          emit(UserLoaded(user: user));
        }

        if (event.isActive == true) {
          user = await _activeFilter(event, user);
          emit(UserLoaded(user: user));
        } else {
          emit(UserLoaded(user: user));
        }
      } on Exception {
        emit(const UserError("Couldn't fetch user. Is the device online?"));
      }
    } else if (event is SearchUser) {
      try {
        emit(UserLoading());
        var user = await getAllForFilter();
        if (event.search != "") {
          user = await _searchFilter(user, event.search ?? "");
          emit(UserLoaded(user: user));
        } else {
          _currentPage = 0;
          var data = await _userRepository.mockUsers(_currentPage);
          emit(UserLoaded(user: data ?? []));
        }
      } on Exception {
        emit(const UserError("Couldn't fetch user. Is the device online?"));
      }
    }
  }

  Future<List<User>> _searchFilter(List<User> users, String search) async {
    users = users.where((element) {
      return (element.profile!.name!
              .toUpperCase()
              .contains(search.toUpperCase()) ||
          element.company!.toUpperCase().contains(search.toUpperCase()));
    }).toList();
    return users;
  }

  Future<List<User>> getAllForFilter() async {
    List<User> filteredUser = [];
    _currentPage = 0;
    for (var i = 0; i < 3; i++) {
      var data = await _userRepository.mockUsers(i);
      filteredUser.addAll(data!);
      _currentPage++;
    }
    return filteredUser;
  }

  Future<List<User>> _dateFilter(FilterUser event, List<User> users) async {
    users = users.where((element) {
      //convert date time
      var parsedDate = DateTime.parse(element.registered!);
      String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
      var registeredDate =
          DateFormat('dd-MM-yyyy').parse(formattedDate.toString());
      //get datetime from start and end date
      DateTime parsedStartDate =
          DateFormat('dd-MM-yyyy').parse(event.starDate!);
      DateTime parsedEndDate = DateFormat('dd-MM-yyyy').parse(event.endDate!);
      return (registeredDate.isAfter(parsedStartDate) &&
          registeredDate.isBefore(parsedEndDate));
    }).toList();
    return users;
  }

  Future<List<User>> _genderFilter(FilterUser event, List<User> users) async {
    users = users.where((element) {
      return (element.profile!.gender!.toString().toUpperCase() ==
          event.gender!.toUpperCase());
    }).toList();
    return users;
  }

  Future<List<User>> _activeFilter(FilterUser event, List<User> users) async {
    users = users.where((element) {
      return (element.isActive! == true);
    }).toList();
    return users;
  }
}

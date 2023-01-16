import 'package:bloc/bloc.dart';
import 'package:fake_json/data/data.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserInitial());
  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUser) {
      try {
        yield const UserLoading();
        final user = await _userRepository.getusers(0);
        yield UserLoaded(user);
      } on NetworkException {
        yield const UserError("Couldn't fetch user. Is the device online?");
      }
    }
  }
}

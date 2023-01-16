import 'package:fake_json/data/models/user.dart';
import 'package:fake_json/data/repositories/user_repository.dart';
import 'package:fake_json/presentation/bloc/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserBloc sut;
  late MockUserRepository mockUserRepository;
  late List<User>? dataUser;
  setUp(() async {
    sut = MockUserBloc();
    mockUserRepository = MockUserRepository();
    dataUser = [];
  });
  // test(
  //   "get user bloc check",
  //   () async {
  //     final userBloc = MockUserBloc();
  //     final userRepo = MockUserRepository();
  //     whenListen(userBloc, Stream.fromIterable([]), initialState: []);

  //     // Assert that the initial state is correct.
  //     expect(userBloc.state, equals([]));

  //     // Assert that the stubbed stream is emitted.
  //     await expectLater(userBloc.stream, emitsInOrder([]));

  //     // Assert that the current state is in sync with the stubbed stream.
  //     expect(userBloc.state, equals([]));

  //   },
  // );

  blocTest('emits [UserState] when GetUser is added',
      build: () => sut,
      setUp: () async {
        dataUser = await mockUserRepository.getusers(0);
      },
      act: (bloc) => bloc.add(GetUser()),
      expect: () => [isA<UserState>()],
      verify: (_) {
        verify(() => mockUserRepository.getusers(0)).called(1);
      });
}

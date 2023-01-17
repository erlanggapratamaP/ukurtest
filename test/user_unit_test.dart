import 'package:dio/dio.dart';
import 'package:fake_json/data/models/user.dart';
import 'package:fake_json/data/repositories/user_repository.dart';
import 'package:fake_json/presentation/bloc/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late MockUserRepository mockUserRepository;
  late MockUserBloc sut;
  const userUrl =
      'https://c50f007f-bad3-4e64-982d-fce35e877b09.mock.pstmn.io/users?page=0';
  setUp(() async {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    sut = MockUserBloc();
    mockUserRepository = MockUserRepository();
  });
  List<User> data = [
    User(
      id: '63c15a89129002ec6b5caa63',
      isActive: true,
      profile: Profile(
          picture: 'https://api.multiavatar.com/West.png',
          age: 31,
          eyeColor: 'blue',
          name: 'Lila Villarreal',
          gender: 'female',
          email: 'lilavillarreal@zomboid.com',
          phone: '+1 (949) 471-3282',
          address: '670 Strickland Avenue, Ada, Palau, 795'),
      company: 'HATOLOGY',
      about:
          'Esse incididunt Lorem magna sint ex amet aliqua irure et ex quis sit tempor. Culpa adipisicing laboris amet minim laboris cupidatat in ad ipsum. Amet pariatur commodo voluptate cupidatat ex aliquip magna ea dolor. Tempor tempor aliqua est Lorem nisi qui ex velit cupidatat duis adipisicing nostrud. Dolor elit sit elit exercitation consectetur tempor ipsum culpa aliqua. Anim exercitation tempor in ullamco aliqua duis sint anim irure pariatur dolore duis velit Lorem.\r\n',
      registered: '2015-08-19T04:31:19',
    )
  ];
  group('Testing Fetch User', () {
    blocTest(
      'when data is empty',
      build: () {
        when(() => mockUserRepository.mockUsers(0)).thenAnswer((_) async => []);
        return UserBloc(mockUserRepository);
      },
      act: (UserBloc bloc) => bloc.add(GetUser()),
      expect: () => [UserLoading(), const UserLoaded(user: [])],
    );

    blocTest(
      'when data is users',
      build: () {
        when(() => mockUserRepository.mockUsers(0))
            .thenAnswer((_) async => data);
        return UserBloc(mockUserRepository);
      },
      act: (UserBloc bloc) => bloc.add(GetUser()),
      expect: () => [UserLoading(), UserLoaded(user: data)],
    );

    blocTest(
      'when data is error',
      build: () {
        when(() => mockUserRepository.mockUsers(0))
            .thenThrow(NetworkException());
        return UserBloc(mockUserRepository);
      },
      act: (UserBloc bloc) => bloc.add(GetUser()),
      expect: () => [
        UserLoading(),
        const UserError("Couldn't fetch user. Is the device online?")
      ],
    );
  });
}

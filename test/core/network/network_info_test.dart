import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/features/core/network/network_info.dart';

@GenerateNiceMocks([MockSpec<InternetConnection>()])
import 'network_info_test.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnection mockInternetConnection;

  setUp(() {
    mockInternetConnection = MockInternetConnection();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnection);
  });

  group('is Connected', () {
    test('should forward the call to internetConnection.hasInternetAccess',
        () async {
      //arrange
      //*For Future.value(true) override referential equality
      final tHasConnectionFuture = Future.value(true);
      when(mockInternetConnection.hasInternetAccess)
          .thenAnswer((_) => tHasConnectionFuture);
      //act
      final result = networkInfoImpl.isConnected;
      //assert
      verify(mockInternetConnection.hasInternetAccess);
      expect(result, tHasConnectionFuture);
    });
  });
}

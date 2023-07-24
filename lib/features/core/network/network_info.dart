import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../number_trivia/data/repositories/number_trivia_repository_impl.dart';

///Imagine that  you wanted to swap the internet connection checker package
/// for something completely different and if you use internet connection
/// package class is right inside [NumberTriviaRepositoryImpl] instead of
/// [NetworkInfo] and chances are if you are building more advance app
///you will have many many repositories than just one number
///[NumberTriviaRepositoryImpl] so you would basically stick this internet
///connection third party class into multiple places throughout your code base
/// so if you wanted swap that package and use something different you would
/// to need to change a lot of code and you would also need to re-test that
/// connectivity checking code because it's contained in multiple different
/// places so you don't know if those tests will work again and you would
/// need to just change a lot of production and also test code in order to make
/// that app work as before with the data connection checker package but if you
/// hide the internet connection checker package or whatever other package you
/// have under a custom contract(NetworkInfo) and also under custom
/// implementation of that (NetworkInfoImpl) of that contract now if you decide
/// that oh I'm not gonna use data connection checker package any more I'm
/// going to implement it myself or I'm going to use completely something
/// different now what happens is that you have just one point at which you have
/// to change the code should decide to you swap the internet connection checker
/// package
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection internetConnection;
  NetworkInfoImpl(this.internetConnection);

  @override
  Future<bool> get isConnected => internetConnection.hasInternetAccess;
}

import 'package:charityapp/singleton/Authenticator.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async{
  injector.registerSingleton<Authenticator>(Authenticator());
}


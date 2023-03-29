import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:ropstam_poc/data/local/home_api.dart';
import 'package:ropstam_poc/data/model/user_model.dart';
import 'package:ropstam_poc/data/repository/home_repository.dart';

import '../data/local/auth_api.dart';
import '../data/repository/auth_repository.dart';

List<SingleChildWidget> providers = [
  ...independentRemoteService,
  ...dependentService,
  ...uiConsumableProvidersSample,

  //home providers
  ...independentHomeService,
  ...dependentHomeService
];

List<SingleChildWidget> independentRemoteService = [
  Provider.value(value: AuthApi())
];
List<SingleChildWidget> dependentService = [
  ProxyProvider<AuthApi, AuthRepository>(
    update: (context, api, repo) => AuthRepository(localApi: api),
  ),
];

List<SingleChildWidget> uiConsumableProvidersSample = [
  StreamProvider<UserModel>(
    create: (context) =>
        Provider.of<AuthRepository>(context, listen: false).user,
    initialData: UserModel(id: ""),
  )
];

List<SingleChildWidget> independentHomeService = [
  Provider.value(value: HomeApi())
];
List<SingleChildWidget> dependentHomeService = [
  ProxyProvider<HomeApi, HomeRepository>(
    update: (context, value, previous) => HomeRepository(api: value),
  ),
];

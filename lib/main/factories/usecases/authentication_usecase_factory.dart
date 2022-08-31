import 'package:forum_devs_clean_architecture/data/usecases/usecases.dart';
import 'package:forum_devs_clean_architecture/domain/usecases/usecases.dart';
import 'package:forum_devs_clean_architecture/main/factories/factories.dart';


Authentication makeRemoteAuthentication() {

  return RemoteAuthentication(
      httpClient: makeHtppAdapter(),
      url: makeApiUrl('login'));

}
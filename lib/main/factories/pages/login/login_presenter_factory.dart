import 'package:forum_devs_clean_architecture/main/factories/factories.dart';
import 'package:forum_devs_clean_architecture/ui/pages/pages.dart';
import 'package:forum_devs_clean_architecture/ui/presentation/presenters/presenters.dart';


LoginPresenter makeStreamLoginPresenter() {

  return StreamLoginPresenter(
    authentication: makeRemoteAuthentication(),
    validation: makeLoginValidation()
  );

}


LoginPresenter makeGetxLoginPresenter() {

  return GetxLoginPresenter(
      authentication: makeRemoteAuthentication(),
      validation: makeLoginValidation()
  );

}
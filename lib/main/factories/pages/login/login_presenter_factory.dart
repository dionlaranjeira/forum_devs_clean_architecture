import 'package:forum_devs_clean_architecture/main/factories/factories.dart';
import 'package:forum_devs_clean_architecture/ui/pages/pages.dart';
import 'package:forum_devs_clean_architecture/ui/presentation/presenters/presenters.dart';


LoginPresenter makeLoginPresenter() {

  return StreamLoginPresenter(
    authentication: makeRemoteAuthentication(),
    validation: makeLoginValidation()
  );

}
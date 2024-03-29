import 'package:forum_devs_clean_architecture/ui/presentation/presenters/protocols/protocols.dart';
import 'package:forum_devs_clean_architecture/validations/validators/protocols/protocols.dart';
import 'package:meta/meta.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({@required String field, @required String value}) {

    String error;

    for(final validation in validations.where((element) => element.field == field)){
      error = validation.validate(value);

      if(error?.isNotEmpty == true){
        return error;
      }

    }

    return error;

  }
}
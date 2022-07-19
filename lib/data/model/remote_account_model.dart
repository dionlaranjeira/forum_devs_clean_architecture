import 'package:forum_devs_clean_architecture/data/http/http.dart';
import 'package:forum_devs_clean_architecture/domain/entities/entities.dart';

class RemoteAccountModel{
  final String accessToken;

  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map json){
    if(!json.containsKey('acessToken')){
    throw HttpError.invalidData;
    }
    return RemoteAccountModel(json['acessToken']);
  }

  AccountEntity toEntity() => AccountEntity(accessToken);
}
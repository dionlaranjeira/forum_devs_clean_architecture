import '../../data/http/http.dart';

class AccountEntity{
  final String token;

  AccountEntity(this.token);

  factory AccountEntity.fromJson(Map json){
    if(!json.containsKey('accessToken')){
      throw HttpError.invalidData;
    }
    return AccountEntity(json['accessToken']);}

}
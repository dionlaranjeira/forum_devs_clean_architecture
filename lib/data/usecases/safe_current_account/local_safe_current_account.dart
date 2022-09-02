import 'package:meta/meta.dart';

import 'package:forum_devs_clean_architecture/data/cache/cache.dart';
import 'package:forum_devs_clean_architecture/domain/entities/entities.dart';
import 'package:forum_devs_clean_architecture/domain/helpers/helpers.dart';
import 'package:forum_devs_clean_architecture/domain/usecases/usecases.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {

  final SaveSecureCacheStorage saveSecureCacheStorage;
  LocalSaveCurrentAccount({@required this.saveSecureCacheStorage});

  Future<void> save(AccountEntity account) async {

    try{
      await saveSecureCacheStorage.saveSecure(key: 'token', value: account.token);
    }catch(error){
      throw DomainError.unexpected;
    }

  }
}
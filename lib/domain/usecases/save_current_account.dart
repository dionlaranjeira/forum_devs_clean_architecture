import 'package:forum_devs_clean_architecture/domain/entities/entities.dart';

abstract class SaveCurrentAccount{

  Future<void> save(AccountEntity account);

}
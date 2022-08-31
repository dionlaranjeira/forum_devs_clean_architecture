import 'package:http/http.dart';

import 'package:forum_devs_clean_architecture/data/http/http.dart';
import 'package:forum_devs_clean_architecture/infra/http/http.dart';



HttpClient makeHtppAdapter() {

  final client = Client();
  return HttpAdapter(client);

}
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/show_list_model.dart';

class ShowApiProvider {
  Client client = Client();
  final _apiKey = '50ffc72540f1';

  Future<ShowListModel> fetchShowList() async {
    final response =
        await client.get(Uri.https('api.betaseries.com', 'shows/list', {
      'key': _apiKey,
      'order': 'popularity',
      'locale': 'en',
    }));
    // final response = await client.get('https://api.betaseries.com/shows/list?key=$_apiKey');
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ShowListModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
